#/bin/sh
#
# entra no diretorio de trabalho 
#
#
# força a libguagem ser inglês
#
export LANG=en_us_8859_1

#
# verifica sistema
# no cygwin (windows) 
# se bem instalado deve
# funcionar sem as variaveis
#
MACH=`uname -a | cut -c1-5` 
if [ $MACH = "Linux" ];then 
export PATH=$PATH:/usr/local/grads
export GADDIR=/usr/local/grads
export GADLIB=/usr/local/grads
export GASCRP=/usr/local/grads
fi 


#
# workdisk 
#
mkdir WORKDISK
cd WORKDISK
#
# CRIA DATAS DE CONTROLE
#
if [ $1 ="" ];then
dir_data=`date +"%Y%m%d"`
grads_data=`date +"00Z%d%b%Y"`
grads_data2=`date +"00Z%d%b%Y" -d "1  days "`
data_rodada=`date +"%d/%m/%Y"`
else
let b="$1-1"
let c="$34+$1"
dir_data=`date +"%Y%m%d" -d "$1 days ago"`
grads_data=`date +"00Z%d%b%Y" -d "$b  days ago"`
grads_data2=`date +"00Z%d%b%Y" -d "$b  days ago"`
data_rodada=`date +"%d/%m/%Y" -d "$c  days ago"`
fi




#
# cria diretorio de produção
# e copia o script  calculador 
#
mkdir $dir_data  >>./LOG.prn 2>&1
cd $dir_data   >>./LOG.prn 2>&1




#---------------------------------------------------------------------
# ETA40KM
# Adquire os dados no site do CPTEC. 
# Atençao:  
# Verifique pois o CPTEC altera os caminhos sem avisar!!!
#----------------------------------------------------------------------
if [ $1 ="" ];then
data=`date +"%Y%m%d"`
datagrads=`date +"%d%b%Y" -d "1 days"` 
hora="00"
else
let b="$1-1"
data=`date +"%Y%m%d" -d "$1 days ago"`
datagrads=`date +"%d%b%Y" -d "$b  days ago"` 
hora="00"
fi
echo "["`date`"] BAIXANDO DADOS ETA 40KM "  >>./LOG.prn 2>&1
wget -nc ftp://ftp1.cptec.inpe.br/modelos/io/tempo/regional/Eta40km_ENS/prec24/$data$hora/* >>./LOG.prn 2>&1
#
# existem 10 arquivos .bin
# separados fica dificil de trabalhar com os arquivos
# por isso vou juntar todos os .bin num único do arquivo
#
echo "["`date`"] CRIANDO ARQUIVOS PARA O GRADS" 
rm $data$hora".bin" >>./LOG.prn 2>&1 
rm *.ctl            >>./LOG.prn 2>&1   
for file in `ls -1 *.bin`
do
cat $file >>  $data$hora".bin"     
rm $file                            
done
file=`echo $data$hora".bin"`


#
#  crio o arquivo descriptor(CTL) de acordo com a data de hoje
#  YYYMMDDHH.BIN foi criado antes (todos os bin num unico bin)
#  eta40km.ctl é o nome para acessar YYYMMDDHH.BIN
#
let b="1"
echo "DSET ^"$data$hora".bin" >eta40km.ctl
echo "UNDEF -9999." >>eta40km.ctl 
echo "TITLE eta 10 dias" >>eta40km.ctl
echo "XDEF  144 LINEAR  -83.00   0.40" >>eta40km.ctl
echo "YDEF  157 LINEAR  -50.20   0.40" >>eta40km.ctl
echo "ZDEF   1 LEVELS 1000" >>eta40km.ctl
echo "TDEF   10 LINEAR 12Z"$datagrads" 24hr" >>eta40km.ctl
echo "VARS  1" >>eta40km.ctl
echo "PREC  0  99  Total  24h Precip.        (m)" >>eta40km.ctl
echo "ENDVARS" >>eta40km.ctl
#--------------------------------------------------------------------------------
#
#   CHUVA MERGE  
#--------------------------------------------------------------------------------
if [ $1 ="" ];then
grads_data=`date -d "34 days ago" +"12Z%d%b%Y"`
else
let b="$1-1"
let c="$34+$1"
grads_data=`date -d "$c days ago" +"12Z%d%b%Y"`
fi
if [ ! -f ./DADOS ];then 
mkdir ./DADOS            >>./LOG.prn 2>&1 
fi  
cd DADOS
#
# baixa as 63 ultimas chuvas. se jรก baixou passa adiante. 
#
for n in `seq --format=%02g 0 33`
do
download_data=`date +"%Y%m%d" -d "$n days ago"`
ano=`date +"%Y" -d "$n days ago"`
wget -nc ftp1.cptec.inpe.br/modelos/io/produtos/MERGE/$ano/prec_$download_data".bin" >>./LOG.prn 2>&1
done
cd ..
#
# cria o arquivo ctl 
#
echo "dset ^../DADOS/prec_%y4%m2%d2.bin" >chuvamerge.ctl
echo "options  little_endian template"                        >>chuvamerge.ctl
echo "title global daily analysis "                           >>chuvamerge.ctl
echo "undef -999.0 "                                          >>chuvamerge.ctl 
echo "xdef 245 linear    -82.8000 0.2000"                           >>chuvamerge.ctl
echo "ydef 313 linear -50.2000  0.2000 "                          >>chuvamerge.ctl
echo "zdef 1    linear 1 1 "                                  >>chuvamerge.ctl
echo "tdef 34 linear $grads_data 1dy "                         >>chuvamerge.ctl
echo "vars 2"                                                 >>chuvamerge.ctl
echo "rain     1  00 the grid analysis (0.1mm/day)"           >>chuvamerge.ctl
echo "gnum     1  00 the number of stn"                       >>chuvamerge.ctl
echo "ENDVARS"                                                >>chuvamerge.ctl
#


#----------------------------------------------------------
#
#  GFS
#
#----------------------------------------------------------
if [ $1 ="" ];then
dir_data=`date +"%Y%m%d"`
grads_data2=`date +"00Z%d%b%Y" -d "1  days "`
data_rodada=`date +"%d/%m/%Y"`
else
let b="$1-1"
let c="$34+$1"
dir_data=`date +"%Y%m%d" -d "$1 days ago"`
grads_data=`date +"00Z%d%b%Y" -d "$b  days ago"`
grads_data2=`date +"00Z%d%b%Y" -d "$b  days ago"`
data_rodada=`date +"%d/%m/%Y" -d "$c  days ago"`
fi


echo $dir_data >gfs.config   
#
# cria o .ctl 
#
echo "dset  "$dir_data"_1P0.bin" > gfs_1P0.ctl
echo "title xxx" >>gfs_1P0.ctl
echo "undef 9.999e+20" >>gfs_1P0.ctl
echo "xdef 51 linear -80 1.00" >>gfs_1P0.ctl
echo "ydef 51 linear -40 1.00" >>gfs_1P0.ctl
echo "zdef 1 levels 1000">>gfs_1P0.ctl
echo "tdef 16 linear "$grads_data2" 1dy" >>gfs_1P0.ctl 
echo "vars 1">>gfs_1P0.ctl
echo "chuva  0  t,y,x  ** chuva mm">>gfs_1P0.ctl
echo "endvars">>gfs_1P0.ctl
#
# executa o script calculador da média por bacia
#
echo "["`date`"] GERANDO MEDIAS DIARIAS PARA CADA BACIA "                   
grads -lbc "gfs.gs"  >>./LOG.prn 2>&1
