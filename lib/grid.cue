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

	...
}

#DevenvOptionTable: {
	google: #GcpOptionTable
	amazon: #AwsOptionTable
	azure:  #AzureOptionTable

	...
}

#GcpOptionTable: {
	k8s: cfgk8s.#GKE_Configs
	vm:  cfgvm.#GCP_Configs
}

#AwsOptionTable: {
	k8s: cfgk8s.#EKS_Configs
	vm:  cfgvm.#EC2_Configs
}

#AzureOptionTable: {
	k8s: cfgk8s.#AKS_Configs
	vm:  cfgvm.#AVM_Configs
}



#DevenvScriptTable: {
	google: #GcpScriptTable
	amazon: #AwsScriptTable
	azure:  #AzureScriptTable

	...
}

#GcpScriptTable: {
	k8s: #GKE_Scripts
	vm:  #GCP_Scripts
}

#AwsScriptTable: {
	k8s: libk8s.#EKS_Scripts
	vm:  libvm.#EC2_Scripts
}

#AzureScriptTable: {
	k8s: libk8s.#AKS_Scripts
	vm:  libvm.#AVM_Scripts
}

#GKE_Scripts: {
	#Config: #DevenvActual

	info: libk8s.#GKE_Info & { Config: #Config }
	view: libk8s.#GKE_View & { Config: #Config }

	start: libk8s.#GKE_Start & { Config: #Config }
	stop:  libk8s.#GKE_Stop  & { Config: #Config }

	creds: libk8s.#GKE_Creds & { Config: #Config }
	setup: libk8s.#GKE_Setup & { Config: #Config }

	...
}

#GCP_Scripts: {
	#Config: #DevenvActual

	info: libvm.#GCP_Info & { Config: #Config }
	view: libvm.#GCP_View & { Config: #Config }

	start: libvm.#GCP_Start & { Config: #Config }
	stop:  libvm.#GCP_Stop  & { Config: #Config }

	creds: libvm.#GCP_Creds & { Config: #Config }
	setup: libvm.#GCP_Setup & { Config: #Config }

	...
}

