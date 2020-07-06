#!/bin/sh -x


env
docker run --rm --name ${CONTAINER_NAME}                             \
        -e TERM=linux                                                 \
        -p 0.0.0.0:30000:30000/udp                                    \
        -v `pwd`/minetest_input:/tmp/minetest_input                    \
        -v `pwd`/games/mine9wm:/usr/local/games/mine9wm               \
        -v `pwd`/files/minetest.conf:/usr/local/etc/minetest.conf     \
        ${IMAGE_NAME}                                                      \
        --config /usr/local/etc/minetest.conf                         \
        --gameid mine9wm                                              
