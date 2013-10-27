#!/bin/bash
CACHE=/vagrant/cache/$(arch)
ARCH=$(arch)
mkdir -p $CACHE
/bin/ls -1 $CACHE|grep -q "nginx.*.deb"
if [ $? -ne 0 ]
	then
		cd /usr/src
		mkdir pagespeed && cd pagespeed
		apt-get -y install libxslt1.1 dpkg-dev build-essential zlib1g-dev libpcre3 libpcre3-dev
		apt-get -y source nginx
		apt-get -y build-dep nginx
		cd nginx-*
		cd debian/modules
		git clone https://github.com/pagespeed/ngx_pagespeed.git
		cd ngx_pagespeed

		# tego wymaga ngx_pagespeed i bez tego sie nie kompiluje.... 
		wget https://dl.google.com/dl/page-speed/psol/1.6.29.5.tar.gz
		tar -xzf 1.6.29.5.tar.gz
		cd ../../../
		sed -i 's#$(CONFIGURE_OPTS) >$@#--add-module=$(MODULESDIR)/ngx_pagespeed $(CONFIGURE_OPTS) >$@#' debian/rules
		dpkg-buildpackage -b
		cd /usr/src/pagespeed
		cp nginx-common_1*.deb nginx_1*.deb nginx-full_1*.deb $CACHE
fi
cd $CACHE
dpkg -i nginx-common_1*.deb nginx_1*.deb nginx-full_1*.deb
mkdir -p /var/ngx_pagespeed_cache
chown www-data:www-data /var/ngx_pagespeed_cache
