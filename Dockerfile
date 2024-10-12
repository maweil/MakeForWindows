FROM registry.fedoraproject.org/fedora:40
RUN dnf install -y mingw64-gcc make wine-core
