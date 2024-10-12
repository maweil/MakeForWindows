# GNU Make for Windows (x86_64)
This repository is meant to provide an easy way to cross-compile [GNU Make](https://www.gnu.org/software/make/) for Windows as trusted binaries of the most recent version were previously hard to find. 

## Using the Binaries
Head to the [Releases](https://github.com/maweil/MakeForWindows/releases) page to download `make.exe` together with any required `.dll` files as a `.zip`-file. Create a new directory, e.g. `C:\GNUMake` where you can later extract the archive to. Now unpack the downloaded archive to this directory using the Windows explorer (or another file compression utility of your choice).

To make sure that you can invoke the `make` command from a shell, add the directory you created previously to your PATH environment variable first.
You may have to restart your shell (or your system just to make sure) afterwards. You can then test whether `make` is installed properly by entering `make --version` into a shell.

The output should look similar to this:
```txt
GNU Make 4.4
Built for x86_64-w64-mingw32
Copyright (C) 1988-2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

## Building Locally
This part was tested on Fedora 37 only so far, so you may have to adapt the package names or install additional ones.
1. Install mingw64-gcc
2. Clone this repository
3. Download the `tar.gz` file of the GNU Make release
   
   Fetch the tarball you would like to build from the [project website](https://www.gnu.org/software/make/) or one of the mirrors listed there.

4. (Optional, but recommended): Verify the integrity of the downloaded file
   
   Download the corresponding `tar.gz.sig` file as well, which contains the signature of the tarball.
   Import the public key of the developer who signed the file. As of writing, the latest key for signing the releases was announced [here](https://lists.gnu.org/archive/html/bug-make/2016-12/msg00002.html). You can now verify the signature by running `gpg --verify make-*.tar.gz.sig`.

5. (Optional): Update the `build_version.sha256sum` file

   If you would like to build a version of GNU Make that differs from the latest one used here, you have to update the `build_version.tar.gz` file because it determines the filename and hash which the build-script uses later. To update it, run the following command (adapt to your make version number).
   ```bash
   sha256sum make-4.4.tar.gz > ./build_version.sha256sum
   ```
5. Compile

   Open a shell and run the `cross_build_w64.sh` script included in this repository.


If everything went well, you can find `make.exe` and its dependent `.dll` files in the `make-<your version>/dist` directory.

## Known Limitations
- The built binaries come without the [Guile Integration](https://www.gnu.org/software/make/manual/html_node/Guile-Integration.html) of GNU Make.
- Currently the builds are not reproducible. I'm still investigating what causes the differences. If you have an idea, how to adapt this repo to produce reproducible artifacts, PRs are welcome :smile:
- Limited Testing: I'm only using a tiny subset of Make's functionalities. If you encounter issues related to how these binaries are built, feel free to [create an issue](https://github.com/maweil/MakeForWindows/issues/new/choose). Please note however that I'm not a maintainer of GNU Make itself, I only have built this repository.
