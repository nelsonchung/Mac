if test -z $1
	then echo "get default tar file."
	scp nelson@172.18.1.5:/home/nelson/web_update.tar.gz ./
else
	echo "get other files - "$1
	scp nelson@172.18.1.5:/home/nelson/$1 ./
fi
