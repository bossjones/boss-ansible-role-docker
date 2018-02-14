# NOTE: This is only used if you are doing delegated builds in molecule that require you to docker exec inside
FROM ubuntu:14.04

RUN apt-get -y update && apt-get install -y python rsync sudo bash \
    devscripts git aptitude ipython libssl-dev ntp \
    python-dev python-pip python-ipdb ruby tmux vim paxctl && \
    aptitude -y dist-upgrade && \
    apt-get clean
