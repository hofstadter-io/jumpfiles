package k8s

import(
	"encoding/yaml"

	"text/template"
)

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

	defaultVmSize: string | *"\(#GCP_Mappings.vmsize[size])"
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
#GCP_Info: {
	Config: #GKE_Config
	Script: yaml.Marshal(Config)
}

#GCP_List: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	echo "CLUSTERS"
	echo "==========="

	gcloud container clusters list \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--filter="labels.jumpfile=('devk8s')" 2> /dev/null

	echo
	echo "DEV VMS"
	echo "==========="
	gcloud compute instances list \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--filter="labels.jumpfile=('devbox')" 2> /dev/null

	"""##
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

#GKE_Teardown: {
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

#GKE_Setup: {
	Config: #GKE_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	echo gcloud beta container \
		--account {{ .Account }} \
		--project {{ .Project }} \
		clusters create "{{ .fullname }}" \
		--zone {{ .Zone }} \
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

#GCP_Mappings: {
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
