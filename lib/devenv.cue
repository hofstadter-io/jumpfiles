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
	// used to run a single setup script
	setup:   string @tag(setup)

	// trim the prefix from the email address (Account)
	Account: string
	Project: proj
	proj: Project
	Shortname: string | *strings.SplitN(Account, "@", 2)[0]
	Name: string | *Shortname

	// used to index into some config tables
	acct:      string
	env:      string | *"iso"
	cloud:    "google" | "azure" | "amazon"
	runtime:  "k8s" | "vm"
	size:     "xs" | "sm" | "md" | "lg" | "xl"| "xxl" | "xxxl"
	setup:    *"all" | "base" | "docker" | "tools"

	// used for infra names / labels
	fullname: string | *"devenv-\(runtime)-\(Shortname)" @tag(fullname)

	// prompt info
	#info: "\(Name): \(cloud) \(size) \(runtime) (\(fullname))"

	Labels: [string]: string
	LabelsJoined: strings.Join([ for K,V in Labels { "\(K)=\(V)" }], ",")

	...
}

// Progressive lookup table to enrich the configuration
#DevenvLookupTable: {
	// The main table from the devenv_grid.cue file
	// This will also have the flags values too
	Cfg: #DevenvDefaults & #DevenvSchema

	// Progressively index into the config tree
	// TODO, turn this into tags / guards based ?
	// really need to pull together some parts and unify them as one

	// Context lookup
	ContextAcct: #DevenvAcctTable[Cfg.acct].accounts[Cfg.cloud]
	ContextEnv: #DevenvAcctTable[Cfg.acct].envs[Cfg.cloud][Cfg.env]

	// Config lookup
	ConfigRoot: #DevenvOptionTable
	ConfigCloud: ConfigRoot[Cfg.cloud]
	ConfigRuntime: ConfigCloud[Cfg.runtime]
	ConfigSizing: ConfigRuntime[Cfg.size]

	// Script lookup
	ScriptRoot:    #DevenvScriptTable
	ScriptCloud:   ScriptRoot[Cfg.cloud]
	ScriptRuntime: ScriptCloud[Cfg.runtime]

	// These are our final values
	Context: ContextAcct & ContextEnv
	Config:  ConfigSizing & #DevenvSchema
	Scripts: ScriptRuntime
}

// Full configuration builtup
#DevenvActual: #DevenvDefaults
#DevenvActual: #DevenvLookupTable.Context
#DevenvActual: #DevenvLookupTable.Config

#DevenvScripts: (#DevenvLookupTable.Scripts & { config: #DevenvActual })
