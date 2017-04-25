resource "aws_instance" "zookeeper" {
    count = "${var.zookeeper_count}"
    ami = "${var.zookeeper_ami_id}"
    key_name = "datalake"
    instance_type = "${var.zookeeper_instance_type}"
    iam_instance_profile = "${var.zookeeper_iam_instance_profile}"
    subnet_id = "${element(split(",", var.zookeeper_subnet_ids), count.index % length(split(",", var.zookeeper_subnet_ids)))}"
    vpc_security_group_ids = ["${split(",", var.zookeeper_sg_ids)}"]
    tags = {
      Name = "${format("%s-%d", var.zookeeper_tag_name, count.index + 1)}"
    }
}

resource "null_resource" "provision-zookeeper" {
  count = "${var.zookeeper_count}"

  triggers {
    revision = "${var.zookeeper_rev}"
  }

  connection {
    user = "${var.zookeeper_ssh_user}"
    host = "${element(aws_instance.zookeeper.*.private_ip, count.index)}"
    agent = true
    private_key = "${file("${var.zookeeper_ssh_identity_file}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/cassy-up",
      "sudo service zookeeper stop || true",
      "sudo rm -rf /opt/zookeeper/* || true",
      "sudo rm -rf /tmp/cassy-up/*",
      "sudo rm /etc/init.d/zookeeper || true"
    ]
  }

  provisioner "file" {
    source = "${var.zookeeper_provisioning_scripts}/oracle-jdk"
    destination = "/tmp/cassy-up"
  }

  provisioner "file" {
    source = "${var.zookeeper_provisioning_scripts}/environments/aws/oracle-jdk.sh"
    destination = "/tmp/cassy-up/oracle-jdk.sh"
  }

  provisioner "file" {
    source = "${var.zookeeper_provisioning_scripts}/apache-zookeeper"
    destination = "/tmp/cassy-up"
  }

  provisioner "file" {
    source = "${var.zookeeper_provisioning_scripts}/environments/aws/zookeeper.sh"
    destination = "/tmp/cassy-up/zookeeper.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "echo 'export ZOOKEEPER_MY_ID=${count.index+1}' >> /tmp/cassy-up/zookeeper_params.sh",
      "echo 'export ZOOKEEPER_SERVERS=${join(",", aws_instance.zookeeper.*.private_ip)}' >> /tmp/cassy-up/zookeeper_params.sh",
      "chmod -R a+x /tmp/cassy-up/*",
      "sudo /tmp/cassy-up/oracle-jdk.sh",
      "sudo /tmp/cassy-up/zookeeper.sh"
    ]
  }

  # Installation log
  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "source /tmp/cassy-up/zookeeper_params.sh",
      "source /tmp/cassy-up/apache-zookeeper/zookeeper-params.sh",
      "echo \"revision: ${var.zookeeper_rev}\" | sudo tee /opt/zookeeper/install.yaml",
      "echo \"zk:\" | sudo tee --append /opt/zookeeper/install.yaml",
      "echo \"  id: $ZOOKEEPER_MY_ID\" | sudo tee --append /opt/zookeeper/install.yaml",
      "echo \"  version: $ZOOKEEPER_VERSION\" | sudo tee --append /opt/zookeeper/install.yaml",
      "echo \"  dir: $ZOOKEEPER_DIR\" | sudo tee --append /opt/zookeeper/install.yaml",
      "echo \"  download_dir: $ZOOKEEPER_DOWNLOAD_DIR\" | sudo tee --append /opt/zookeeper/install.yaml",
      "echo \"  download_url: $ZOOKEEPER_URL\" | sudo tee --append /opt/zookeeper/install.yaml",
      "echo \"  install_dir: $ZOOKEEPER_INSTALL_DIR\" | sudo tee --append /opt/zookeeper/install.yaml",
      "echo \"  data_dir: $ZOOKEEPER_DATA_DIR\" | sudo tee --append $ZOOKEEPER_DIR/install.yaml",
      "echo \"  log_dir: $ZOOKEEPER_LOG_DIR\" | sudo tee --append $ZOOKEEPER_DIR/install.yaml"
    ]
  }
}
