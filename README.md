# zicOs Buildroot

Clone it:

```sh
git clone --recursive https://github.com/apiel/zicOs.git
cd zicOs
```

> [!TIP] 
> If the repository has already been cloned but submodules are missing, run the following command to pull them:
>
> ```sh
> git submodule update --init
> ```

Configure wifi:

Create a `.wpa_supplicant.conf` in the root of the repo (or edit `overlay/etc/wpa_supplicant.conf` for the target build):
```conf
network={
    ssid="your_ssid"
    psk="your_password"
}
```

## rpi zero 2w (pixel)

```sh
cd zero2w64
make initConfig
make
# or
# ZICBOX_PATH=/home/alex/Music/zicBox make
```


⚠️ **MacOS Users are recommended to use a Docker container**

Ensure you have [Docker installed](https://docs.docker.com/desktop/setup/install/mac-install/) and it's running.

```sh
docker --version
docker build -t zicos-builder .
```

With the container created, run the above. We noticed that on some machines you have to run `make` like this:

```sh
FORCE_UNSAFE_CONFIGURE=1 make
```

Upon success building, copy out of Docker to MacOS Desktop 

```sh
docker cp zicos-build:/workspace/zicOs/zero2w64/output/images/sdcard.img ~/Desktop/sdcard.img
```


## rpi 4

To be done / re-worked

## Hints

Use `dmesg` to see log of boot/initialisation of the board.




---

## Old stuff


What’s Inside:
- `configs/zicbox_defconfig`: starter config (CM4, SSH, Wi-Fi, PulseAudio, opkg)
- `board/zicbox/overlay/`: folder for system overlays (includes autostart script for `/opt/zicBox/pixel`)


Build it:

```sh
cd buildroot
make BR2_DEFCONFIG=../zicbox_defconfig defconfig
make
```

Flash `output/images/sdcard.img` to your SD card.

> [!TIP]
> Clean everything
>
> ```sh
> make distclean
> ```

To update an already configured buildroot, run `make menuconfig`, once updated, run `make`.

### RPi zero

Seems like it is better to make a specific build per hardware, giving better performances result.

```sh
cd buildroot
make BR2_DEFCONFIG=../raspberrypizero2w_defconfig defconfig
make
```







