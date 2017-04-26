variable rev {}

variable count {}
variable tag_name {}

variable ebs_size_per_node {}
variable ebs_type {}

variable ami_id {}
variable iam_instance_profile {}
variable instance_type {}
variable sg_ids {
	type = "list"
}
variable subnet_ids {
	type = "list"
}

variable ssh_user {}
variable ssh_identity_file {}

variable provisioning_scripts {}
variable zk_ips {
	type = "list"	
}
