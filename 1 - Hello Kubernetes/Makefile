build:
	sudo docker build -t hello-kube:v1 .

test:
	sudo docker run -d -p 1337:1337 --rm --name hellokube hello-kube:v1

kill:
	sudo docker rm -f hellokube
