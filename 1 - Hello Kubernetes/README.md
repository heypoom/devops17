# Part 1: Hello, Kubernetes!

Now that the installation is over, let's run our first **Hello World Service** in Kubernetes.

## Step 1: Prepare the Container

First of all, we need a container for Kubernetes to deploy with.
I'm going to use **hello-kube** as the image name, with the **v1** tag.

To **build the image**: `sudo docker build -t hello-kube:v1 .`

Note: I'll provide `Makefiles` to save on typing.
Make sure you have `make` installed to use it, or you could manually run the command
shown in the `Makefile`. You can build the image using `make`, and run the image
using `make test`. Next, you could try it with `curl http://localhost:1337/test`.
After testing, remove the container with `make kill`.

## Step 2: Create a Deployment

In Kubernetes, there are concepts of Pods and Deployments.

**Pods** are **Groups of Containers**. Containers in a Pod will be able to
talk with each other using their internal IP addresses, and share Storage Volumes.
Also, Pods are **not durable**. It might fail and die at anytime.

**Deployments** will **automatically restart** the Pod if it is dead. You should
use that to manage your Pods, instead of managing it manually by yourself.

Let's create our first deployment with the `kubectl run` command. We're using the
**hello-kube:v1** image and tag, and our deployment name is also **hello-kube**.
We're also telling Kubernetes that we'll need to use port **1337**.

1. Let's run the command.
   - `kubectl run hello-kube --image=hello-kube:v1 --port=1337`

2. Next, see if that works. Let's view the deployments that we've created.
   - `kubectl get deploy`
   - Note that `deploy` is short for `deployments`.

3. Remember, deployments just helps you to create pods. Let's view the Pods that are being created.
   - `kubectl get pods`
   - Also, `po` is short for `pods`, so you can do `kubectl get po`.

4. We can also view the events with `kubectl get events`, and view the config with `kubectl config view`.

## Step 3: Expose it to the Public!

Pods can only be accessed with the cluster internal IP by default.
We're going to **expose** the Pod to make it accessible from the outside internet.

The Pod will be exposed as a Kubernetes **Service**. We're going to use the **LoadBalancer**
type, which tells Kubernetes that we want to expose the service outside of the cluster.
We'll do that with the `kubectl expose` command.

1. Let's run the command.
   - `kubectl expose deploy hello-kube --type=LoadBalancer`
   - Again, `deploy` is short for `deployment`.

2. Now, view the services that you just created.
   - `kubectl get services`

3. On MiniKube, we'll be able to access that with the `minikube service` command.
   This will open up a browser window, pointing to your service.
   - `minikube service hello-kube`

4. Let's view logs inside you pod.
   - First, get the Pod's name with `kubectl get po`
   - Next, use the `kubectl logs <POD-NAME>` command.

## Summary for Part 1

### Concepts

**Pods** are Groups of Containers linked together. They can share IP address and storage. They're not durable.

**Deployments** are used to automatically restart dead Pods. Use this to manage your Pods.

**Services** abstract access to your Pods. Services with the `LoadBalancer` type will expose your pods to the public.

### Commands

Build Image: `sudo docker build -t hello-kube:v1 .`

Create a Deployment: `kubectl run hello-kube --image=hello-kube:v1 --port=1337`

Expose a Service: `kubectl expose deploy hello-kube --type=LoadBalancer`

Delete: `kubectl delete <deploy/service> hello-kube`

Get information: `kubectl get <deploy/pods/services>`

Get even more information: `kubectl describe <deploy/pods/services>`

View Logs: `kubectl logs <POD-NAME>`

Access Service on MiniKube: `minikube service hello-kube`
