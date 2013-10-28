#!/bin/bash - 
WKHI32="https://wkhtmltopdf.googlecode.com/files/wkhtmltoimage-0.11.0_rc1-static-i386.tar.bz2"
WKHI64="https://wkhtmltopdf.googlecode.com/files/wkhtmltoimage-0.11.0_rc1-static-amd64.tar.bz2"
WKHP64="http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.11.0_rc1-static-amd64.tar.bz2"
WKHP32="http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.11.0_rc1-static-i386.tar.bz2"
function ver(){
	wkhtmltopdf -V
	wkhtmltoimage -V
}

# Jesli /usr/bin/wkhtmltoimage juz istnieje to pomijamy krok
if [ ! -f /usr/bin/wkhtmltopdf ]
	then
	cd /tmp
	if [ $(arch) = i686 ]
		then
			wget $WKHP32 -O wkhtmltopdf32.tar.bz2
			tar -xvjf wkhtmltopdf32.tar.bz2
			mv /tmp/wkhtmltopdf-i386 /usr/bin/wkhtmltopdf
		else		
			wget $WKHP64 -O wkhtmltoimage64.tar.bz2
			tar -xvjf wkhtmltoimage64.tar.bz2
			mv /tmp/wkhtmltopdf-amd64 /usr/bin/wkhtmltopdf
	fi
fi

# Jesli /usr/bin/wkhtmltoimage juz istnieje to pomijamy krok
if [ ! -f /usr/bin/wkhtmltoimage ]
	then

	cd /tmp
	if [ $(arch) = i686 ]
		then
			wget $WKHI32 -O wkhtmltoimage32.tar.bz2
			tar -xvjf wkhtmltoimage32.tar.bz2
			mv /tmp/wkhtmltoimage-i386 /usr/bin/wkhtmltoimage
		else		
			wget $WKHI64 -O wkhtmltoimage64.tar.bz2
			tar -xvjf wkhtmltoimage64.tar.bz2
			mv /tmp/wkhtmltoimage-amd64 /usr/bin/wkhtmltoimage
	fi
fi
ver
