package k8s

import (
	"github.com/hofstadter-io/jumpfiles/cuefig/cloud"
)

// Common settings inherited by all EKS clusters
#EKS_Common: cloud.#AmazonConfig & {
	Labels: {
		devenv: "k8s"
		...
	}

	// Network tags
	Tags: "devk8s"

	...
}

// EKS_Configs is a map into the sizing options
// This definition is unified with the following (3) definitions
// - EKS_Common (above)
// - AmazonConfig (../cloud/amazon.cue)
#EKS_Configs: [Name=string]: #EKS_Common & {
	size: Name
	Labels: {
		size: Name
		...
	}
	...
}

#EKS_Configs: {

	xs: {
		...
	}

	sm: {
		...
	}

	md: {
		...
	}

	lg: {
		...
	}

	xl: {
		...
	}

	xxl: {
		...
	}

	xxxl: {
		...
	}

	...
}
