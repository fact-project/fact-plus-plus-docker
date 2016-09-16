FROM ubuntu:16.04
MAINTAINER FACT People <kai.bruegge@tu-dortmund.de>

ARG CORES=4

RUN apt-get update \
	&& apt-get install -y  dpkg-dev make g++ gcc \
	binutils subversion libreadline-dev pkg-config \
	file ncurses-dev dbus libdbus-1-dev libmysqlclient-dev \
	libdbus-glib-1-dev libmysql++-dev libboost-all-dev libmotif-dev \
	automake libv8-dev libnova-dev libcfitsio-dev autoconf perl m4 \
	autoconf-archive libtool libccfits-dev libqt4-dev

RUN useradd -m fact

WORKDIR /home/fact

RUN svn checkout -r 18583 https://trac.fact-project.org/svn/trunk/FACT++ --trust-server-cert --non-interactive

ADD fix_uints.patch /home/fact/fix_uints.patch

RUN cd FACT++ \
	&& patch -p0 -i /home/fact/fix_uints.patch \
	&& autoreconf --force --install -I .macro_dir \
	&& ./configure --with-boost-libdir=/usr/lib/x86_64-linux-gnu \
	&& make -j$CORES \
	&& chown -R fact:fact .

WORKDIR /home/fact/FACT++
USER fact
CMD bash
