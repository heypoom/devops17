build:
	sudo docker build -t hello-kube:v1 .

test:
	sudo docker run -d -p 1337:1337 --rm --name hellokube hello-kube:v1

run:
	kubectl run hello-kube --image=hello-kube:v1 --port=1337
	kubectl expose deploy hello-kube --type=LoadBalancer

delete:
	kubectl delete deploy hello-kube
	kubectl delete service hello-kube

kill:
	sudo docker rm -f hellokube
