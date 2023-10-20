# Linux Kernel Docker

## Instructions

Build and run the image
    
```
docker build -t linux-dev .
docker run --rm -it --mount src="$(pwd)",target=/root/linux,type=bind linux-dev
```

Necessary `.clangd` file for unsupported compiler option

```
CompileFlags:
  Add: -Wno-unknown-warning-option
  Remove: [-m*, -f*]
```

Build the root file system:

```
    mkinitramfs -o ramdisk.img
```

Script to run the linux kernel: 

```
qemu-system-x86_64 \
  -kernel arch/x86_64/boot/bzImage \
  -nographic \
  -append "console=ttyS0 nokaslr" \
  -initrd ramdisk.img \
  -m 512 \
  -s -S &
```
