FROM ubuntu:22.04

ARG USER=jared

RUN apt-get update && \
    apt-get upgrade -yq && \
    apt-get install -yq \
            build-essential libncurses5-dev libssl-dev gdb flex \
            linux-modules-$(uname -r) bison libelf-dev qemu qemu-system \
            initramfs-tools bc vim

RUN mkdir -p ~/.config/gdb && touch ~/.config/gdb/gdbinit && \
    echo "add-auto-load-safe-path /root/linux/scripts/gdb/vmlinux-gdb.py" >> /root/.config/gdb/gdbinit && \
    echo "set auto-load safe-path /" >> /root/.config/gdb/gdbinit

RUN useradd -ms /bin/bash $USER && groupadd -r $USER
