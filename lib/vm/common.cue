package vm


#ConfigSchema: {
	Packages: [...string]
	Paths:   [...string]

	ShellFile: string | *".profile"

	...
}

DefaultConfig: #ConfigSchema & {
	Packages: [
		ansible,
		git,
		tree,
		unzip,
		vim,
		wget,
	]
	Paths: [
		"/usr/local/go/bin",
	]

	...
}


#Scripts: {
	Config: #ConfigSchema

	#BaseInstall: ##"""
	sudo su

	apt update -y
	apt upgrade -y

	apt install -y \(strings.Join(Config.Packages, " "))

	echo "export PATH=$PATH:\(strings.Join(Config.Paths, ":"))" >> \(Config.ShellFile)
	"""##

	#ToolsInstall: """

	"""

}

