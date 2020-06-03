package vm

import (
	"github.com/hofstadter-io/jumpfiles/cuefig/cloud"
)

// Common settings inherited by all Azure instances
#AVM_Common: cloud.#AzureConfig & {
	Labels: {
		devenv: "vm"
		...
	}

	// Network tags
	Tags: "devbox"

	...
}

// AVM_Configs is a map into the sizing options
// This definition is unified with the following (3) definitions
// - AVM_Common (above)
// - AzureConfig (../cloud/azure.cue)
#AVM_Configs: [Name=string]: #AVM_Common & { 
	size: Name
	Labels: {
		size: Name
		...
	}
	...
}

#AVM_Configs: {

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

