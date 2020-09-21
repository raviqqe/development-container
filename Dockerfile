FROM archlinux

RUN pacman -Syu --noconfirm base-devel clang gcc9 git llvm openssh zsh
RUN useradd -mG wheel -s /usr/bin/zsh raviqqe
RUN passwd -d raviqqe
RUN sed -i 's/# \(%wheel.*NOPASSWD.*\)/\1/' /etc/sudoers
RUN echo PermitEmptyPasswords yes >> /etc/ssh/sshd_config

USER raviqqe

RUN git clone https://github.com/raviqqe/dotfiles ~/.dotfiles
RUN cp ~/.dotfiles/profile ~/.profile
RUN . ~/.profile && ~/.dotfiles/local/bin/update-homebrew
RUN . ~/.profile && rcup -f
RUN . ~/.profile && update

USER root

RUN ssh-keygen -A

EXPOSE 22

# TODO Somehow the following shell form does not work on Google Cloud Run.
# ENTRYPOINT foo bar
ENTRYPOINT ["/usr/bin/sshd", "-D"]
