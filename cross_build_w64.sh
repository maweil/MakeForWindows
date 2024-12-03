#!/usr/bin/bash
set -e

# Verify tarball integrity first
echo "##############################"
echo "Verifying integrity of tarball"
echo "##############################"
sha256sum -c build_version.sha256sum

tarball=$(cat build_version.sha256sum | cut -d " " -f3)
make_version=${tarball%.tar.gz}
host_triplet="x86_64-w64-mingw32"
rm -rf "$make_version" || echo "No existing make directory"

tar -xzf "$tarball"
cd "$make_version"

# Cleanup target directory
rm -rf ./dist
mkdir -p ./dist
mkdir -p install_target

echo "##########################################"
echo "Building $make_version for $host_triplet"
echo "##########################################"
mingw64-configure --without-guile LDFLAGS='-Wl,--no-insert-timestamp' CFLAGS='-frandom-seed=$@'
mingw64-make && mv make.exe ./dist

if [[ $? -eq 0 ]]
then
  echo "################################"
  echo "Build complete. Result in ./$make_version/dist"
  echo "SHA256 hash of the built binary: $(sha256sum ./dist/make.exe)"
  echo "################################"
fi
