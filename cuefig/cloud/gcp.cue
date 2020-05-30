package cloud

#GCP_Context: {
	Account: string
	Project: string
	Region: string
	Zone: string
	...
}

#GCP_Common: #GCP_Context & {
	Scopes: [...string] | *[
		"devstorage.read_only",
		"logging.write",
		"monitoring",
		"servicecontrol",
		"service.management.readonly",
		"trace.append",
	]
	ScopeText: string | *##"""
	--scopes "https:\/\/www.googleapis.com\/auth\/devstorage.read_only","https:\/\/www.googleapis.com\/auth\/logging.write","https:\/\/www.googleapis.com\/auth\/monitoring","https:\/\/www.googleapis.com\/auth\/servicecontrol","https:\/\/www.googleapis.com\/auth\/service.management.readonly","https:\/\/www.googleapis.com\/auth\/trace.append" \
	"""##

	DiskType: string | *"pd-standard"
	DiskSize: string | *"100"

	...
}

