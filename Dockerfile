FROM registry.fedoraproject.org/fedora:41
RUN dnf --setopt=install_weak_deps=False install -y mingw64-gcc make wine-core
