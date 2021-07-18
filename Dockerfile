FROM debian:latest
MAINTAINER KeiTachikawa <Keitachikawa@protonmail.com>
RUN apt-get update --fix-missing
RUN apt-get install -y tzdata
# set your timezone
RUN cat /etc/os-release
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN sh -c "apt-get install -y wget gpg sudo git adduser vim"
RUN sh -c 'wget -qO - "https://proget.hunterwittenborn.com/debian-feeds/makedeb.pub" | gpg --dearmor | sudo tee /usr/share/keyrings/makedeb-archive-keyring.gpg'
RUN sh -c "echo 'deb [signed-by=/usr/share/keyrings/makedeb-archive-keyring.gpg arch=all] https://proget.hunterwittenborn.com/ makedeb main' | sudo tee /etc/apt/sources.list.d/makedeb.list"
RUN sudo apt update --fix-missing;
RUN apt install makedeb figlet -y
RUN figlet "Makedeb Environment"
RUN sh -c 'adduser --disabled-password --gecos "" user'
RUN sudo adduser user sudo
USER user
RUN sh -c 'cd ~;mkdir -p ~/.vim'
RUN sh -c 'wget -c https://gist.githubusercontent.com/Aeres-u99/35da61f3677937e02088eecdcdf9475b/raw/82d9119b3bc9b2d7d8d737aa2499b41f2eb0c857/vimrc -O ~/.vim/.vimrc'
RUN figlet "Environment Ready"
USER root
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
