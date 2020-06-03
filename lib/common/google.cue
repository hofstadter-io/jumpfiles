package common

import (
	"text/template"

	"github.com/hofstadter-io/jumpfiles/cuefig/cloud"
)

#GCP_List: {
	Config: cloud.#CommonConfig

	Script: template.Execute(Template, Config)

	Template: ##"""
	echo "CLUSTERS"
	echo "==========="

	gcloud container clusters list \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--filter="labels.jumpfile=('devk8s')"

	echo
	echo "DEV VMS"
	echo "==========="
	gcloud compute instances list \
		--account {{ .Account }} \
		--project {{ .Project }} \
		--filter="labels.jumpfile=('devbox')"

	"""##
}

