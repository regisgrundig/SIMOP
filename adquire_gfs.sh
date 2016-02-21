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

mkdir GFS   >./LOG.prn 2>&1 
cd GFS       >>./LOG.prn 2>&1 
#
# configurador de dados quando se deseja rodar para o passado
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
cp ../../calcula_gfs_1P0.gs .
echo "["`date`"] ADQUIRINDO DADOS GFS  E GERANDO MEDIA POR BACIA" 
#
#  configurador de data para o grads
#
echo $dir_data >gfs.config   
#
# cria o .ctl 
#
echo "dset  "$dir_data"_1P0.bin" > gfs_1P0.ctl
echo "title GFS 1.0 deg starting from 00Z08jul2015, downloaded Jul 08 04:44 UTC" >>gfs_1P0.ctl
echo "undef 9.999e+20" >>gfs_1P0.ctl
echo "xdef 51 linear -80 1.00" >>gfs_1P0.ctl
echo "ydef 51 linear -40 1.00" >>gfs_1P0.ctl
echo "zdef 1 levels 1000">>gfs_1P0.ctl
echo "tdef 33 linear "$grads_data2" 12hr" >>gfs_1P0.ctl 
echo "vars 1">>gfs_1P0.ctl
echo "chuva  0  t,y,x  ** chuva mm">>gfs_1P0.ctl
echo "endvars">>gfs_1P0.ctl
#
# executa o script calculador 
#
grads -lbc "calcula_gfs_1P0.gs"  >>./LOG.prn 2>&1
echo "["`date`"] GERANDO FIGURAS POR BACIA" 
#------------------------------------------------------------------------------
#              AUTO SCRIPT PARA CRIAÇÃO DE FIGURAS
#-----------------------------------------------------------------------------------------
#  cria o script para data operativa por bacia cadastrada
#  as bacias estao cadastradas em CADASTRO/CADASTRADAS
# ver documentacao para maiores detalhes
#
echo "*"                                                                 >figura3.gs
echo "* esse script é auto gerado. documentação em adquire_eta.sh"      >>figura3.gs
echo "*By reginaldo.venturadesa@gmail.com "                             >>figura3.gs
echo "'open gfs_1P0.ctl'"            >>figura3.gs
#echo "*'set mpdset hires'"               >>figura3.gs
echo "'set gxout shaded'"               >>figura3.gs
#
# pega parametros de execucao do grads
# se é retrato ou paisagem
#
echo "'q gxinfo'"   >>figura3.gs
echo "var=sublin(result,2)"  >>figura3.gs
echo "page=subwrd(var,4)" >>figura3.gs
echo "*say page" >>figura3.gs
#
# se for retrato cria vpage
#
echo "if (page ="8.5") " >>figura3.gs
echo "'set parea 0.5 8.5 1.5 10.2'" >>figura3.gs
echo "endif"                                  >>figura3.gs
#
# a rotina varre o arquivo contendo os contornos das bacias
# para cada contorno encontrado ele gera as figuras
# 
echo "status2=0"                       >>figura3.gs
echo "while(!status2)" >>figura3.gs
echo 'fd=read("../../UTIL/limites_das_bacias.dat")' >>figura3.gs
echo "status2=sublin(fd,1) "    >>figura3.gs
echo "if (status2 = 0) "        >>figura3.gs
echo "linha=sublin(fd,2)"       >>figura3.gs
echo "bacia=subwrd(linha,4)"     >>figura3.gs
echo "shape=subwrd(linha,5)"     >>figura3.gs
echo "x0=subwrd(linha,6)"       >>figura3.gs
echo "x1=subwrd(linha,7)"       >>figura3.gs
echo "y0=subwrd(linha,8)"       >>figura3.gs
echo "y1=subwrd(linha,9)"       >>figura3.gs
echo "tipo=subwrd(linha,10)"     >>figura3.gs
echo "plota=subwrd(linha,11)"    >>figura3.gs
echo "'set lon 'x1' 'x0 "       >>figura3.gs
echo "'set lat 'y1' 'y0 "       >>figura3.gs
#------------------------------------------------------------------------------------
# caso a bacia se ja em forma de retrato 
# definido no arquivo limites_das_bacias em CONTORNOS/CADASTRADAS
#
#   FIGURAS RETRATO 
# 
echo "if (tipo = "RETRATO" & page ="8.5" & plota="SIM") "   >>figura3.gs
echo "t=1 "    >>figura3.gs 
echo "while (t<=33) "    >>figura3.gs 
echo "'set t 't"                     >>figura3.gs   
echo "'q time'"                           >>figura3.gs 
echo "var1=subwrd(result,3)"            >>figura3.gs
echo "ano1=substr(var1,9,4)"                       >>figura3.gs
echo "mes1=substr(var1,6,3)"                       >>figura3.gs
echo "dia1=substr(var1,4,2)"                       >>figura3.gs
echo "'c'"                        >>figura3.gs
echo "'set parea 0.5 8.5 1.5 10.2'"                                  >>figura3.gs
echo "'coresdiaria.gs'"                    >>figura3.gs
echo "'d sum(chuva,t='t',t='t+1')'"            >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 10.8     PRECIPITACAO ACUMULADA DIARIA GFS '"  >>figura3.gs
echo "'draw string 2.5 10.6 RODADA :"$data_rodada"'"               >>figura3.gs
echo "'draw string 2.5 10.4 DIA    :'dia1'/'mes1'/'ano1  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'" 								>>figura3.gs
echo "'basemap.gs O 50 0 M'" 										>>figura3.gs
echo "'set mpdset hires'" 											>>figura3.gs
echo "'set map 15 1 6'" 											>>figura3.gs
echo "'draw map'" 													>>figura3.gs
echo "if (bacia="brasil")"                    >>figura3.gs
echo "'plota.gs'"                             >>figura3.gs
echo "else"                    >>figura3.gs
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                  >>figura3.gs
echo "endif"                    >>figura3.gs
echo "'cbarn.gs'" >>figura3.gs
echo "'plota_hidrografia.gs'"     >>figura3.gs  
echo "plotausina(bacia,page)" >>figura3.gs    
echo "'printim 'bacia'_diario_'var1'.png white'"                       >>figura3.gs
echo "t=t+2"                    >>figura3.gs
echo "c"                    >>figura3.gs
echo "endwhile"                    >>figura3.gs
echo "endif" 					>>figura3.gs
#------------------------------------------------------------------------------------
# caso a bacia se ja em forma de paisagem 
# definido no arquivo limites_das_bacias em CONTORNOS/CADASTRADAS
#
#
#  FIGURA PAISAGEM 
#
echo "if (tipo = "PAISAGEM" & page ="11" & plota="SIM" ) "   >>figura3.gs
echo "t=1 "    >>figura3.gs 
echo "while (t<=33) "    >>figura3.gs 
echo "'set t 't"                     >>figura3.gs   
echo "'q time'"                           >>figura3.gs 
echo "var1=subwrd(result,3)"            >>figura3.gs
echo "ano1=substr(var1,9,4)"                       >>figura3.gs
echo "mes1=substr(var1,6,3)"                       >>figura3.gs
echo "dia1=substr(var1,4,2)"                       >>figura3.gs
echo "'c'"                        >>figura3.gs
echo "'c'"                        >>figura3.gs
echo "'set parea 0.5 10.5 1.88392 7.31608'"                     >>figura3.gs
echo "'coresdiaria.gs'"                    >>figura3.gs
echo "'d sum(chuva,t='t',t='t+1')'"         >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 8.3  PRECIPITACAO ACUMULADA DIARIA GFS'"  >>figura3.gs
echo "'draw string 2.5 8.1 RODADA :"$data_rodada"'"               >>figura3.gs
echo "'draw string 2.5 7.9 DIA    :'dia1'/'mes1'/'ano1  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs   
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                  >>figura3.gs
echo "say shape" >>figura3.gs
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  
echo "'printim 'bacia'_diaria_'var1'.png white'"                       >>figura3.gs
echo "'c'"                                                             >>figura3.gs
echo "t=t+2"                    >>figura3.gs
echo "'c'"                    >>figura3.gs
echo "endwhile"                    >>figura3.gs
#
# PARTE FINAL DO SCRIPT . NÃO MEXER 
#
echo "endif"                            							>>figura3.gs 
echo "endif"                            							>>figura3.gs 
echo "endwhile"                          							>>figura3.gs
#
# ESCALA  ATUAL 
#
echo "* escala SUGERIDA ">coresdiaria.gs
echo "*">>cores.gscoresdiaria
echo "'define_colors.gs'">>coresdiaria.gs
echo "'set rgb 99 251 94 107'">>coresdiaria.gs
echo "'set clevs    05 10 15 20 25 30 35  50  70  100  150'">>coresdiaria.gs
echo "'set ccols 00 44 45 47 49 34 37 39  22  23  27    29   99'  ">>coresdiaria.gs
echo "'quit'"                          								>>figura3.gs
#
#  cria arquivo de plotagem das bacias no mapa do brasil 
# 
echo "'set line 15 1 1'"                                             >plota.gs
echo "'draw shp ../../CONTORNOS/SHAPES/BRASIL.shp '"                 >>plota.gs
echo "'set line 1 1 1'"                                              >>plota.gs
for file in `ls -1 ../../CONTORNOS/SHAPES/contorno*.shp`
do
echo "'draw shp "$file"'"                                            >>plota.gs
done
#
#  plota a hidrografia  
# 
echo "'set line 5 1 1'"                                             >plota_hidrografia.gs
echo "'draw shp ../../CONTORNOS/SHAPES/hidrografia.shp '"                 >>plota_hidrografia.gs
echo "'set line 5 1 1'"                                             >>plota_hidrografia.gs
#
#  CRIA ESCALA DE CORES 
#   (PARA HABILITAR , RETIRE O * DA FRENTE DA LINHA E COLOQUE * NA QUE 
#    DESEJA DESABILITAR 
#
# ESCALA ANTIGA PARA GRANDES ACUMULOS
#
echo "* escala antiga 0 a 1000  " >cores.gs
echo "*'define_colors.gs' ">>cores.gs
echo "*'set clevs      1  10  20  30  40  50  60  70  80   90  100 125 150 175  200  225  250  275   300 325  350  375  400 425  450 475  500 550 600 650 700 800 900 1000'">>cores.gs
echo "*'set ccols  00 00  31  32  33  34  35  36  37  38   39  42  43   44  45   46   47   48   49   72   73    74   75  76   77   78  79  21  22  23  24  25  26  27  28  29 '">>cores.gs
echo "*'set gxout shaded'">>cores.gs
echo "* escala nova ">>cores.gs
echo "*'define_colors.gs'">>cores.gs
echo "*'set rgb 99  230 230 230'">>cores.gs
echo "*'set clevs      1  05 10 15 20 25 30 35 40 45 50 60 70 80 90 100 150 200 '">>cores.gs
echo "*'set ccols  00  99 99 32 33 34 35 36 37 38 39 45 46 47 48 49  26  27  28  29 '">>cores.gs
#
# ESCALA CPTEC
#
echo "* escala CPTEC">>cores.gs 
echo "*'define_colors.gs'">>cores.gs
echo "*'set rgb 99  230 230 230'">>cores.gs
echo "*light green to dark green">>cores.gs
echo "*'set rgb 31 230 255 225'">>cores.gs
echo "*'set rgb 32 200 255 190'">>cores.gs
echo "*'set rgb 33 180 250 170'">>cores.gs
echo "*'set rgb 34 150 245 140'">>cores.gs
echo "*'set rgb 35 120 245 115'">>cores.gs
echo "*'set rgb 36  80 240  80'">>cores.gs
echo "*'set rgb 37  5 138  00'">>cores.gs
echo "*'set rgb 38  38 111  27'">>cores.gs
echo "*'set rgb 39  58 111  58'">>cores.gs
echo "*'set clevs      1  05 10 15 20 25 30 35 40 50 60 70  '">>cores.gs
echo "*'set ccols  00  28 27 25 23 22 21 41 42 35 36 37 38 39 '">>cores.gs
echo "*'set gxout shaded'">>cores.gs
#
# ESCALA ONS OLD
#
echo "*">>cores.gs
echo "* escala ONS semanal old">>cores.gs
echo "*">>cores.gs
echo "*'define_colors.gs'">>cores.gs
echo "*'set clevs 00 01 10 25 50 75 100 150 200'">>cores.gs
echo "*'set ccols 00 41 42 43 '">>cores.gs
#
# ESCALA ONS ATUAL 
#
echo "* escala baseada no ONS ">>cores.gs
echo "*'define_colors.gs'">>cores.gs
echo "*'set rgb 99 251 94 107'">>cores.gs
echo "*'set clevs    01 05 10 15 20 25 30 40 50 75 100 150 200'">>cores.gs
echo "*'set ccols 41 42 43 47 49 34 37 39 22 23 27  99'  ">>cores.gs
echo "*">>cores.gs
#
# ESCALA  ATUAL 
#
echo "* escala SUGERIDA ">>cores.gs
echo "*">>cores.gs
echo "'define_colors.gs'">>cores.gs
echo "'set rgb 99 251 94 107'">>cores.gs
echo "'set clevs    20 25 30 40 50 75 100 150 200 250 300'">>cores.gs
echo "'set ccols 00 44 45 47 49 34 37 39  22  23  27  29 99'  ">>cores.gs
echo "* escala SUGERIDA ">coresdiaria.gs
echo "*">>cores.gscoresdiaria
echo "'define_colors.gs'">>coresdiaria.gs
echo "'set rgb 99 251 94 107'">>coresdiaria.gs
echo "'set clevs    05 10 15 20 25 30 35  50  70  100  150'">>coresdiaria.gs
echo "'set ccols 00 44 45 47 49 34 37 39  22  23  27    29   99'  ">>coresdiaria.gs
#
#  cria arquivo de plotagem das bacias no mapa do brasil 
# 
echo "'set line 15 1 1'"                                             >plota.gs
echo "'draw shp ../../CONTORNOS/SHAPES/BRASIL.shp '"                 >>plota.gs
echo "'set line 1 1 1'"                                              >>plota.gs
for file in `ls -1 ../../CONTORNOS/SHAPES/contorno*.shp`
do
echo "'draw shp "$file"'"                                            >>plota.gs
done
#
#  plota a hidrografia  
# 
echo "'set line 5 1 1'"                                             >plota_hidrografia.gs
echo "'draw shp ../../CONTORNOS/SHAPES/hidrografia.shp '"                 >>plota_hidrografia.gs
echo "'set line 5 1 1'"                                             >>plota_hidrografia.gs
#
# ESCALA  cores diaria 
#
echo "* escala SUGERIDA ">coresdiaria.gs
echo "*">>cores.gscoresdiaria
echo "'define_colors.gs'">>coresdiaria.gs
echo "'set rgb 99 251 94 107'">>coresdiaria.gs
echo "'set clevs    00 05 10 15 20 25 30 35  50  70  100  150'">>coresdiaria.gs
echo "'set ccols 00 43 45 47 49 34 37 39 25  27  29   57   58 59'  ">>coresdiaria.gs
echo "["`date`"] CRIANDO FIGURAS OBSERVADO"                                         >>plota_hidrografia.gs
#------------------------------------------------------------------------------
#  FIM DO AUTOSCRIPT DE CRIAÇÃO DE FIGURAS
#------------------------------------------------------------------------------
#
#
#  adiciona o scripts o script que plota bacias
#
cat  ../../UTIL/modulo_grads.mod  >> figura3.gs
#
#  EXECUTA O SCRIPT GERADO PELO AUTO SCRIPT PARA GERAÇÃO DE FIGURAS
#
grads -lbc "figura3.gs"  >>./LOG.prn 2>&1
grads -pbc "figura3.gs"  >>./LOG.prn 2>&1

#
# COPIA AS FIGURAS GERADAS PARA O DIRETORIA DIARIO
#
mkdir diaria >>./LOG.prn 2>&1
mv *.png  diaria
echo "["`date`"] FIM DO PROCESSO GFS" 

cd ..
cd ..

