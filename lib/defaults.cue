package lib

import (
	"github.com/hofstadter-io/jumpfiles/lib/k8s"
	"github.com/hofstadter-io/jumpfiles/lib/vm"
)

#DevenvFlagDefs: {
	// Flags
	Shortname: string @tag(shortname)
	Name:      string @tag(name)

	acct:      string @tag(acct) @label(key,key2)
	proj:      string @tag(proj)
	env:       string @tag(env,short=iso|dev|stg|prd)
	cloud:     string @tag(cloud,short=google|azure|amazon)
	size:      string @tag(size,short=xs|sm|md|lg|xl|xxl|xxxl)
	runtime:   string @tag(runtime,short=k8s|vm)

	// used to select user config
	config:    string @tag(cfg,short=gke|gcp|aks|avm|eks|ec2)

	// used to run a single setup script
	setup:     string @tag(setup)
}

#DevenvDefaults: #DevenvSchema & {
	#DevenvFlagDefs
	acct:     string | *"example"
	cloud:    string | *"google"
	size:     string | *"lg"
	runtime:  string | *"k8s"

	config: string | *"gke"

	...
}

if #DevenvDefaults.config == "gke" {
	#DevenvDefaults: #UserDefaults["gke"]
}
if #DevenvDefaults.config == "gcp" {
	#DevenvDefaults: #UserDefaults["gcp"]
}

#UserDefaults: {
	gke: k8s.#GKE_Config & {
		cloud: "google"
		runtime: "k8s"

		GkeReleaseChannel: "regular"
		//GkeKubernetesVersion: "1.16.8-gke.15"
		//GkeKubernetesVersion: "1.15.11-gke.13"
		//GkeKubernetesVersion: "1.14.10-gke.36"

		...
	}

	gcp: vm.#GCP_Config & {
		cloud: "google"
		runtime: "vm"

		...
	}

}

