# Galactic Lab

A testing and demonstration environment for [Galactic VPC](https://www.datum.net/docs/galactic-vpc/), a multi-cloud networking solution. This lab demonstrates multi-region Kubernetes cluster connectivity using SRv6 (Segment Routing over IPv6) packet routing.


## Approach 1: Dev Container

This approach uses VS Code's Dev Container feature to provide a fully configured development environment with all dependencies pre-installed.

### Prerequisites
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Orbstack](https://orbstack.dev/) (Read the [Containerlab docs for MacOS](https://containerlab.dev/macos/) for details why Docker Desktop will not work here)

### Steps

1. **Open the galactic-lab folder in VS Code**

2. **Reopen in Container**
   - Press `Cmd/Ctrl+Shift+P`
   - Type and select: `Dev Containers: Reopen in Container`
   - Wait for the container to build (first time only, ~5-10 minutes)
   - Press `Cmd/Ctrl+Shift+P`
   - Type and select: `Terminal: Create New Terminal`

3. **You're ready!** Proceed to the [Building the Custom Kind Node](#building-the-custom-kind-node) section below.


## Approach 2: Multipass VM

This approach creates an isolated Ubuntu VM using Multipass.

### Prerequisites
- [Multipass](https://documentation.ubuntu.com/multipass/latest/how-to-guides/install-multipass/)

### Steps

1. **Launch and enter the Multipass VM**

   Create a new Ubuntu VM with the required resources and mount the project directory:
   ```bash
   multipass launch -c 4 -d 50G -m 8G -n galactic-lab --mount .:/galactic-lab
   multipass shell galactic-lab
   sudo -s
   ```

2. **Install Netlab and dependencies**

   ```bash
   cd /galactic-lab
   export PIP_OPTIONS="--break-system-packages"
   sudo apt update && sudo apt install -y python3-pip
   python3 -m pip install $PIP_OPTIONS git+https://github.com/datum-cloud/netlab@galactic
   netlab install -y ubuntu ansible containerlab
   ```

3. **You're ready!** Proceed to the [Building the Custom Kind Node](#building-the-custom-kind-node) section below.


## Building the Custom Kind Node

Both approaches above prepare your host environment. Now you need to build the custom Kubernetes-in-Docker (Kind) node image with Galactic components pre-installed.

```bash
cd kindest-node-galactic
docker build . -t kindest/node:galactic
```


## Next Steps

With your environment set up and the custom Kind node built, you're ready to deploy a [lab topology](basic/README.md).
