#!/bin/bash

xhost +local:docker

docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /run/user/$(id -u)/pulse:/run/user/1000/pulse \
  -v $HOME/.config/pulse/cookie:/home/user/.config/pulse/cookie \
  -v $HOME/.config/skroogerc:/home/user/.config/skroogerc \
  -v $HOME/Documents:/home/user/Documents \
  --device /dev/dri \
  --name fedora42-skrooge \
  kdeskrooge

xhost -local:docker
