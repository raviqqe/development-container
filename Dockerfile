FROM archlinux/base

RUN pacman -Syu --noconfirm base-devel clang gcc9 git llvm ruby zsh
RUN useradd -mG wheel -s /usr/bin/zsh raviqqe

USER raviqqe

RUN git clone https://github.com/raviqqe/dotfiles ~/.dotfiles
RUN cp ~/.dotfiles/profile ~/.profile
RUN ~/.dotfiles/local/bin/update-homebrew
RUN rcup -f
RUN update

ENTRYPOINT tail -f /dev/null
