package vm

import (
	"github.com/hofstadter-io/jumpfiles/cuefig/cloud"
)

// Common settings inherited by all EC2 instances
#EC2_Common: cloud.#AmazonConfig & {
	Labels: {
		devenv: "vm"
		...
	}

	// Network tags
	Tags: "devbox"

	...
}

// EC2_Configs is a map into the sizing options
// This definition is unified with the following (3) definitions
// - EC2_Common (above)
// - AmazonConfig (../cloud/amazon.cue)
#EC2_Configs: [Name=string]: #EC2_Common & { 
	size: Name
	Labels: {
		size: Name
		...
	}
	...
}

#EC2_Configs: {

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

	...
}

