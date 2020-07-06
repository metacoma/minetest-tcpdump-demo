#!/bin/sh

. ./env
docker run -it --rm --name ${CONTAINER_INAME}                         \
        -p 0.0.0.0:30000:30000/udp                                    \
        --entrypoint /bin/bash                                        \
        ${IMAGE}                                                      \
        -c /bin/bash || docker exec -ti ${CONTAINER_INAME} /bin/bash
