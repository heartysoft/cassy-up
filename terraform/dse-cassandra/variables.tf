variable rev {}

variable count {}
variable tag_name {}

variable data_ebs_size {
	default="200"
}
variable data_ebs_type {
	default="gp2"
}
variable commitlog_ebs_size {
	default="32"
}
variable commitlog_ebs_type {
	default="gp2"
}

variable ami_id {}
variable instance_type {}
variable sg_ids {
	type = "list"
}
variable availability_zones {
	type = "list"
}
variable subnet_ids {
	type = "map"
}

variable ssh_user {}
variable ssh_identity_file {}

variable provisioning_scripts {}

variable cluster_name {}
variable dc_suffix {}
variable consistent_rangemovement {
	default = true
}

variable datastax_email {}
variable datastax_password {}
variable datastax_version {}