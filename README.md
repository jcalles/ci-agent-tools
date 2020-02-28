# Custom CI agent  tools

This repository contains the source for a docker image that contains all binaries and dependencies to run terraform and another tools.

The pipeline can build, tag and push the image to the apropriate registry, but you can also use the `make` targets to build and tag locally and test your changes before commiting them.

*Handy shortcuts to docker commands*

```
make build
make tag
make run
```

# Registry

  Current tag:
    your_registry/buildpack

# Installed tools

- `buildpack:v1.0`
  
  - Based on [debian:latest](https://dockerhub/debian)
  
  - Adds Terraform version 0.12.21
  
  - Adds Inspec for tests, and its depenency v4.18.97
  
  - Adds Terragrunt 0.22.11
  
  - Adds `~/.ssh/config` to configure access to Git URL
  
  - Adds jq 1.5-1
  
  - Adds openjdk-11-jre
  
  - Adds: git and 
  
    [gitchangelog]: https://github.com/vaab/gitchangelog	"GitChangelog v3.0.4 "
  
  - Adds; shunit2  2.1.8pre
  
  - Adds: AWS CLI v2 v2.0.1
  
  - Adds: versiontag_(xy_xyz)  
  

### Docker args:

- BIN_PATH=/usr/local/bin
- GIT_URL=the_git_url (gitlab, github, bitbucket)
- TERRAFORM_VERSION=0.12.21
- INSPEC_VERSION=4.18.97
- TERRAGRUNT_VERSION=0.22.5



### Files.

```
├── CHANGELOG.md ## The changlog file
├── CONTRIBUTING.md
├── Dockerfile
├── Jenkinsfile  ## to use with Jenkins > 2 
├── kubernetes
│   └── AgentPod.yaml  ## To deply with kubernetes and jenkins
├── Makefile  ## to use local or with Jenkins
├── README.md ## This file
└── scripts
    ├── versiontag_xy  bash scripts to tag git repos vX.Y and vX.Y.Z
    └── versiontag_xyz
```



## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

