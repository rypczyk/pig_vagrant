#!/bin/bash - 
WKH32="https://wkhtmltopdf.googlecode.com/files/wkhtmltoimage-0.11.0_rc1-static-i386.tar.bz2"
WKH64="https://wkhtmltopdf.googlecode.com/files/wkhtmltoimage-0.11.0_rc1-static-amd64.tar.bz2"
function ver(){
	wkhtmltopdf -V
	wkhtmltoimage -V
}
apt-get -y install wkhtmltopdf

# Jesli /usr/bin/wkhtmltoimage juz istnieje to pomijamy krok
if [ -f /usr/bin/wkhtmltoimage ]
	then
		ver
		exit 0
fi

cd /tmp
if [ $(arch) = i686 ]
	then
		wget $WKH32 -O wkhtmltoimage32.tar.bz2
		tar -xvjf wkhtmltoimage32.tar.bz2
		mv /tmp/wkhtmltoimage-i386 /usr/bin/wkhtmltoimage
	else		
		wget $WKH64 -O wkhtmltoimage64.tar.bz2
		tar -xvjf wkhtmltoimage64.tar.bz2
		mv /tmp/wkhtmltoimage-amd64 /usr/bin/wkhtmltoimage
fi

ver