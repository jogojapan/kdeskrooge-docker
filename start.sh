#!/bin/bash

mkdir -p ./skrooge_config
mkdir -p ./skrooge_data

xhost +local:docker

docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -e LANG=en_US.UTF-8 \
  -e LC_ALL=en_US.UTF-8 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /run/user/$(id -u)/pulse:/run/user/1000/pulse \
  -v $(pwd)/skrooge_config:/home/user/.config \
  -v $(pwd)/skrooge_data:/home/user/.local/share/skrooge \
  -v $HOME/Documents:/home/user/Documents \
  -v /run/dbus:/run/dbus:ro \
  -v /etc/localtime:/etc/localtime:ro \
  --device /dev/dri \
  --name fedora42-skrooge \
  kdeskrooge

xhost -local:docker
