#/bin/sh
#
# entra no diretorio de trabalho 
#
cd GFS
dir_data=`date +"%Y%m%d"`
grads_data=`date +"00Z%d%b%Y"`
mkdir $dir_data
cd $dir_data
cp ../../gfs.gs .
echo $dir_data >gfs.config

echo "dset  "$dir_data".bin" > gfs.ctl
echo "title GFS 0.25 deg starting from 00Z08jul2015, downloaded Jul 08 04:44 UTC" >>gfs.ctl
echo "undef 9.999e+20" >>gfs.ctl
echo "xdef 200 linear -80 0.25" >>gfs.ctl
echo "ydef 200 linear -40 0.25" >>gfs.ctl
echo "zdef 1 levels 1000">>gfs.ctl
echo "tdef 81 linear "$grads_data" 180mn" >>gfs.ctl 
echo "vars 1">>gfs.ctl
echo "chuva  0  t,y,x  ** chuva mm">>gfs.ctl
echo "endvars">>gfs.ctl


grads -lbc "gfs.gs"
cd ..
cd ..

