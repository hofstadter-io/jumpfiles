package k8s

import (
	"strings"

	"github.com/hofstadter-io/jumpfiles/cuefig/cloud"
)

//GCLOUD_DEVK8S_NAME=${GCLOUD_DEVK8S_NAME:-devk8s-$USER}
#GKE_Common: cloud.#GCP_Common & {
	// need to duplicate this for the reference
	// even though it ought to be discoverable?
	Account: string
	// trim the prefix from the email address (Account)
	Shortname: string | *strings.SplitN(Account, "@", 2)[0]
	
	Labels: "jumpfile=devk8s,creator=\(Shortname)"
	Tags: "devk8s"

	...
}

// GKE_Configs is a map into the sizing options
// This definition is unified with the following definitions
// - GKE_Common (here)
// - GCP_Common (above)
// - GCP_Context (../cloud/gcp.cue)
#GKE_Configs: [string]: #GKE_Common
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
