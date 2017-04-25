resource "aws_ebs_volume" "kafka-ebs" {
  count = "${var.kafka_count}"
  availability_zone = "${element(aws_instance.kafka.*.availability_zone, count.index)}"
  size = "${var.kafka_ebs_size_per_node}"
  type = "${var.kafka_ebs_type}"
  tags {
    Name = "${format("%s-ebs-%d", var.kafka_tag_name, count.index + 1)}"
  }
}

resource "aws_volume_attachment" "kafka-ebs-attach" {
  count = "${var.kafka_count}"
  device_name = "/dev/xvdh"
  volume_id = "${element(aws_ebs_volume.kafka-ebs.*.id, count.index)}"
  instance_id = "${element(aws_instance.kafka.*.id, count.index)}"
  force_detach = true
}

