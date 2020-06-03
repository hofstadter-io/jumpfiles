package k8s

import(
	"encoding/yaml"
	"text/template"
)

#GKE_Scripts: {
	config: _

	info: (#GKE_Info & { Config: config })
	view: (#GKE_View & { Config: config })

	start: (#GKE_Start & { Config: config })
	stop:  (#GKE_Stop  & { Config: config })

	creds: (#GKE_Creds & { Config: config })
	setup: (#GKE_Setup & { Config: config })

	...
}

// temp mapping, to go away
#GKE_Mappings: {
	vmsize: {
		xs:   "n1-standard-1"
		sm:   "n1-standard-2"
		md:   "n1-standard-4"
		lg:   "n1-standard-8"
		xl:   "n1-standard-16"
		xxl:  "n1-standard-32"
		xxxl: "n1-standard-64"
	}	

}

// Mainly for cluster create
#GKE_Config: {
	Name: string
	Project: string
	Zone: string

	size: string
	fullname: string

	ScopeText: string

	NumNodes: int & >0 | *1
	MaxPodsPerNode: int & >32 | *110

	//GkeVersion: string
	GkeReleaseChannel: *"regular" | "rapid" | "stable"
	GkeImageType: string | *"COS"

	defaultVmSize: string | *"\(#GKE_Mappings.vmsize[size])"
	MachineSize: string | *"\(defaultVmSize)"

	DiskType: string
	DiskSize: string

	Addons: "HorizontalPodAutoscaling,Istio"

	Extra: ##"""
		--istio-config auth=MTLS_PERMISSIVE
	"""##

	Stackdriver: bool | *false
	Autoupgrade: bool | *false
	Autorepair:  bool | *false

	SD: "no-"
	AG: "no-"
	AR: "no-"
	...
}


// This is mainly used to make sure we have a complete value going into the others
// as so that we can inspect the values (change name of def here?)
#GKE_Info: {
	Config: #GKE_Config
	Script: yaml.Marshal(Config)
}

#GKE_View: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	gcloud container clusters describe {{ .fullname }} \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--zone {{ .Zone }}
	"""##
}

#GKE_Start: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	gcloud beta container \
		--account {{ .Account }} \
		--project {{ .Project }} \
		clusters create {{ .fullname }} \
		--zone {{ .Zone }} \
		--tags {{ .Tags }} \
		--labels {{ .LabelsJoined }} \
		--no-enable-basic-auth \
		--release-channel "{{ .GkeReleaseChannel }}" \
		--image-type "{{ .GkeImageType }}" \
		--num-nodes "{{ .NumNodes }}" \
		--machine-type "{{ .MachineSize }}" \
		--disk-type "{{ .DiskType }}" \
		--disk-size "{{ .DiskSize }}" \
		--enable-ip-alias \
		--network "{{ .Network }}" \
		--subnetwork "{{ .Subnet }}" \
		--default-max-pods-per-node "{{ .MaxPodsPerNode }}" \
		--enable-network-policy \
		--{{ .SD }}enable-stackdriver-kubernetes \
		--{{ .AG }}enable-autoupgrade \
		--{{ .AR }}enable-autorepair \
		--addons {{ .Addons }} \
		{{ .Extra }}
	"""##

}

#GKE_Stop: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	gcloud container clusters delete {{ .fullname }} \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--zone {{ .Zone }} \
		--quiet
	"""##
}

#GKE_Creds: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	gcloud container clusters get-credentials {{ .fullname }} \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--zone {{ .Zone }} \
		--quiet
	"""##
}

// setup cluster with extras
#GKE_Setup: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	echo "Not implemented yet..."
	"""##
}


#GKE_Login: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	echo "Login not implemented for clusters"
	"""##
}


