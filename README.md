# GNU Make for Windows (x86_64) - **Inofficial**
This repository is meant to provide an easy way to cross-compile [GNU Make](https://www.gnu.org/software/make/) for Windows as binaries of the most recent version were previously hard to find. 

## Disclaimer
**Note:** This Repo is not the official binary release of GNU Make. Please visit the [GNU Make Website](https://www.gnu.org/software/make/) if you're looking for any official sources or binaries of the GNU project.
The goal of this repository is just to be able to build your own binaries to use Make on Windows. It was never endorsed or affiliated with the GNU Project or the Free Software Foundation.
By now, there are other installation methods for Make on Windows that are probably a lot more widely used than this repository, e.g. via Chocolately.

As the focus of this repository was sharing a way how to build current releases of Make from source and I don't use Make as often anymore, I'll stop providing binaries for Make.

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
