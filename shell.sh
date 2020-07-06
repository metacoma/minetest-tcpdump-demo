#!/bin/sh

docker run -it --rm --name ${CONTAINER_NAME}                         \
        -p 0.0.0.0:30000:30000/udp                                    \
        --entrypoint /bin/bash                                        \
        ${IMAGE}                                                      \
        -c /bin/bash || docker exec -ti ${CONTAINER_NAME} /bin/bash
