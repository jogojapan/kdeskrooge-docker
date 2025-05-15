FROM fedora:42

# Install only Skrooge and necessary dependencies
RUN dnf -y update && \
    dnf -y install \
    skrooge \
    dbus-x11 \
    libX11-xcb \
    libxcb \
    mesa-dri-drivers \
    qt5-qtbase \
    dbus \
    glibc-langpack-en \
    glibc-langpack-ja \
    google-noto-sans-cjk-jp-fonts \
    google-noto-serif-jp-fonts \
    ipa-gothic-fonts \
    ipa-mincho-fonts \
    vlgothic-fonts \
    && dnf clean all

# Create a non-root user
RUN useradd -m user
USER user
WORKDIR /home/user

RUN mkdir -p /home/user/.config /home/user/.local/share

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US:ja_JP

# Set environment variables for X11
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1

# Entry point to start Skrooge
CMD ["bash", "-c", "mkdir -p /tmp/dbus && dbus-daemon --session --address=unix:path=/tmp/dbus/session_bus_socket & export DBUS_SESSION_BUS_ADDRESS=unix:path=/tmp/dbus/session_bus_socket && skrooge"]
