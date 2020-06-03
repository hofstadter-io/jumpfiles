package k8s

import (
	"github.com/hofstadter-io/jumpfiles/cuefig/cloud"
)

// Common settings inherited by all GKE clusters
#GKE_Common: cloud.#GoogleConfig & {
	Labels: {
		devenv: "k8s"
		...
	}

	// Network tags
	Tags: "devk8s"

	...
}

// GKE_Configs is a map into the sizing options
// This definition is unified with the following (3) definitions
// - GKE_Common (above)
// - GoogleConfig (../cloud/google.cue)
#GKE_Configs: [Name=string]: #GKE_Common & { 
	size: Name
	Labels: {
		size: Name
		...
	}
	...
}

#GKE_Configs: {

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
