resource "aws_instance" "dse-cassandra" {
  count = "${var.count}"
  ami = "${var.ami_id}"
  key_name = "datalake"
  instance_type = "${var.instance_type}"
  #iam_instance_profile = "${var.iam_instance_profile}"
  availability_zone = "${var.availability_zones[count.index % length(var.availability_zones)]}"
  subnet_id = "${var.subnet_ids[var.availability_zones[count.index % length(var.availability_zones)]]}"
  vpc_security_group_ids = [ "${var.sg_ids}" ]
  tags = {
    Name = "${format("%s-%d", var.tag_name, count.index + 1)}"
  }
}

resource "null_resource" "dse-cassandra-seeds" {
  count = "${length(var.availability_zones)}"

  triggers {
    private_ip = "${aws_instance.dse-cassandra.*.private_ip[count.index]}"
  }
}

resource "null_resource" "provision-dse-cassandra-ebs" {
  count = "${var.count}"
  
  depends_on = [ "aws_volume_attachment.dse-cassandra-ebs-data-attach", "aws_volume_attachment.dse-cassandra-ebs-commit-log-attach" ]

  connection {
    user = "${var.ssh_user}"
    host = "${aws_instance.dse-cassandra.*.private_ip[count.index]}"
    agent = true
    private_key = "${file("${var.ssh_identity_file}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/lib/cassandra/data",
      "sudo mkdir -p /var/lib/cassandra/commitlog",
      "sudo apt-get install xfsprogs -y",
      "sudo mkfs.xfs -f -s size=4096 -d sunit=8 -d swidth=256 /dev/xvdh",
      "sudo mkfs.xfs -f -s size=4096 -d sunit=8 -d swidth=256 /dev/xvdi",
      "sudo mount -t xfs /dev/xvdh /var/lib/cassandra/data",
      "sudo mount -t xfs /dev/xvdi /var/lib/cassandra/commitlog",
      "printf '/dev/xvdh\t/var/lib/cassandra/data\txfs\tdefaults\t0 0' | sudo tee --append /etc/fstab",
      "printf '/dev/xvdi\t/var/lib/cassandra/commitlog\txfs\tdefaults\t0 0' | sudo tee --append /etc/fstab"
    ]
  }
}

resource "null_resource" "provision-dse-cassandra" {
  count = "${var.count}"
  
  depends_on = [ "null_resource.provision-dse-cassandra-ebs" ]

  triggers {
    revision = "${var.rev}"
  }

  connection {
    user = "${var.ssh_user}"
    host = "${element(aws_instance.dse-cassandra.*.private_ip, count.index)}"
    agent = true
    private_key = "${file("${var.ssh_identity_file}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/cassy-up",
      "sudo service dse stop || true",
      "sudo rm -rf /tmp/cassy-up/*"
    ]
  }

  provisioner "file" {
    source = "${var.provisioning_scripts}/dse-cassandra"
    destination = "/tmp/cassy-up"
  }

  provisioner "file" {
    source = "${var.provisioning_scripts}/environments/aws/dse_cassandra.sh"
    destination = "/tmp/cassy-up/dse_cassandra.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'export CASSANDRA_CLUSTER_NAME=${var.cluster_name}' >> /tmp/cassy-up/dse_cassandra_params.sh",
      "echo 'export CASSANDRA_CONSISTENT_RANGEMOVEMENT=${var.consistent_rangemovement}' >> /tmp/cassy-up/dse_cassandra_params.sh",
      "echo 'export CASSANDRA_DC_SUFFIX=${var.dc_suffix}' >> /tmp/cassy-up/dse_cassandra_params.sh",
      "echo 'export CASSANDRA_SEEDS=${join(",", null_resource.dse-cassandra-seeds.*.triggers.private_ip)}' >> /tmp/cassy-up/dse_cassandra_params.sh",
      "echo 'export DATASTAX_EMAIL=${var.datastax_email}' >> /tmp/cassy-up/dse_cassandra_params.sh",
      "echo 'export DATASTAX_PASSWORD=${var.datastax_password}' >> /tmp/cassy-up/dse_cassandra_params.sh",
      "echo 'export DATASTAX_VERSION=${var.datastax_version}' >> /tmp/cassy-up/dse_cassandra_params.sh",
      "chmod -R a+x /tmp/cassy-up/*",
      "sudo /tmp/cassy-up/dse_cassandra.sh"
    ]
  }
}
