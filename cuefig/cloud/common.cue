package cloud

import "strings"

// Common configuration fields which are agnostic to a particular cloud
#CommonConfig: {
	// Common enough settings across hyper clouds
	// These are typically top level flags for all commands in their CLIs
	Email:   string
	Account: string
	Project: string
	Region:  string
	Zone:    string

	// defaults to the prefix from the email address
	Shortname: string | *strings.SplitN(Email, "@", 2)[0]

	// Schema for a map
	Labels: [string]: string
	Labels: {
		managedby: "hof-devenv"
		creator: Shortname
		...
	}

	...

}
