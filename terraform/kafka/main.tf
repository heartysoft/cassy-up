resource "aws_instance" "kafka" {
  count = "${var.count}"
  ami = "${var.ami_id}"
  key_name = "datalake"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  subnet_id = "${element(var.subnet_ids, count.index % length(var.subnet_ids))}"
  vpc_security_group_ids = [ "${var.sg_ids}" ]
  tags = {
    Name = "${format("%s-%d", var.tag_name, count.index + 1)}"
  }
}

resource "null_resource" "provision-kafka-ebs" {
  count = "${var.count}"

  connection {
    user = "${var.ssh_user}"
    host = "${element(aws_instance.kafka.*.private_ip, count.index)}"
    agent = true
    private_key = "${file("${var.ssh_identity_file}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /var/lib/kafka",
      "sudo apt-get install xfsprogs -y",
      "sudo mkfs.xfs -f -s size=4096 -d sunit=8 -d swidth=256 /dev/xvdh",
      "sudo mount -t xfs /dev/xvdh /var/lib/kafka",
      "echo '/dev/xvdh /var/lib/kafka  xfs defaults    0   0' | sudo tee --append /etc/fstab"
    ]
  }
}

resource "null_resource" "provision-kafka" {
  count = "${var.count}"
  
  depends_on = ["null_resource.provision-kafka-ebs"]

  triggers {
    revision = "${var.rev}"
  }

  connection {
    user = "${var.ssh_user}"
    host = "${element(aws_instance.kafka.*.private_ip, count.index)}"
    agent = true
    private_key = "${file("${var.ssh_identity_file}")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/cassy-up",
      "sudo service kafka stop || true",
      "sudo rm -rf /opt/kafka/* || true",
      "sudo rm -rf /tmp/cassy-up/*",
      "sudo rm /etc/init.d/kafka || true"
    ]
  }

  provisioner "file" {
    source = "${var.provisioning_scripts}/oracle-jdk"
    destination = "/tmp/cassy-up"
  }

  provisioner "file" {
    source = "${var.provisioning_scripts}/environments/aws/oracle-jdk.sh"
    destination = "/tmp/cassy-up/oracle-jdk.sh"
  }

  provisioner "file" {
    source = "${var.provisioning_scripts}/apache-kafka"
    destination = "/tmp/cassy-up"
  }

  provisioner "file" {
    source = "${var.provisioning_scripts}/environments/aws/kafka.sh"
    destination = "/tmp/cassy-up/kafka.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'export KAFKA_BROKER_ID=${count.index+1}' >> /tmp/cassy-up/kafka_params.sh",
      "echo 'export KAFKA_ZOOKEEPER_SERVERS=${join(",", var.zk_ips)}' >> /tmp/cassy-up/kafka_params.sh",
      "echo 'export KAFKA_ADVERTISED_HOST_NAME=${element(aws_instance.kafka.*.private_ip, count.index)}' >> /tmp/cassy-up/kafka_params.sh",
      "chmod -R a+x /tmp/cassy-up/*",
      "sudo /tmp/cassy-up/oracle-jdk.sh",
      "sudo /tmp/cassy-up/kafka.sh"
    ]
  }

  # Installation log
  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "source /tmp/cassy-up/kafka_params.sh",
      "source /tmp/cassy-up/apache-kafka/kafka-params.sh",
      "echo \"revision: ${var.rev}\" | sudo tee $KAFKA_DIR/install.yaml",
      "echo \"scala:\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  version: $SCALA_VERSION\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"kafka:\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  broker_id: $KAFKA_BROKER_ID\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  version: $KAFKA_VERSION\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  hostname: $KKAFKA_ADVERTISED_HOST_NAME\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  dir: $KAFKA_DIR\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  download_dir: $KAFKA_DOWNLOAD_DIR\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  download_url: $KAFKA_URL\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  install_dir: $KAFKA_INSTALL_DIR\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  data_dir: $KAFKA_DATA_DIR\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  log_dir: $KAFKA_LOG_DIR\" | sudo tee --append $KAFKA_DIR//install.yaml",
      "echo \"  log_segment_bytes: $KAFKA_LOG_SEGMENT_BYTES\" | sudo tee --append $KAFKA_DIR//install.yaml",
      "echo \"  log_retention_bytes: $KAFKA_LOG_RETENTION_BYTES\" | sudo tee --append $KAFKA_DIR//install.yaml",
      "echo \"  log4j_dir: $KAFKA_LOG4J_DIR\" | sudo tee --append $KAFKA_DIR//install.yaml",
      "echo \"  delete_topic: $KAFKA_DELETE_TOPIC_ENABLE\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  num_partitions: $KAFKA_NUM_PARTITIONS\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"zk:\" | sudo tee --append $KAFKA_DIR/install.yaml",
      "echo \"  servers: $KAFKA_ZOOKEEPER_SERVERS\" | sudo tee --append $KAFKA_DIR/install.yaml"
    ]
  }
}
