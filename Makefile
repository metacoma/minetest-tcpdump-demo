client:
	~/bin/minetest.sh

run:
	./run.sh

docker_image: 
	docker build -t metacoma/mine9wm:latest .  
  
push:
	docker push metacoma/mine9wm:latest

shell:
	./shell.sh
