resource "aws_ebs_volume" "dse-cassandra-ebs-data" {
    count = "${var.count}"
    availability_zone = "${var.availability_zones[count.index % length(var.availability_zones)]}"
    size = "${var.data_ebs_size}"
    type = "${var.data_ebs_type}"
    tags {
        Name = "${var.tag_name} - Data Vol"
    }
}

resource "aws_volume_attachment" "dse-cassandra-ebs-data-attach" {
  count = "${var.count}"
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.dse-cassandra-ebs-data.*.id[count.index]}"
  instance_id = "${aws_instance.dse-cassandra.*.id[count.index]}"
  force_detach = true
}

resource "aws_ebs_volume" "dse-cassandra-ebs-commit-log" {
    count = "${var.count}"
    availability_zone = "${var.availability_zones[count.index % length(var.availability_zones)]}"
    size = "${var.commitlog_ebs_size}"
    type = "${var.commitlog_ebs_type}"
    tags {
        Name = "${var.tag_name} - CommitLog Vol"
    }
}

resource "aws_volume_attachment" "dse-cassandra-ebs-commit-log-attach" {
  count = "${var.count}"
  device_name = "/dev/xvdi"
  volume_id = "${aws_ebs_volume.dse-cassandra-ebs-commit-log.*.id[count.index]}"
  instance_id = "${aws_instance.dse-cassandra.*.id[count.index]}"
  force_detach = true
}
