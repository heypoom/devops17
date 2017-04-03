# Part 1 - Installing and Configuring MiniKube

Welcome to the Kubernetes Journey! Let us begin with installing the necessary tools.
Do note that this might take a while. Please get them ready as soon as possible,
so we could go straight to the fun part!

We're going to use **MiniKube** to set up a Virtual Machine to run Kubernetes on.
It is a tool that helps us to **create a single-node Kubernetes cluster**.
So, we'll be able to do some experiments locally on our laptop.

## Step 1: Installing Docker

I'm quite sure everyone already knows the basics of docker, as it is one of the prerequisites.
For brevity, here is the download link for **[Docker Community Edition](https://www.docker.com/community-edition#/download)**.
Simply download and install them if you haven't already done so.

Don't worry if you don't know or forgot something! Please don't hesitate to ask me in the meantime.

## Step 2: Installing MiniKube

First, we're going to download and install **[MiniKube 0.17.1](https://github.com/kubernetes/minikube/releases)**,
which is the latest version as the time of writing.

- MiniKube will Setup Virtual Machines to emulate each node

### Linux Users (VirtualBox Driver)

- Install VirtualBox
- Install MiniKube
- Install Kubectl

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.17.1/minikube-linux-amd64 
&& chmod +x minikube && sudo mv minikube /usr/local/bin

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
&& chmod +x kubectl && sudo mv kubectl /usr/local/bin
```

### macOS Users (Xhyve Driver)

- Install MiniKube
- Install Kubectl
- Install Homebrew
- Install Xhyve

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)„

brew install docker-machine-driver-xhyve && sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve && sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
```

### Windows Users

First of all, get yourself a copy of kubectl and minikube binaries.

Place them in the OS drive, like C:\. There is a bug which doesn't allow cluster installation if it's placed anywhere else.

kubectl: https://storage.googleapis.com/kubernetes-release/release/v1.6.0-beta.3/bin/windows/amd64/kubectl.exe0

minikube: https://github.com/kubernetes/minikube/releases/download/v0.17.1/minikube-windows-amd64 -- rename it to minikube.exe

Next, choose whether you want to use the Hyper-V driver which is Windows 10 only, or the VirtualBox driver which comes with Docker Toolbox.

NOTE: If you're using Windows 10 and you're already using VirtualBox & Docker Toolbox, instead of Hyper-V and Docker for Windows, feel free to use the VirtualBox method!

#### Hyper-V Driver with Docker for Windows (Windows 10 only)

We're going to use the native Hyper-V driver, and Docker for Windows 10! There is a bit of work involved.

First, enable Hyper-V. Go to Windows features On or Off, you will see dialog box with a list of Windows features. Navigate to the Hyper-V section and enable it. Restart.

Next, Install Docker for Windows 10. Here is the [Direct Download Link](https://download.docker.com/win/stable/InstallDocker.msi). Install it, and run `docker info` to see if it works.

Then, we're going to create a new external network (a.k.a. Virtual Switch), for Hyper-V to setup Kubernetes properly.

- Search for "Hyper-V Manager" in the Start Menu.
- Click on "Connect to Server" in Actions.
- Click on "Virtual Switch Manager" in Actions.
- In the "Name" field, type in a name. I'm going to name it `minikube`.
- Set connection to your network adapter, so Hyper-V will be able to access the outside internet.

Okay. Let's see the available kubernetes version. `minikube get-k8s-versions`

Finally, let's start minikube! We'll need some special flags:

- The `--kubernetes-version="VERSION"` flag specifies which version of kubernetes we want. I'm going to select the version `"v1.6.0-beta-3"`, which is the latest as of writing.

- The `--vm-driver="hyperv"` flag tells minikube that we're going to use the native Hyper-V driver, not VirtualBox. We're going to allocate 1GB of memory to the Hyper-V VM, hence the `--memory=1024` flag.

- The `--hyperv-virtual-switch="minikube"` flag specifies which network we want to use. I'm going to use the one I created earlier, which I named `"minikube"`.

- We're logging everything, so we're setting verbosity to level 7 with the flag `--v=7`. Also, we're going to send the logs to STDERR, so we're using the flag `--alsologtostderr`. 

So, we ended up with this command. Use it to start minikube.

`minikube start --kubernetes-version="v1.6.0-beta.3" --vm-driver="hyperv" --memory=1024 --hyperv-virtual-switch="minikube" --v=7 --alsologtostderr`

Reference: [Minikube on Windows 10 with Hyper-V and Docker for Windows](https://blogs.msdn.microsoft.com/wasimbloch/2017/01/23/setting-up-kubernetes-on-windows10-laptop-with-minikube/)

#### VirtualBox Driver with Docker Toolbox (Windows 7/8.1/10)

We're using Docker Toolbox, which comes with VirtualBox.
Install Docker Toolbox First: https://www.docker.com/products/docker-toolbox

Minikube On Windows 7/8.1 (Docker Toolbox) Instructions: https://gist.github.com/AdamLJohnson/16b55b66c84ce53868b3923f3b7ae706

## Step 3: Configuring Minikube (After Installation and Reboot)

First of all, **kubectl** is **Kubernetes' Command Line Interface**, which
we'll use it to interact with our Kubernetes cluster.

Next, We're going to configure `minikube` and `kubectl`. You might need to do this
again after restarting the host machine, or when you're experiencing bugs.

1. **Start MiniKube**'s Virtual Machine. This will take a while.
2. Configure kubectl to use MiniKube's context.
3. Configure Docker's Environment Variables to use MiniKube.
   This will allow us to use the local Docker image registry,
   so we don't have to push our images.
   
Here are the commands for all operating systems.

### Hyper-V (Windows 10)

```
minikube start --kubernetes-version="v1.6.0-beta.3" --vm-driver="hyperv" --memory=1024 --hyperv-virtual-switch="minikube" --v=7 --alsologtostderr

kubectl config use-context minikube

@FOR /f "tokens=*" %i IN ('minikube docker-env') DO @%i
```

### Linux and VirtualBox (Windows 7/8/8.1)

```
minikube start

kubectl config use-context minikube

eval $(minikube docker-env)
```

### macOS

```
minikube start --vm-driver=xhyve

kubectl config use-context minikube

eval $(minikube docker-env)
```

After starting up the MiniKube VM and configuring `kubectl` and Docker, let's see if it works!

1. View Cluster Information with `kubectl cluster-info`

2. Bring up the Kubernetes Dashboard with `minikube dashboard`.

3. After that, you could check `minikube`'s version with `minikube version`.

4. You could do the same for `kubectl` with `kubectl version`.

## Additional Notes

Also, if you're experiencing bugs or technical problems, you could try these commands:

- **Stop the MiniKube VM** with `minikube stop`
- **Delete the MiniKube VM** with `minikube delete`
