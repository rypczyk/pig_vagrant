#!/bin/bash
DEBIAN_VERSION=0

function set_locale(){
	echo "Sprawdzam locale"
	grep -q '^pl_PL.UTF-8' /etc/locale.gen

	if [ $? -ne 0 ]
		then
			echo "pl_PL.UTF-8 UTF-8" >> /etc/locale.gen
			locale-gen --purge pl_PL.UTF-8
		else
			echo "Locale ustawione"
	fi
}

function get_debian_version(){
  DEBIAN_VERSION=$(cat /etc/issue|tr ' ' '\n'|grep '[0-9]')
}

function set_debian_repos(){
  if [ "$1" = '' ]
    then
      DV=$DEBIAN_VERSION
    else
      DV=$1
  fi
  case $DV in
    "4.0") echo '
#
# etch
#
deb     http://archive.debian.org/debian-archive/debian     etch main contrib non-free
deb-src http://archive.debian.org/debian-archive/debian     etch main contrib non-free
' > /tmp/$$repo;;
    "5.0") echo '
#
# lenny 
#
deb     http://archive.debian.org/debian-archive/debian     lenny main contrib non-free
deb-src http://archive.debian.org/debian-archive/debian     lenny main contrib non-free
' > /tmp/$$repo;;
    "6.0") echo '
#
# squeeze
#
deb http://ftp.pl.debian.org/debian/ squeeze main contrib non-free
deb-src http://ftp.pl.debian.org/debian/ squeeze main contrib non-free
deb http://security.debian.org/ squeeze/updates main
deb-src http://security.debian.org/ squeeze/updates main
' > /tmp/$$repo;;
	"7") echo '
#
# wheezy
#
deb http://ftp.pl.debian.org/debian/ wheezy main contrib non-free
deb-src http://ftp.pl.debian.org/debian/ wheezy main contrib non-free
deb http://security.debian.org/ wheezy/updates main
deb-src http://security.debian.org/ wheezy/updates main
# wheezy-updates, previously known as "volatile"
deb http://ftp.pl.debian.org/debian/ wheezy-updates main 
deb-src http://ftp.pl.debian.org/debian/ wheezy-updates main
' /tmp/$$repo;;
    *) echo "Nie wspierana wersja Debiana: $DV"
      return 1;;
  esac
  mv /tmp/$$repo /etc/apt/sources.list
}

set_locale
get_debian_version
set_debian_repos

apt-get update
export DEBIAN_FRONTEND=noninteractive
apt-get install -y nginx redis-server

