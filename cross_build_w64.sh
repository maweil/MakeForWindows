#!/usr/bin/bash
set -e
copy_dependent_dlls(){
  local parent_exe_or_dll="$1"
  local dll_source_dir="/usr/$host_triplet"
  local all_dlls=($(x86_64-w64-mingw32-objdump -p "$parent_exe_or_dll" | grep 'DLL Name:' | sed -e "s/\t*DLL Name: //g"))
  for dll_name in ${all_dlls[@]}
  do
    echo "Searching $dll_name" in $dll_source_dir
    find "$dll_source_dir" -name "$dll_name" -exec cp "{}" ./dist \;
    dist_dll_path="./dist/$dll_name"
    if [[ -f "$dist_dll_path" ]]
    then
      copy_dependent_dlls "$dist_dll_path"
    fi
  done
}



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
# By default, --export-dynamic is used which is not supported for PE binaries. 
# Therefore override the LDFLAGS accordingly
LDFLAGS='-Wl,--export-all-symbols -fstack-protector -lssp' mingw64-configure --without-guile
mingw64-make && mv make.exe ./dist
if [[ $? -eq 0 ]]
then
  echo "#######################################"
  echo "Copying needed shared libraries to dist"
  echo "#######################################"

  copy_dependent_dlls ./dist/make.exe
  
  echo "################################"
  echo "Build complete. Result in ./dist"
  echo "################################"
fi
