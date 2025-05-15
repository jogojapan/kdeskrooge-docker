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
    && dnf clean all

# Create a non-root user
RUN useradd -m user
USER user
WORKDIR /home/user

RUN mkdir -p /home/user/.config /home/user/.local/share

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Set environment variables for X11
ENV DISPLAY=:0
ENV QT_X11_NO_MITSHM=1
ENV QT_STYLE_OVERRIDE=breeze-dark
ENV QT_QPA_PLATFORMTHEME=qt5ct

# Entry point to start Skrooge
CMD ["skrooge"]
