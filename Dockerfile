FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -yq && apt-get install -yq \
    build-essential libncurses5-dev gdb flex ccache bison libelf-dev qemu \
    qemu-system initramfs-tools bc cmake fzf fd-find git wget tar ripgrep \
    clangd linux-modules-$(uname -r) libssl-dev && \
    mkdir -p /root/.config/gdb && \
    touch /root/.config/gdb/gdbinit && \
    echo "add-auto-load-safe-path /root/linux/scripts/gdb/vmlinux-gdb.py" >> /root/.config/gdb/gdbinit && \
    echo "set auto-load safe-path /" >> /root/.config/gdb/gdbinit && \
    wget --progress=dot:giga https://github.com/neovim/neovim-releases/releases/download/nightly/nvim-linux64.tar.gz && \
    tar xzf nvim-linux64.tar.gz && ln -s /nvim-linux64/bin/nvim /bin/vim && \
    rm /nvim-linux64.tar.gz && mkdir -p /root/.config/ && \
    git clone https://github.com/j-barnak/neovim-docker /root/.config/nvim

WORKDIR /root
