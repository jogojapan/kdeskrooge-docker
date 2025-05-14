#!/bin/bash

mkdir -p ./skrooge_config
mkdir -p ./skrooge_data

xhost +local:docker

docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /run/user/$(id -u)/pulse:/run/user/1000/pulse \
  -v $(pwd)/skrooge_config:/home/user/.config \
  -v $(pwd)/skrooge_data:/home/user/.local/share/skrooge \
  -v $HOME/Documents:/home/user/Documents \
  --device /dev/dri \
  --name fedora42-skrooge \
  kdeskrooge

xhost -local:docker
