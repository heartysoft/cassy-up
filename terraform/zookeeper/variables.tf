variable rev {}

variable count {}
variable tag_name {}

variable ami_id {}
variable instance_type {}
variable iam_instance_profile {}
variable subnet_ids {
	type = "list"
}
variable sg_ids {
	type = "list"
}

variable provisioning_scripts {}
variable ssh_user {}
variable ssh_identity_file {}
