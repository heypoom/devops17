# Installing and Configuring MiniKube

We're going to use MiniKube to set up some Virtual Machines to create and emulate
several nodes/clusters, so we can experiment with them.

## Step 1: Installation

First, we're going to install MiniKube from [MiniKube's GitHub](https://github.com/kubernetes/minikube/releases)

1. Download and Install MiniKube for your OS.
  - Linux Users:
    - Copy and Paste this into the Terminal.
    - `curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.17.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

  - macOS Users:
    - Copy and Paste this into the Terminal.
    - `curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.17.1/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

  - Windows Users:
    - Download Windows Installer from [MiniKube Release Page](https://github.com/kubernetes/minikube/releases).
    - Here is the [Direct Link](https://github.com/kubernetes/minikube/releases/download/v0.17.1/minikube-installer.exe).

2. Start MiniKube
  - `minikube start`
  - On macOS, you need to use `minikube start --vm-driver=xhyve`

3. Make Kubectl (Kubernetes' CLI) use MiniKube
  - `kubectl config use-context minikube`

4. Set Docker's Environment Variables to use MiniKube
  - `minikube docker-env`
