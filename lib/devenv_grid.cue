package lib

import (
	cfgk8s "github.com/hofstadter-io/jumpfiles/cuefig/k8s"
	cfgvm  "github.com/hofstadter-io/jumpfiles/cuefig/vm"
	libk8s "github.com/hofstadter-io/jumpfiles/lib/k8s"
	libvm  "github.com/hofstadter-io/jumpfiles/lib/vm"

	"github.com/hofstadter-io/jumpfiles/lib/env"
)

#DevenvAcctTable: {
	example: env.#Example

	// add your accounts here

	...
}

#DevenvOptionTable: {
	google: #GcpOptionTable
	amazon: #AwsOptionTable
	azure: #AzureOptionTable

	...
}

#GcpOptionTable: {
	k8s: cfgk8s.#GKE_Configs
	vm: cfgvm.#GCP_Configs
}

#AwsOptionTable: {
	k8s: cfgk8s.#EKS_Configs
	vm: cfgvm.#EC2_Configs
}

#AzureOptionTable: {
	k8s: cfgk8s.#AKS_Configs
	vm: cfgvm.#AVM_Configs
}



#DevenvScriptTable: {
	google: #GcpScriptTable
	amazon: #AwsScriptTable
	azure: #AzureScriptTable

	...
}

#GcpScriptTable: {
	k8s: libk8s.#GKE_Scripts
	vm: libvm.#GCP_Scripts
}

#AwsScriptTable: {
	k8s: libk8s.#EKS_Scripts
	vm: libvm.#EC2_Scripts
}

#AzureScriptTable: {
	k8s: libk8s.#AKS_Scripts
	vm: libvm.#AVM_Scripts
}



