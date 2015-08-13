#/bin/bash 
# #------------------------------------------------------------------------
# #
# #
# #  SCRIPT PARA ADQUIRIR PREVISOES DO ETA 10 DIAS DO CPTEC E 
# #  CALCULAR CHUVA ACUMULADA POR BACIA DO SIN 
# #
# #  VERSAO 2.0 
# #
# #
# #  bY regis  reginaldo.venturadesa@gmail.com 
# #  uso:
# #      adquire  [00/12]
# #    
# # ----------------------------------------------------------------------
# # Necessita de um arquivo contendo informaçoes sonre as bacias. 
# #  (ver como documentar isso aqui)
# #
# #
# #
# #------------------------------------------------------------------------- 
# #  TODO
# #   falta o script pegar dados anteriores a data de hoje
# #   ver uma forma das imagens por bacia ficarem no mesmo padrão.
# #   colocar o nome da bacia na figura
# #
# #--------------------------------------------------------------------------

#
# Pega data do dia (relogio do micro)
# DATA0 = data de hoje
# DATA1 = data de amanha (para os produtos)
# DATA2 = data de 7 dias a frente 
# 
data=`date +"%Y%m%d"`
DATA0=`date +"%d/%m/%Y"`
DATA1=`date +"%d/%m/%Y" -d "7 days"`
DATA2=`date +"%d/%m/%Y" -d "1 days"`
grads_data=`date +"00Z%d%b%Y"`
#
# Existem duas rodadas do modelo ao dia. Uma as 00Z e outra as 12Z
# se nada for informada na linha de comando assume-se 00z
#
#
# if [ "$1" = "" ];then 
# hora="00"
# else
# hora=$1
# fi 
#
# cria diretorio dos produtos do dia
#
cd CFS
cd SAIDAS
mkdir $data$hora
cd $data$hora

echo "'reinit'">grib2bin.gs
echo "'open temp.ctl'">>grib2bin.gs
echo "'q time'">>grib2bin.gs
echo "file=subwrd(result,3)">>grib2bin.gs
echo "'set lon 286 330'">>grib2bin.gs
echo "'set lat -34 5'">>grib2bin.gs
echo "'set fwrite -ap saida.bin'">>grib2bin.gs
echo "'set gxout fwrite'>>grib2bin.gs">>grib2bin.gs
echo "'d pratesfc*3600*6'">>grib2bin.gs
echo "'disable fwrite'">>grib2bin.gs
echo "pid=write("log.prn",file,append)">>grib2bin.gs
echo "'quit'">>grib2bin.gs


#
# Adquire os dados no site do CFS
# Atençao:  
#
wget  http://nomads.ncep.noaa.gov/pub/data/nccf/com/cfs/prod/cfs/cfs.$data/00/6hrly_grib_01
rm log.prn
rm saida.bin 
cat 6hrly_grib_01 | grep flxf | cut -d'"' -f2 | cut -c 1-33 > lista
for file in `cat lista | uniq `
do
wget -nc  http://nomads.ncep.noaa.gov/pub/data/nccf/com/cfs/prod/cfs/cfs.$data/00/6hrly_grib_01/$file
../../g2ctl.pl $file > temp.ctl
gribmap -i temp.ctl 
grads -lbc "../../grib2bin.gs"
done 


 # crio o arquivo descriptor(CTL) de acordo com a data de hoje
 # YYYMMDDHH.BIN foi criado antes (todos os bin num unico bin)
 # modelo_all.ctl é o nome para acessar YYYMMDDHH.BIN

#echo "DSET ^"$data$hora".bin" >modelo_all.ctl
echo "DSET ^saida.bin" >modelo_all.ctl
echo "UNDEF -9999." >>modelo_all.ctl 
echo "TITLE cfs  dias" >>modelo_all.ctl
echo "XDEF  47 LINEAR  286   0.9375" >>modelo_all.ctl
echo "YDEF  43 LEVELS  -33.543 -33.543 -32.598 -31.653 -30.709 -29.764 -28.819 -27.874 -26.929 -25.984">>modelo_all.ctl
echo " -25.039 -24.094 -23.15 -22.205 -21.26 -20.315 -19.37 -18.425 -17.48 -16.535">>modelo_all.ctl
echo " -15.59 -14.646 -13.701 -12.756 -11.811 -10.866 -9.921 -8.976 -8.031 -7.087">>modelo_all.ctl
echo " -6.142 -5.197 -4.252 -3.307 -2.362 -1.417 -0.472 0.472 1.417 2.362 3.307 4.252 5.197"  >>modelo_all.ctl
echo "ZDEF   1 LEVELS 1000" >>modelo_all.ctl
echo "TDEF   821 LINEAR  "$grads_data" 6hr">>modelo_all.ctl
echo "VARS  1" >>modelo_all.ctl
echo "PREC  0  99  Total  24h Precip.        (m)" >>modelo_all.ctl
echo "ENDVARS" >>modelo_all.ctl





cd ..



