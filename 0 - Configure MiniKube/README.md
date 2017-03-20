# Installing and Configuring MiniKube

We're going to use MiniKube to set up a Virtual Machines to create a single-node
Kubernetes cluster. So, we'll be able to do some experiments with Kubernetes on our laptop.

## Step 1: Installing MiniKube

First, we're going to download and install MiniKube 0.17.1, which is the latest as
the time of writing. Here is [MiniKube's GitHub](https://github.com/kubernetes/minikube/releases).

- Linux Users:
  - Run the following command in your UNIX Terminal.
  - `curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.17.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

- macOS Users:
  - Run the following command in your macOS Terminal to download MiniKube.
  - `curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.17.1/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/`

  - Next, we'll use Homebrew to install the XHyve VM Driver.
  - `brew install docker-machine-driver-xhyve &&
    sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve &&
    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve`

  - After that, we need to install Kubectl CLI. Copy and Paste the following.
  - `curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl
  && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl`

- Windows Users:
  - Download Windows Installer from [MiniKube Release Page](https://github.com/kubernetes/minikube/releases).
  - Here is the [Direct Link](https://github.com/kubernetes/minikube/releases/download/v0.17.1/minikube-installer.exe).

After that, you could check MiniKube's version with `minikube version`.
You could do the same for Kubectl (Kubernetes CLI) with `kubectl version`.

## Step 2: Configuring MiniKube

You might need to do this after restarting the host machine, or when you're experiencing bugs.

1. Start MiniKube's Virtual Machine. This will take a while.
   - `minikube start`
   - On macOS, you need to use `minikube start --vm-driver=xhyve` instead.

2. Configure Kubectl to use MiniKube's context.
   - `kubectl config use-context minikube`
   - Kubectl is Kubernetes' command line tool.
     We'll use it to control our Kubernetes cluster.

3. Configure Docker's Environment Variables to use MiniKube.
   - `eval $(minikube docker-env)`
   - This will allow us to use a local Docker image registry,
     so we don't have to push our Docker images.

## Step 3: Does it work?

After starting

-

### Additional Notes

If you're experiencing bugs or technical problems, you can stop the VM
with `minikube stop`, and delete the VM with `minikube delete`.
