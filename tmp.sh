mkdir images

for line in `cat time.csv`
do
  fname=`echo ${line} | cut -d ',' -f 1`
  str=`echo ${line} | cut -d ',' -f 2`
  convert -font Courier -pointsize 40 label:"$str" ./images/$fname.png
done

cp -r images images.for.movie
pushd images.for.movie
ls  | sort -t - -k 2 -n | xargs seqrename source
popd

ffmpeg -f image2 -r 1 -i images.for.movie/source%08d.png -r 1 -an -vcodec libx264 video.mp4

