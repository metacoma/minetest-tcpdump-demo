.EXPORT_ALL_VARIABLES:	
CONTAINER_NAME=minetest-tcpdump
IMAGE_NAME=metacoma/minetest-tcpdump:latest

client:
	~/bin/minetest.sh

run:
	echo > `pwd`/minetest_input
	./run.sh

docker_image: 
	docker build -t ${IMAGE_NAME} .  
  
push:
	docker push ${IMAGE_NAME}

shell:
	./shell.sh
