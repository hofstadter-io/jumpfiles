
#GcpGkeOptionTable: #GcpCommonOptions & {
	Meta: "gcp-k8s"
	NodeCount: uint | *1
	...
}
#GcpVmOptionTable: #GcpCommonOptions & {
	Meta: "gcp-vm"
	...
}

#GcpCommonOptions: {
	DiskSize: *100 | int & >=100
	DiskType: *"std" | "ssd"

	...
}
