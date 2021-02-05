#!/bin/sh

## vars
path='../themes.json'
out='../docs/assets/img/themes/'
orig=$pwd

# create file to wget everything
#everything='egrep "image/title" $path'
#printf $everything


grep '\"image\":' $path | grep -o '"http.*' | sed -e 's/"//g' > links

start="$(ls -l $out | wc -l)"
start="$(($start - 1))"
limit="$(wc -l links | awk '{ print $1 }')"
limit="$(($start + $limit))"

mkdir imgs; cd imgs
for (( c=$start; c<$limit; c++ ))
do
  line="$(($c - $start + 1))"
  img="$(sed -n $line\p ../links)"
  wget "$img" -O "$c"
  mogrify -format webp "$c"
  rm "$c"
  mv "$c".webp "../$out"
done
rm -rf imgs links
#wget -i ../links

# get titles of the files


#convert * -quality 75 *--WebP.webp

# limited to png, needs to extend
# does not find files with extended file parameters, need to fix
  # wdwdwdwf.png?wd=36&kl=smart
  # lwwdw.jpg
#mogrify -format png *.jpg

# remove file after download
#rm links #; rm -rf imgs
