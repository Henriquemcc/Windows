#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Installing on RPM Based Distros
if [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ] || [ "$(get_os_type)" == "almalinux" ]; then
  dnf install cryptsetup --assumeyes

# Installing on DEB Based Distros
elif [ "$(get_os_type)" == "ubuntu" ] || [ "$(get_os_type)" == "debian" ]; then
  apt install -y cryptsetup
fi
