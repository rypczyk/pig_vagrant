node -v >/dev/null 2>&1
if [ $? -ne 0 ]
	then
		cd /usr/src/
		mkdir node
		cd node
		apt-get install -y  curl build-essential openssl libssl-dev g++ python
		#wget -c -t 3 http://nodejs.org/dist/v0.10.21/node-v0.10.21.tar.gz
		wget -c -t 3 http://nodejs.org/dist/node-latest.tar.gz
		tar -xzf node-latest.tar.gz
		cd node-v*
		./configure && make && make install
fi

npm -v >/dev/null 2>&1
if [ $? -ne 0 ]
	then
		echo "Instalacja npm..."
		curl https://npmjs.org/install.sh | sh
fi

# To nienajlepsza metoda sprawdzania. 
if [ ! -d ~/.npm/bower ]
	then
		npm install bower
fi
if [ ! -d ~/.npm/requirejs ]
	then
		npm install requirejs
fi
