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
