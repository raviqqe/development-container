FROM archlinux/base

RUN pacman -Syu --noconfirm base-devel clang gcc9 git llvm python3 ruby zsh
RUN useradd -mG wheel -s /usr/bin/zsh raviqqe
RUN passwd -d raviqqe
RUN sed -i 's/# \(%wheel.*NOPASSWD.*\)/\1/' /etc/sudoers

USER raviqqe

RUN git clone https://github.com/raviqqe/dotfiles ~/.dotfiles
RUN cp ~/.dotfiles/profile ~/.profile
RUN . ~/.profile && ~/.dotfiles/local/bin/update-homebrew
RUN . ~/.profile && rcup -f
RUN . ~/.profile && update

USER nobody

RUN mkdir /tmp/nodata

WORKDIR /tmp/nodata

EXPOSE 8080

ENTRYPOINT python3 -m http.server 8080
