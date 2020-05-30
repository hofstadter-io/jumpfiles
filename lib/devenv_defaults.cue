package lib

#DevenvDefaults: #DevenvSchema & {
	acct:     string | *"example"
	cloud:    string | *"gcp"
	runtime:  string | *"k8s"
	size:     string | *"sm"
}

