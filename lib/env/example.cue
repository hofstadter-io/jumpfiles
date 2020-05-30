package env

#Example: {
	common: {
		Account: "tony@example.com"
		Region: "us-central1"
		Zone: "\(Region)-a"
		...
	}
	iso: common & {
		Debug: "iso"
		Project: "google-project-id"
		Network: "default"
		Subnet: "default"
		...
	}
	dev: common & {
		Debug: "dev"
		Project: "google-project-id"
		Network: "default"
		Subnet: "default"
		...
	}
	stg: common & {
		Debug: "stg"
		Project: "google-project-id"
		Network: "default"
		Subnet: "default"
		...
	}
	prd: common & {
		Debug: "prd"
		Project: "google-project-id"
		Network: "default"
		Subnet: "default"
		...
	}
}
