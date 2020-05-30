package k8s

// The schema for a k8s configuration, this is a reduced set of options
// we are mainly focused on small ephemeral clusters for developers and ci tests
// while there are some options for scaling up to something large
// there is an emphasis on keeping this as cheap as possible
#ConfigSchema: [Name=string]: {
	name:     Name
	provider: string

	user: string
	name: "devk8s-\(user)"

	vmsize: "xs" | "sm" | "md" | "lg" | "xl" | "xxl" | "xxxl"
	vmtype: "1u" | "2u" | "4u" | "8u" | "16u" | "32u" | "64u"
	...
}

// Available configurations, these are still partial definitions (incomplete values in Cue terminology)
// We will use these else where and fill in more details both in config and from cli flags.
#AvailableConfigurations: #ConfigSchema & {
	gke: {
		provider: "gke"
	}
}
