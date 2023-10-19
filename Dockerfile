FROM ubuntu:22.04

ARG USER=jared

RUN apt-get update && apt-get upgrade -yq && apt-get install -yq \
            build-essential libncurses5-dev gdb flex ccache bison libelf-dev \
            qemu qemu-system initramfs-tools bc cmake fzf fd-find git wget tar \
            ripgrep clangd linux-modules-$(uname -r)

RUN mkdir -p ~/.config/gdb && touch ~/.config/gdb/gdbinit # && \
    echo "add-auto-load-safe-path /home/$USER/linux/scripts/gdb/vmlinux-gdb.py" >> /home/$USER/.config/gdb/gdbinit && \
    echo "set auto-load safe-path /" >> /home/$USER/.config/gdb/gdbinit

RUN wget https://github.com/neovim/neovim-releases/releases/download/nightly/nvim-linux64.tar.gz && \
    tar xzf nvim-linux64.tar.gz && ln -s /nvim-linux64/bin/nvim /bin/vim && \
    rm /nvim-linux64.tar.gz

RUN mkdir -p ~/.config/ && git clone https://github.com/j-barnak/neovim-docker ~/.config/nvim

RUN groupadd -g 10001 $USER && useradd -u 10000 -g $USER $USER
USER $USER:$USER
WORKDIR /home/$USER
