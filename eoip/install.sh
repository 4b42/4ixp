#!/bin/bash
#-----------------------------------------------------------------------#
# Copyright 2006-2018 by Kevin Buehl <kevin.buehl@4b42.com>             #
#-----------------------------------------------------------------------#
#  __          __    _____________    __          __    ______________  #
# |  |  2006  |  |  |   _______   \  |  |        |  |  |___________   | #
# |  |  2018  |  |  |  |       \  |  |  |        |  |              |  | #
# |  |___ ____|  |  |  |_______/  /  |  |___ ____|  |   ___________|  | #
# |______ ____   |  |   _______  |   |______ ____   |  |   ___________| #
#  by         |  |  |  |       \  \  Server      |  |  |  |             #
#    Kevin    |  |  |  |_______/  |   Management |  |  |  |___________  #
#      Buehl  |__|  |_____________/     System   |__|  |______________| #
#                                                                       #
# No part of this website or any of its contents may be reproduced,     #
# copied, modified or adapted, without the prior written consent of     #
# the author, unless otherwise indicated for stand-alone materials.     #
# For more Information visit www.4b42.com.                              #
# This notice must be untouched at all times.                           #
#-----------------------------------------------------------------------#
# https://www.4b42.com/support/kb/5c227f1f45dbe-Ethernet-over-IP-unter-Linux-Debian

# check if running on supported os
if ! [ -f "/etc/debian_version" ]; then
   echo "Only Debian/Ubuntu are supported. Please be patient or install it manually."
   exit 1
fi
# check if script run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
# first of all we take a look for system update
apt-get -qq update && apt-get -qq upgrade

# check if automake is installed
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' automake|grep "install ok installed")
echo Checking for automake: $PKG_OK
if [ "" == "$PKG_OK" ]; then
   echo "No automake installed. Installing..."
   apt-get -qq install automake
fi
# check if libtool is installed
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' libtool|grep "install ok installed")
echo Checking for libtool: $PKG_OK
if [ "" == "$PKG_OK" ]; then
   echo "No libtool installed. Installing..."
   apt-get -qq install libtool
fi
# check if make is installed
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' make|grep "install ok installed")
echo Checking for make: $PKG_OK
if [ "" == "$PKG_OK" ]; then
   echo "No make installed. Installing..."
   apt-get -qq install make
fi
# download and extract
mkdir -p /usr/src/eoip
wget --no-check-certificate -q https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/linux-eoip/linux-eoip-0.5.tgz -O /usr/src/eoip.tgz
tar -xzf /usr/src/eoip.tgz --strip 1 -C /usr/src/eoip
cd /usr/src/eoip
# install
./bootstrap.sh && ./configure && make && make install
