FROM archlinux/base

RUN pacman -Syu --noconfirm base-devel clang gcc9 git llvm ruby zsh
RUN useradd -mG wheel -s /usr/bin/zsh raviqqe

CMD tail -f /dev/null
