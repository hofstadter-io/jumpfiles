# devenv - consistent, ephemeral development environments

The devenv jumpfile or command enables you to quickly spin up
consistent and ephemeral development environments
with a variety of locations and settings.
You can setup named configurations and then
override any default or custom setups with
flags when running the commands.

Settings with support for multiple entries:

- cloud providerd
- named accounts mapped to id or email depending on cloud provider
- named projects and workspaces (depending on cloud)
- environments (unlimitied named entries like local, dev, stage, prod)
- runtime (currently single node k8s or vm, more to come)
- size (xs-xxxl) t-shirt sized, hand tuned configurations

### Configuration

See the `lib` and `cuefig` directoryies.

The entrypoint to the devenv is

- leaps/devenv.sh
- lib/devenv_tool.cue

The important files are:

- 

### Examples

Create an ephemeral development environment:

```
# GKE, single node, 4CPU
devenv start -t gcp -t k8s -t md -t name=my-k8s-devenv

# Fetch credentials
devenv creds -t name=my-k8s-devenv

# List all resources managed by devenv
devenv list

# Destory a devenv resource
devenv destroy -t name=my-k8s-devenv
```

The system works like a stripped down Terraform
and introspects the system rather than requiring a statefile.
This is achieved by using labels and having one set aside
for discovering all resources under `devenv` management.

