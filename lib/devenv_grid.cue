package lib

import (
	cfgk8s "github.com/hofstadter-io/jumpfiles/cuefig/k8s"
	// cfgvm  "github.com/hofstadter-io/jumpfiles/cuefig/vm"

	"github.com/hofstadter-io/jumpfiles/lib/env"
)

#DevenvAcctTable: {
	example: env.#Example

	...
}

#DevenvOptionTable: {
	gcp: #GcpOptionTable
	aws: #AwsOptionTable
	azure: #AzureOptionTable

	...
}

#GcpOptionTable: {
	k8s: cfgk8s.#GKE_Configs
	vm: cfgvm.#VM_Configs
}

#AwsOptionTable: {
	k8s: cfgk8s.#GKE_Configs
	vm: cfgvm.#VM_Configs
}

#AzureOptionTable: {
	k8s: cfgk8s.#GKE_Configs
	vm: cfgvm.#VM_Configs
}



