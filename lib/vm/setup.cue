package vm

import "strings"

#SetupSchema: {
	Packages: [...string]
	Paths:   [...string]

	ShellFile: string | *".profile"

	Versions: [string]: string

	setup:   string @tag(setup)

	...
}

#DefaultConfig: #SetupSchema & {
	Packages: [
		"ansible",
		"git",
		"tmux",
		"tree",
		"unzip",
		"vim",
		"wget",
	]
	Paths: [
		"/usr/local/go/bin",
	]

	Versions: {
		k8s: "1.18.2"
		go: "1.14.3"
		cue: "0.2.0"
		hof: "0.5.6"
		mkcert: "1.4.1"
		helm: "3.2.1"
		Kind: "0.8.1"
	}
	...
}

#Actions: {
	Config: #SetupSchema

	Scripts: {

		BaseInstall: """
		sudo su

		apt update -y
		apt upgrade -y

		apt install -y \(strings.Join(Config.Packages, " "))

		echo "export PATH=$PATH:\(strings.Join(Config.Paths, ":"))" >> \(Config.ShellFile)
		"""

		DockerInstall: #"""
		sudo su

		# Adapted from
		# https://docs.docker.com/engine/install/debian/

		# Cleanup
		apt-get remove -y docker docker-engine docker.io containerd run

		# Dependencies
		apt-get install -y \
				apt-transport-https \
				ca-certificates \
				curl \
				gnupg-agent \
				software-properties-common

		# Docker repo
		curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
		apt-key fingerprint 0EBFCD88
		add-apt-repository \
			"deb [arch=amd64] https://download.docker.com/linux/debian \
			\$(lsb_release -cs) \
			stable"

		# Install Docker
		apt-get update -y
		apt-get install -y \
			docker-ce \
			docker-ce-cli \
			containerd.io

		# back into regular user
		exit

		# Non-sudo
		# sudo groupadd docker (already added during install)
		sudo usermod -aG docker \$USER
		"""#


		ToolsInstall: """
		sudo su

		if [[ -f /usr/local/bin/kubectl ]]; then
			echo "kubectl is already installed."
		else
			curl -LO https://storage.googleapis.com/kubernetes-release/release/v\(Config.Versions.k8s)/bin/linux/amd64/kubectl
			chmod +x kubectl
			mv kubectl /usr/local/bin/kubectl
		fi

		if [[ -f /usr/local/go/bin/go ]]; then
			echo "Go is already installed."
		else
			curl -LO https://dl.google.com/go/go\(Config.Versions.go).linux-amd64.tar.gz
			tar -C /usr/local -xzf go\(Config.Versions.go).linux-amd64.tar.gz
		fi

		if [[ -f /usr/local/bin/cue ]]; then
			echo "Cue is already installed."
		else
			curl -LO https://github.com/cuelang/cue/releases/download/v\(Config.Versions.cue)/cue_\(Config.Versions.cue)_Linux_x86_64.tar.gz
			mkdir /tmp/cue
			tar -C /tmp/cue -xzf cue_\(Config.Versions.cue)_Linux_x86_64.tar.gz
			mv /tmp/cue/cue /usr/local/bin/cue
		fi

		if [[ -f /usr/local/bin/hof ]]; then
			echo "Hof is already installed."
		else
			curl -LO https://github.com/hofstadter-io/hof/releases/download/v\(Config.Versions.hof)/hof_\(Config.Versions.hof)_Linux_x86_64
			mv hof_\(Config.Versions.hof)_Linux_x86_64 /usr/local/bin/hof
			chmod +x /usr/local/bin/hof
		fi

		if [[ -f /usr/local/bin/mkcert ]]; then
			echo "MkCert is already installed."
		else
			curl -LO https://github.com/FiloSottile/mkcert/releases/download/v\(Config.Versions.mkcert)/mkcert-v\(Config.Versions.mkcert)-linux-amd64
			chmod +x mkcert-v\(Config.Versions.mkcert)-linux-amd64
			mv mkcert-v\(Config.Versions.mkcert)-linux-amd64 /usr/local/bin/mkcert
		fi

		if [[ -f /usr/local/bin/helm ]]; then
			echo "Helm is already installed."
		else
			curl -LO https://get.helm.sh/helm-v\(Config.Versions.helm)-linux-amd64.tar.gz
			mkdir -p /tmp/helm 
			tar -C /tmp/helm -xf helm-v\(Config.Versions.helm)-linux-amd64.tar.gz
			chmod +x /tmp/helm/linux-amd64/helm
			mv /tmp/helm/linux-amd64/helm /usr/local/bin/helm
		fi

		if [[ -f /usr/local/bin/kind ]]; then
			echo "KinD is already installed."
		else
			curl -LO https://kind.sigs.k8s.io/dl/v\(Config.Versions.Kind)/kind-$(uname)-amd64
			chmod +x kind-$(uname)-amd64
			mv kind-$(uname)-amd64 /usr/local/bin/kind
		fi

		rm -f *.tar.gz
		"""

	}

	...
}
