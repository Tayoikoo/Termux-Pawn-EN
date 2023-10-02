# Pawn Compiler for Termux
> Method by DeviceBlack and BeerlID

# Requirements
- Android 7+ (Tested with: armv7, armv8 and aarch64)
- [Termux:App_v118.0 from F-Droid](https://f-droid.org/repo/com.termux_118.apk)

## How to install?
Follow the steps below.

### Configuring
update the repositories and allow access to the internal memory.
```sh
yes | pkg update -y && yes | pkg upgrade -y && termux-setup-storage
```

### Installing
cache the virtual file and run it.
```sh
curl -s https://raw.githubusercontent.com/Device-Black/Termux-Pawn/DeviceBlack/install.sh -o install.sh
bash install.sh
```

## How to Uninstall?
Follow the steps below.

### Uninstalling
remove the compiler files.
```sh
rm $PREFIX/bin/pawn* && rm $PREFIX/lib/libpawnc.so && exit
```

# Termux-Pawn

Translated with www.DeepL.com/Translator
