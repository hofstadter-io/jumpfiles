package vm

import(
	"encoding/yaml"
	"strings"
	"text/template"
)

// temp mapping, to go away
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

// Mainly for cluster create
#GCP_Config: {
	Name: string
	Project: string
	Zone: string

	size: string
	fullname: string

	ScopeText: string

	defaultVmSize: string | *"\(#GCP_Mappings.vmsize[size])"
	MachineSize: string | *"\(defaultVmSize)"

	ImageProject: string | *"debian-cloud"
	ImageFamily: string | *"debian-10"

	DiskType: string
	DiskSize: string

	setup: string
	...
}


// This is mainly used to make sure we have a complete value going into the others
// as so that we can inspect the values (change name of def here?)
#GCP_Info: {
	Config: #GCP_Config
	Script: """
	\(yaml.Marshal(Config))
	"""
}

#GCP_View: {
	Config: #GCP_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	gcloud compute instances describe {{ .fullname }} \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--zone {{ .Zone }}
	"""##
}

#GCP_Start: {
	Config: #GCP_Config

	Script: template.Execute(Template, Config)

	// TODO, add a second disk for the home dir
	Template: ##"""
	gcloud compute instances \
		--account {{ .Account }} \
		--project {{ .Project }} \
		create {{ .fullname }} \
		--zone {{ .Zone }} \
		--tags {{ .Tags }} \
		--labels {{ .LabelsJoined }} \
		--machine-type "{{ .MachineSize }}" \
		--boot-disk-type "{{ .DiskType }}" \
		--boot-disk-size "{{ .DiskSize }}" \
		--network "{{ .Network }}" \
		--subnet "{{ .Subnet }}"
	"""##

}

#GCP_Stop: {
	Config: #GCP_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	gcloud compute instances delete {{ .fullname }} \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--zone {{ .Zone }} \
		--quiet
	"""##
}

// log into the vm
#GCP_Login: {
	Config: #GCP_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	gcloud compute \
		--account {{ .Account }} \
		--project {{ .Project }} \
		ssh {{ .fullname }} \
		--zone {{ .Zone }}
	"""##
}


// sends devenv ssh key for git purposes
#GCP_Creds: {
	Config: #GCP_Config

	Script: template.Execute(Template, Config)

	Template: ##"""
	echo "Not implemented yet..."
	"""##
}

// setup devenv with software
#GCP_Setup: {
	
	Config: #DefaultConfig & { Scripts: (#Actions & { Config: #DefaultConfig }).Scripts }

	Script: template.Execute(Template, Config)

	Template: string

	if Config.setup == "all" {
		Template: AllTemplate
	}
	if Config.setup == "base" {
		Template: BaseTemplate
	}
	if Config.setup == "docker" {
		Template: DockerTemplate
	}
	if Config.setup == "tools" {
		Template: ToolsTemplate
	}

	AllTemplate: strings.Join(Templates, "\n\n")

	Templates: [
		BaseTemplate,
		DockerTemplate,
		ToolsTemplate,
	]

	BaseTemplate: ##"""
	echo "Base Install"
	gcloud compute \
		--account {{ .Account }} \
		--project {{ .Project }} \
		ssh {{ .fullname }} \
		--zone {{ .Zone }} \
		-- << ENDSSH
	{{ .Scripts.BaseInstall }}
	ENDSSH

	"""##

	DockerTemplate: ##"""
	echo "Docker Install"
	gcloud compute \
		--account {{ .Account }} \
		--project {{ .Project }} \
		ssh {{ .fullname }} \
		--zone {{ .Zone }} \
		-- << ENDSSH
	{{ .Scripts.DockerInstall }}
	ENDSSH

	"""##

	ToolsTemplate: ##"""
	echo "Tool Install"
	gcloud compute \
		--account {{ .Account }} \
		--project {{ .Project }} \
		ssh {{ .fullname }} \
		--zone {{ .Zone }} \
		-- << ENDSSH
	{{ .Scripts.ToolsInstall }}
	ENDSSH

	"""##

}


