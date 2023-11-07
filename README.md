# vyos-build-container-image

[![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/mu-ruU1/vyos-build-container-image/vyos-build-container-image.yaml?style=for-the-badge&logo=github)](https://github.com/mu-ruU1/vyos-build-container-image/actions/workflows/vyos-build-container-image.yaml)
[![Docker Pulls](https://img.shields.io/docker/pulls/muruu1/vyos?style=for-the-badge&logo=docker)](https://hub.docker.com/r/muruu1/vyos)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/muruu1/vyos/latest?style=for-the-badge&logo=docker)](https://hub.docker.com/r/muruu1/vyos/tags)  
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/muruu1/vyos?style=for-the-badge&logo=docker)](https://hub.docker.com/r/muruu1/vyos/tags)

## Quick reference

- [Containerlab](https://containerlab.dev/)
- [How to deploy VyOS in Containerlab](https://docs.google.com/document/d/1TUUVGLzetAX7_BIO6qtKDCC89j40eHa7bZrGiM5a3j8/edit?usp=sharing)

## What's this image?

This image is a unofficial container image for VyOS.  
This image is based on [vyos/vyos-rolling-nightly-builds](https://github.com/vyos/vyos-rolling-nightly-builds/releases).  
Check [GitHub Actions](https://github.com/mu-ruU1/vyos-build-container-image/actions) for build status.

### Points of attention

- Default User
  - username: `vyos`
  - password: `vyos`
- Enable SSH

## How to use this image

- Install Docker and Containerlab
  - [Install Docker Engine](https://docs.docker.com/engine/install/)
  - [Install Containerlab](https://containerlab.dev/install/)
- make topology file
- deploy a lab

## Sample Lab

![sample-lab](./docs/image/sample-lab.png)

### Make topology file

sample-topology.yaml

```yaml=sample-topology.yaml
name: sample-lab

topology:
  nodes:
    vyos01:
      kind: linux
      image: muruu1/vyos:latest
      cmd: /sbin/init
      binds:
        - /lib/modules:/lib/modules
    vyos02:
      kind: linux
      image: muruu1/vyos:latest
      cmd: /sbin/init
      binds:
        - /lib/modules:/lib/modules
    vyos03:
      kind: linux
      image: muruu1/vyos:latest
      cmd: /sbin/init
      binds:
        - /lib/modules:/lib/modules
    ubuntu01:
      kind: linux
      image: ubuntu:latest
  links:
    - endpoints: ["vyos01:eth1", "vyos02:eth1"]
    - endpoints: ["vyos02:eth2", "vyos03:eth1"]
    - endpoints: ["vyos03:eth2", "vyos01:eth2"]
    - endpoints: ["vyos01:eth3", "ubuntu01:eth1"]
```

### Deploy a lab

```
sudo clab deploy -t sample-topology.yaml
```

### Connecting to the nodes

#### ssh

```bash
ssh vyos@clab-sample-lab-vyos01
```

#### docker exec

```bash
docker exec -it clab-sample-lab-vyos01 su vyos
```

### Destroy the lab

```
sudo clab destroy -t sample-topology.yaml
```
