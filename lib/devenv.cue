package lib

import (
	"strings"
)

// The high level schema for ephemeral development environments
//   cue def -t key=val -t short set > my-config.cue
//   cmd def -t gcp -t vm -t name=douglas set
#DevenvSchema: {
	// Flags
	Shortname: string @tag(shortname)
	Name:      string @tag(name)

	acct:      string @tag(acct) @label(key,key2)
	proj:      string @tag(proj)
	env:       string @tag(env,short=iso|dev|stg|prd)
	cloud:     string @tag(cloud,short=gcp|azure|aws)
	size:      string @tag(size,short=xs|sm|md|lg|xl|xxl|xxxl)
	runtime:   string @tag(runtime,short=k8s|vm)

	// trim the prefix from the email address (Account)
	Account: string
	Project: proj
	proj: Project
	Shortname: string | *strings.SplitN(Account, "@", 2)[0]
	Name: string | *Shortname

	// used to index into some config tables
	acct:      string
	env:      string | *"iso"
	cloud:    "gcp" | "azure" | "aws"
	runtime:  "k8s" | "vm"
	size:     "xs" | "sm" | "md" | "lg" | "xl"| "xxl" | "xxxl"

	// used for infra names / labels
	fullname: string | *"hofdev-\(runtime)-\(Shortname)" @tag(fullname)

	// prompt info
	#info: "\(Name): \(cloud) \(size) \(runtime) (\(fullname))"


	...
}

// Progressive lookup table to enrich the configuration
#DevenvConfigTable: {
	// This will also have the flags values too
	Cfg: #DevenvDefaults & #DevenvSchema

	// The main table from the devenv_grid.cue file
	Root: #DevenvOptionTable

	// Progressively index into the config tree
	// TODO, turn this into tags / guards based ?
	// really need to pull together some parts and unify them as one

	Cloud: Root[Cfg.cloud]
	Runtime: Cloud[Cfg.runtime]
	Sizing: Runtime[Cfg.size]

	// Same idea for acct/env
	Acct: #DevenvAcctTable[Cfg.acct]
	Env: Acct[Cfg.env] & #DevenvSchema

	// This is our runtime
	Configuration: Sizing & #DevenvSchema
}

// Full configuration builtup
#DevenvActual: #DevenvDefaults
#DevenvActual: #DevenvConfigTable.Env
#DevenvActual: #DevenvConfigTable.Configuration
