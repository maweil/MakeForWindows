FROM registry.fedoraproject.org/fedora:37
RUN dnf install -y mingw64-gcc wine-core
