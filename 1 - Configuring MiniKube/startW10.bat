REM Please update the Virtual Switch name.

minikube start --kubernetes-version="v1.6.0-beta.3" --vm-driver="hyperv" --memory=1024 --hyperv-virtual-switch="minikube" --v=7 --alsologtostderr

kubectl config use-context minikube

@FOR /f "tokens=*" %i IN ('minikube docker-env') DO @%i
