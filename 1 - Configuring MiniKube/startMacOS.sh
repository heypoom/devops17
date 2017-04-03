minikube start --vm-driver=xhyve

kubectl config use-context minikube

eval $(minikube docker-env)
