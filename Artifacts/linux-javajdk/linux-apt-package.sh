#!/bin/bash

echo "Installing Java-JDK"

isApt=`command -v apt-get`
isYum=`command -v yum`

# Some of the previous commands will fail with an exit code other than zero (intentionally), 
# so we do not set error handling to stop (set e) until after they've run
set -e

if [ -n "$isApt" ] ; then
    echo "Using APT package manager"

    apt-get -y update
    
    curl --silent --location https://deb.nodesource.com/setup_4.x | bash -
    apt-get -y install apache2
    exit 0

elif [ -n "$isYum" ] ; then
    echo "Using YUM package manager"

    yum -y update
    yum clean all
    
    yum -y makecache
    yum -y install lvm2
    yum -y install java-1.8.0-openjdk-devel
    exit 0
fi

exit 1
