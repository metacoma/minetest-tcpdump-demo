#FROM webd97/minetestserver:latest
FROM ubuntu:bionic
ENV MINETEST_VERSION 5.2.0
RUN apt-get update && apt-get install -y build-essential wget libirrlicht-dev cmake libbz2-dev libpng-dev libjpeg-dev libxxf86vm-dev libgl1-mesa-dev libsqlite3-dev libogg-dev libvorbis-dev libopenal-dev libcurl4-gnutls-dev libfreetype6-dev zlib1g-dev libgmp-dev libjsoncpp-dev luarocks libyaml-dev sshpass ssh libncurses5-dev libncursesw5-dev
WORKDIR /tmp
RUN wget https://github.com/minetest/minetest/archive/${MINETEST_VERSION}.tar.gz && tar xf ${MINETEST_VERSION}.tar.gz && mv minetest-${MINETEST_VERSION} ./minetest && rm ${MINETEST_VERSION}.tar.gz 
WORKDIR /tmp/minetest
RUN cmake . -DRUN_IN_PLACE=TRUE -DBUILD_SERVER=TRUE -DBUILD_CLIENT=FALSE
ADD patch/cms_no_security.patch  .
RUN patch -p1 < ./cms_no_security.patch
RUN make -j $(nproc)
RUN make install
RUN luarocks install lyaml 
RUN luarocks install inspect

WORKDIR /usr/local
EXPOSE 30000
ENTRYPOINT ["/usr/local/bin/minetestserver"] 
CMD [""]

