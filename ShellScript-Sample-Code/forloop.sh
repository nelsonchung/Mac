for i in $(seq 1 25)
	do
	svnlist[i]=`svn list http://172.18.1.5/svn/wimax/mt7119/branches/ | sed -n "${i},${i+1}p"`

	echo ${svnlist[i]}
	done

