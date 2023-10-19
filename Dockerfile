FROM ubuntu:22.04

RUN apt-get update && \
    apt-get upgrade -yq && \
    apt-get install -yq \
            build-essential libncurses5-dev gdb flex \
            linux-modules-$(uname -r) bison libelf-dev qemu qemu-system \
            initramfs-tools bc cmake fzf fd-find git unzip wget tar

RUN mkdir -p ~/.config/gdb && touch ~/.config/gdb/gdbinit && \
    echo "add-auto-load-safe-path /root/linux/scripts/gdb/vmlinux-gdb.py" >> /root/.config/gdb/gdbinit && \
    echo "set auto-load safe-path /" >> /root/.config/gdb/gdbinit

RUN wget https://github.com/neovim/neovim-releases/releases/download/nightly/nvim-linux64.tar.gz && \
    tar xzf nvim-linux64.tar.gz && ln -s /nvim-linux64/bin/nvim /bin/vim && \
    rm /nvim-linux64.tar.gz

RUN mkdir -p ~/.config/ && git clone https://github.com/j-barnak/neovim-docker ~/.config/nvim
