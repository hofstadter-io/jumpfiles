package env

#Example: {
	accounts: {
		google: {
			Email: "tony@example.com"
			Account: Email
			Region: "us-central1"
			Zone: "\(Region)-a"
			...
		}
		amazon: {...}
		azure: {...}
		...
	}

	envs: {
		google: [string]: accounts.google & {
			iso: {
				Project: "google-project-id"
				Network: "default"
				Subnet: "default"
				...
			}
			dev: {
				Project: "google-project-id"
				Network: "default"
				Subnet: "default"
				...
			}
			stg: {
				Project: "google-project-id"
				Network: "default"
				Subnet: "default"
				...
			}
			prd: {
				Project: "google-project-id"
				Network: "default"
				Subnet: "default"
				...
			}
			...
		}
		amazon: {...}
		azure: {...}
		...
	}

}
