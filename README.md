### About
This is minetest mod (and environment) to start minetest server in a docker container and vizualise the tcpdump flow. Instead thousand of words, watch the video:

[![minetest-tcpdump-video](https://img.youtube.com/vi/pSENbiv_R_g/0.jpg)](https://www.youtube.com/watch?v=pSENbiv_R_g)


## Status:
This repo in WIP state, if you have any questions or proposals, feel free to create issue

## Requirements:
* docker
* tcpdump 
* gawk

## Tested on: 
* ubuntu 20.04 LTS.
* macOs Mojave (10.14.6)

## How-to

1. build image or pull image
```shell
make docker_image or docker pull metacoma/minetest-tcpdump:latest
```

2. Run the server
```shell
make run
```

3. Run the client
```shell
minetest --address 127.0.0.1  --go --name bc --password bc --verbose --info
```

4. Run tcpdump
```shell
	sudo ./tcpdump.sh > minetest_input
```

5. Enjoy flying ip packets ;-)

