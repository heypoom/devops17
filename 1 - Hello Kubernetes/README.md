# Part 1: Hello, Kubernetes!

Now that the installation is over, let's run our first **Hello World Service** in Kubernetes.

## Step 1: Prepare the Container

First of all, we need a container for Kubernetes to deploy with.
I'm going to use **hello-kube** as the image name, with the **v1** tag.

To build the image: `sudo docker build -t hello-kube:v1 .`

Note: I'll provide `Makefiles` to save on typing.
Make sure you have `make` installed to use it, or you could manually run the command
shown in the `Makefile`. You can build the image using `make`, and run the image
using `make test`. Next, you could try it with `curl http://localhost:1337/test`.
After testing, remove the container with `make kill`.

## Step 2: Create a Deployment

In Kubernetes, there are concepts of Pods and Deployments.

**Pods** are **Groups of Containers**. Containers in a Pod will be able to internally
communicate with each other via their internal IP address.

**Deployments** will **automatically restart** the Pod if it is dead. You should
use that to manage your Pods, instead of managing it by yourself.

1. Create our first deployment with the `kubectl run` command. We're using the
