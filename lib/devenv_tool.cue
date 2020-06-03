package lib

import (
	"tool/cli"
	"tool/exec"

	"github.com/hofstadter-io/jumpfiles/lib/common"
)

command: info: {
	action: #DevenvScripts.info

	print: cli.Print & {
		text: action.Script
	}
}

command: list: {
	action: (common.#GCP_List & { Config: #DevenvActual })

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
	}
}


command: view: {
	action: #DevenvScripts.view

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
	}
}


command: login: {
	action: #DevenvScripts.login

	msg_end: cli.Print & {
		text: action.Script
	}
}


command: creds: {
	action: #DevenvScripts.creds

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
	}
}


// Create ephemeral development environments
command: start: {
	action: #DevenvScripts.start

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
	}

}

command: stop: {
	action: #DevenvScripts.stop

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
	}
}

command: setup: {
	action: #DevenvScripts.setup

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
	}
}


