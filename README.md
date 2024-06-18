# Homebrew repository for tonidy/krunvm

This is a Homebrew repository for a fork of [you54f/krunvm](https://github.com/you54f/krunvm/) and its dependencies.

## Supported platforms

The formulae and bottles on this repository only support Sonoma Apple Silicon-based devices (M1 family).

## How do I install these formulae?

```
brew tap tonidy/krun
brew install krunvm
```

## Updating the formulae

Rough notes below

### Buildah

```
brew install --formula Formula/buildah.rb --build-bottle
cp Formula/buildah.rb /opt/homebrew/Library/Taps/tonidy/homebrew-krun/Formula/buildah.rb
brew bottle buildah
```

### libkrunfw

1. clone libkrunfw
2. install krunvm (you need it to build the kernel)
- Edit `fedora` to `docker.io/fedora`
3. run `./build_on_krunvm.sh`
4. `rm -rf linux-* tarballs .git libkrunfw*.dylib libkrunfw.so.*`
5. Archive the libkrunfw folder
   1. `tar -czvf v4.10.0-with_macos_prebuilts.tar.gz libkrunfw-4.10.0`
6. Upload to GH release
7. Update homebrew formula to reference new prebuilt kernel

```
brew install --formula Formula/libkrunfw.rb --build-bottle
cp Formula/libkrunfw.rb /opt/homebrew/Library/Taps/tonidy/homebrew-krun/Formula/libkrunfw.rb
brew bottle libkrunfw
```

### libkrun

```sh
cd ..
git clone https://github.com/containers/libkrun.git
cd libkrun
# Edit `fedora` to `docker.io/fedora`
./build_on_krunvm.sh
make
DYLD_LIBRARY_PATH=$PWD/../homebrew-krun/bottles/libkrunfw/4.1.0/lib ./build_on_krunvm.sh
make
tar -czvf v1.9.2-with_macos_prebuilts.tar.gz libkrun-1.9.2
# Upload to GH release
brew install --formula Formula/libkrun.rb --build-bottle
```


### krunvm

```sh
brew install --formula Formula/krunvm.rb --build-bottle
brew bottle krunvm
```
