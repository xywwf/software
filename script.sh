#cat vim.scripts.conf | while read line; do
#echo $line
#done

#str="#abc"
#flag=${str:0:1}
#echo $flag
#if [ "$flag" = "#" ]; then
#	echo "is"
#else
#	echo "not"
#fi

#aa="aa/bb"
#if echo $aa |grep -q ".+\/.*"; then
#	echo "aaaaaaaaaaaaa"
#else
#	echo "bbbbbbbbbbbbb"
#fi

deal(){
	if [ -f "master" ]; then
		7za x master -xr!README*
		if [ -d "$1-master" ]; then
			cp -f -r $1-master/* vimfiles
			echo setup $1 OK!>>scripts.log
			rm master
			rm -r -f $1-master
		fi
	fi
}

down(){
	echo $1
	curl -C - -o master -k -L $1
}

if [ ! -d "vimfiles" ]; then
	mkdir vimfiles
fi

for line in $(sed -n '/^[^#].*/p' vim.scripts.conf); do
	if echo $line |grep -q ".+\/.*"; then
		name=${line#*/}
		url="https://github.com/$line/archive/master.zip"
	else
		name=$line
		url="https://github.com/vim-scripts/$line/archive/master.zip"
	fi
	down $url
	deal $name
done

if [ -f "vimfiles\Makefile" ]; then
	cd vimfiles
	mingw32-make
fi
