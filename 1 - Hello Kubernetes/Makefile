build:
	sudo docker build -t hello-kube .

test:
	sudo docker run -d -p 1337:1337 --rm --name hellokube hello-kube

kill:
	sudo docker rm -f hellokube
