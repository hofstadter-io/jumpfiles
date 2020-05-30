package lib

import (
	"strings"

	"tool/cli"
	"tool/exec"
	// "tool/file"

	"github.com/hofstadter-io/jumpfiles/lib/k8s"
)

command: info: {

	action: (k8s.#GCP_Info & { Config: #DevenvActual })

	print: cli.Print & {
		text: action.Script
	}

}

command: list: {

	action: (k8s.#GCP_List & { Config: #DevenvActual })

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
		stdout: string
	}

	msg_end: cli.Print & {
		text: run.stdout 
	}

}


command: view: {

	action: (k8s.#GKE_View & { Config: #DevenvActual })

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
		stdout: string
	}

	msg_end: cli.Print & {
		text: run.stdout 
	}

}


command: creds: {

	action: (k8s.#GKE_Creds & { Config: #DevenvActual })

	run: exec.Run & {
		cmd: ["bash", "-c", "\(action.Script)"]
		stdout: string
	}

	msg_end: cli.Print & {
		text: run.stdout 
	}

}


// Create ephemeral development environments
command: start: {

	action: (k8s.#GKE_Setup & { Config: #DevenvActual })

	msg_beg: cli.Print & {
		text: "Starting \(#DevenvActual.#info)"
		stdout: string
	}

	run: exec.Run & {
		deps: [msg_beg.stdout]

		cmd: ["bash", "-c", "\(action.Script)"]
		text: strings.Join(cmd, " ")

		stdout: string
	}

	msg_end: cli.Print & {
		deps: [run.stdout]

		text: """
		\(run.stdout)

		Finished setting up \(#DevenvActual.fullname)
		"""

		stdout: string
	}

}

command: stop: {
	msg_beg: cli.Print & {
		text: "Stopping \(#DevenvActual.fullname)"
		stdout: string
	}

	action: (k8s.#GKE_Teardown & { Config: #DevenvActual })

	run: exec.Run & {
		deps: [msg_beg.stdout]
		cmd: ["bash", "-c", "\(action.Script)"]
		text: strings.Join(cmd, " ")
		stdout: string
	}

	msg_end: cli.Print & {
		deps: [run.stdout]
		text: """
		\(run.stdout)

		Finished destroying \(#DevenvActual.fullname)
		"""
		stdout: string
	}

}


