# Use phusion/baseimage if problems arise
FROM ubuntu:14.04
MAINTAINER Jay Kamat

# This dockerimage will allow us to run our travis CI builds in docker! We should probably make a baseimage (perhaps the existing robocup-baseimage?)for this to speed up our compiles dramatically

# Setup apt to be happy with no console input
ENV DEBIAN_FRONTEND noninteractive

# setup apt tools and other goodies we want
RUN apt-get update --fix-missing && apt-get -y install apt-utils wget curl htop iputils-ping vim-nox less debconf-utils w3m git software-properties-common sudo scons screen && apt-get clean

# do everything in root's home
WORKDIR /root

# clone repo
RUN git clone git://github.com/RoboJackets/robocup-software


# TEMPORARY fix for not including firmware toolchain in ubuntu-setup
RUN sudo apt-get -y remove binutils-arm-none-eabi gcc-arm-none-eabi &&\
        sudo add-apt-repository ppa:terry.guo/gcc-arm-embedded &&\
        sudo apt-get update &&\
        sudo apt-get -y install gcc-arm-none-eabi


#TODO make ubuntu-setup take a force yes argument
RUN yes | robocup-software/util/ubuntu-setup && sudo apt-get clean
# try to make dockerimages smaller

# Do a baseline make to speed up future compiles
WORKDIR /root/robocup-software
RUN make && make test-cpp && make robot2015

