FROM fedora:43

# Install build dependencies and runtime dependencies
RUN dnf -y update && \
    dnf -y install \
    gcc gcc-c++ make automake kernel-devel pkg-config \
    cmake devscripts cdbs extra-cmake-modules glibc kf6-kconfig \
    kf6-kcoreaddons kf6-kdbusaddons kf6-kdbusaddons-devel kf6-ki18n \
    libstdc++ qt6-qtbase qt6-qtbase-gui qt6-qtdeclarative skrooge-libs \
    sqlite3 sqlcipher sqlcipher-devel libsqlite3x-devel libofx-devel \
    boost-devel xsltproc kf6-ktexttemplate-devel qt6-qttools-devel \
    qt6-qtwebengine-devel kf6-kcoreaddons-devel kf6-kwallet-devel \
    kf6-kparts-devel kf6-knewstuff-devel kf6-kiconthemes-devel \
    kf6-kactivities-devel qt6-qtdeclarative-devel qt6-qtbase-devel \
    kf6-knotifications-devel kf6-kstatusnotifieritem-devel \
    qt6-qt5compat-devel kf6-kguiaddons-devel qt6-qtsvg-devel \
    kf6-knotifyconfig-devel grantlee-qt5-devel kf6-karchive-devel \
    kf6-kxmlgui-devel kf6-knotifyconfig-devel kf6-krunner-devel \
    kf6-plasma kf6-kdoctools-devel qca-qt6-devel kf6-kactivities-devel \
    qt6-qtdeclarative-devel qt6-qtquickcontrols2-devel \
    kf6-kirigami2-devel qt6-qtbase-private-devel \
    git dbus-x11 libX11-xcb libxcb mesa-dri-drivers qt6-qtbase \
    dbus glibc-langpack-en glibc-langpack-ja \
    google-noto-sans-cjk-jp-fonts google-noto-serif-jp-fonts \
    ipa-gothic-fonts ipa-mincho-fonts vlgothic-fonts \
    && dnf clean all

# Clone Skrooge repository and build from source
RUN cd /tmp && \
    git clone https://invent.kde.org/office/skrooge.git && \
    cd skrooge && \
    git checkout V26.1.20 && \
    mkdir build && \
    cd build && \
    cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DQT_PLUGIN_INSTALL_DIR=$(qmake6 -query QT_INSTALL_PLUGINS) \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    -DSKG_DESIGNER=OFF \
    -DQT_MAJOR_VERSION=6 && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/skrooge

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
