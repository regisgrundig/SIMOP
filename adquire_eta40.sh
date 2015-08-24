#/bin/bash 
#------------------------------------------------------------------------
#
#
#  SCRIPT PARA ADQUIRIR PREVISOES DO ETA 10 DIAS DO CPTEC E 
#  CALCULAR CHUVA ACUMULADA POR BACIA DO SIN 
#
#  VERSAO 2.0 
#
#
#  bY regis  reginaldo.venturadesa@gmail.com 
#  uso:
#      adquire  [00/12]
#    
# ----------------------------------------------------------------------
# Necessita de um arquivo contendo informaçoes sonre as bacias. 
#  (ver como documentar isso aqui)
#
#
#
#------------------------------------------------------------------------- 
#  TODO
#   falta o script pegar dados anteriores a data de hoje
#   ver uma forma das imagens por bacia ficarem no mesmo padrão.
#   colocar o nome da bacia na figura
#
#--------------------------------------------------------------------------

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
export GADDIR=/opt/opengrads
export GADLIB=/opt/opengrads
export GASCRP=/opt/opengrads
fi 


MODDEBUG=1 
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

#
# Existem duas rodadas do modelo ao dia. Uma as 00Z e outra as 12Z
# se nada for informada na linha de comando assume-se 00z
#
#
if [ "$1" = "" ];then 
hora="00"
else
hora=$1
fi 
#
# cria diretorio dos produtos do dia
#
# verifica se existe diretorio SAIDA. se não cria.
#
if [ ! -f ./SAIDAS ];then 
mkdir ./SAIDAS            >./LOG.prn 2>&1 
fi  
# entra no direotiro SAIDA e depois diretorio da data do dia
# onde tudo aocntece. 
cd SAIDAS
mkdir $data$hora    >>./LOG.prn 2>&1 
cd $data$hora

echo "["`date`"] BAIXANDO DADOS" 
#
# Adquire os dados no site do CPTEC. 
# Atençao:  
# Verifique pois o CPTEC altera os caminhos sem avisar!!!
#
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
# caso ele não exista , algo muito errado aconteceu
#
if [ ! -s $file ]
then
 exit
fi 

#
#  crio o arquivo descriptor(CTL) de acordo com a data de hoje
#  YYYMMDDHH.BIN foi criado antes (todos os bin num unico bin)
#  modelo_all.ctl é o nome para acessar YYYMMDDHH.BIN
#
echo "DSET ^"$data$hora".bin" >modelo_all.ctl
echo "UNDEF -9999." >>modelo_all.ctl 
echo "TITLE eta 10 dias" >>modelo_all.ctl
echo "XDEF  144 LINEAR  -83.00   0.40" >>modelo_all.ctl
echo "YDEF  157 LINEAR  -50.20   0.40" >>modelo_all.ctl
echo "ZDEF   1 LEVELS 1000" >>modelo_all.ctl
echo "TDEF   10 LINEAR 12Z"`date +"%d%b%Y" -d "1 days"`" 24hr" >>modelo_all.ctl
echo "VARS  1" >>modelo_all.ctl
echo "PREC  0  99  Total  24h Precip.        (m)" >>modelo_all.ctl
echo "ENDVARS" >>modelo_all.ctl


#-----------------------------------------------------------------------------------------
#  cria o script para data operativa por bacia cadastrada
#  as bacias estao cadastradas em CADASTRO/CADASTRADAS
# ver documentacao para maiores detalhes
#
echo "*"                                                              >figura3.gs
echo "* esse script é auto gerado. documentação em adquire_eta.sh"   >>figura3.gs
echo "*By reginaldo.venturadesa@gmail.com "                             >>figura3.gs
echo "'open modelo_all.ctl'"            >>figura3.gs
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
# Script grads: acha o dia que cai na sexta
#
echo "t0=10"                            >>figura3.gs  
echo "'set t 2 last'"                   >>figura3.gs
echo "'q time'"                         >>figura3.gs
echo "var3=subwrd(result,5)"            >>figura3.gs
echo "tt=1"                             >>figura3.gs
echo "while (tt<=10)"                   >>figura3.gs
echo "'set t ' tt"                      >>figura3.gs
echo "'q time'"                         >>figura3.gs
echo "var=subwrd(result,6)"             >>figura3.gs
echo "if (var = "Fri" )"                >>figura3.gs
echo "t0=tt"                            >>figura3.gs
echo "tt=12"                            >>figura3.gs
echo "endif"                            >>figura3.gs
echo "tt=tt+1"                          >>figura3.gs
echo "endwhile"                         >>figura3.gs
echo "*say t0"                           >>figura3.gs
echo "t2=t0+1"                       >>figura3.gs
#
# pega informacoes
# de data
# data de inicio 
# data do sabado 
# data final 
#

echo "'set t 1 't2"                     >>figura3.gs
echo "'q time'"                         >>figura3.gs
echo "var1=subwrd(result,3)"            >>figura3.gs
echo "var2=subwrd(result,5)"            >>figura3.gs
echo "'set t 1 last'"                     >>figura3.gs   
echo "'q time'"                           >>figura3.gs 
echo "var3=subwrd(result,5)"            >>figura3.gs
echo "ano1=substr(var1,9,4)"                       >>figura3.gs
echo "mes1=substr(var1,6,3)"                       >>figura3.gs
echo "dia1=substr(var1,4,2)"                       >>figura3.gs
echo "ano2=substr(var2,9,4)"                       >>figura3.gs
echo "mes2=substr(var2,6,3)"                       >>figura3.gs
echo "dia2=substr(var2,4,2)"                       >>figura3.gs
echo "ano3=substr(var3,9,4)"                       >>figura3.gs
echo "mes3=substr(var3,6,3)"                       >>figura3.gs
echo "dia3=substr(var3,4,2)"                       >>figura3.gs


#
# a rotina varre o arquivo contendo os contornos das bacias
# para cada contorno encontrado ele gera as figuras
# 
echo "status2=0"                       >>figura3.gs
echo "while(!status2)" >>figura3.gs
echo 'fd=read("../../CONTORNOS/CADASTRADAS/limites_das_bacias.dat")' >>figura3.gs
echo "status2=sublin(fd,1) "    >>figura3.gs
echo "if (status2 = 0) "        >>figura3.gs
echo "linha=sublin(fd,2)"       >>figura3.gs
echo "bacia=subwrd(linha,1)"     >>figura3.gs
echo "shape=subwrd(linha,2)"     >>figura3.gs
echo "x0=subwrd(linha,3)"       >>figura3.gs
echo "x1=subwrd(linha,4)"       >>figura3.gs
echo "y0=subwrd(linha,5)"       >>figura3.gs
echo "y1=subwrd(linha,6)"       >>figura3.gs
echo "tipo=subwrd(linha,7)"     >>figura3.gs
echo "plota=subwrd(linha,8)"     >>figura3.gs
echo "'set lon 'x1' 'x0 "       >>figura3.gs
echo "'set lat 'y1' 'y0 "       >>figura3.gs
#------------------------------------------------------------------------------------
# caso a bacia se ja em forma de retrato 
# definido no arquivo limites_das_bacias em CONTORNOS/CADASTRADAS
#
#   FIGURAS RETRATO SEMANA OPERATIVA 1
# 
echo "if (tipo = "RETRATO" & page ="8.5" & plota="SIM") "   >>figura3.gs
echo "'c'"                        >>figura3.gs
echo "'set parea 0.5 8.5 1.5 10.2'"                                  >>figura3.gs
echo "'set t 1'"                        >>figura3.gs
echo "'cores.gs'"                    >>figura3.gs
echo "'d sum(prec,t=1,t='t0')'"         >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 10.8 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 1'"  >>figura3.gs
echo "'draw string 2.5 10.6 RODADA:"$DATA0" - "$hora"Z'"                >>figura3.gs
echo "'draw string 2.5 10.4 PERIODO:'dia1'/'mes1'/'ano1' a 'dia2'/'mes2'/'ano2  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs
echo "if (bacia="brasil")"                    >>figura3.gs
echo "'plota.gs'"                             >>figura3.gs
echo "else"                    >>figura3.gs
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                  >>figura3.gs
echo "endif"                    >>figura3.gs
echo "'cbarn.gs'" >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs    
echo "'plota_hidrografia.gs'"     >>figura3.gs  
echo "'printim 'bacia'_semanaoperativa_1_"$data".png white'"                       >>figura3.gs
#
# FIGURAS RETARTO SEMANA OPERATIVA 2
#
echo "'c'"                                                             >>figura3.gs
echo "'set parea 0.5 8.5 1.5 10.2'"                                  >>figura3.gs
echo "'cores.gs'"                                                >>figura3.gs
echo "'d sum(prec,t='t2',t=10)'"                                       >>figura3.gs
echo "*'cbarn.gs'"                                                      >>figura3.gs
echo "'draw string 2.5 10.8 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 2 '">>figura3.gs
echo "'draw string 2.5 10.6 RODADA:"$DATA0" - "$hora"Z'"                >>figura3.gs
echo "'draw string 2.5 10.4 PERIODO:'dia2'/'mes2'/'ano2' a 'dia3'/'mes3'/'ano3  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'"       >>figura3.gs
echo "'basemap.gs O 50 0 M'"                 >>figura3.gs
echo "'set mpdset hires'"                    >>figura3.gs
echo "'set map 15 1 6'"                      >>figura3.gs
echo "'draw map'"                            >>figura3.gs
echo "if (bacia="brasil")"                    >>figura3.gs
echo "'plota.gs'"                             >>figura3.gs
echo "else"                    >>figura3.gs
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                  >>figura3.gs
echo "endif"                    >>figura3.gs
echo "'cbarn.gs'" >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs    
echo "'plota_hidrografia.gs'"     >>figura3.gs  
echo "'printim 'bacia'_semanaoperativa_2_"$data".png white'"                       >>figura3.gs
#
# FIGURA RETRATO SEMANA 7 DIAS CORRIDOS 
#
echo "'c'"   >>figura3.gs
echo "'set parea 0.5 8.5 1.5 10.2'"                                  >>figura3.gs
#echo "'set mpdset hires'"                                    >>figura3.gs
echo "'cores.gs'"                                         >>figura3.gs
echo "'set gxout shaded'"                                    >>figura3.gs
echo "'d sum(prec,t=1,t=7)'"                                 >>figura3.gs
echo "'draw string 2.5 10.8 PRECIPITACAO ACUMULADA 7 DIAS '"  >>figura3.gs
echo "'draw string 2.5 10.6 RODADA :"$DATA0" - "$hora"Z'"     >>figura3.gs
echo "'draw string 2.5 10.4 Periodo:"$DATA2" a "$DATA1"'"     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs
echo "'cbarn.gs'"                                            >>figura3.gs
echo "if (bacia="brasil")"                    >>figura3.gs
echo "'plota.gs'"                             >>figura3.gs
echo "else"                    >>figura3.gs
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                  >>figura3.gs
echo "endif"                    >>figura3.gs
echo "'cbarn.gs'" >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "'printim 'bacia'_prec07dias_"$data"_"$hora"Z.png white'"       >>figura3.gs
echo "*say t0"                           >>figura3.gs
echo "endif"                            >>figura3.gs 
#------------------------------------------------------------------------------------
# caso a bacia se ja em forma de paisagem 
# definido no arquivo limites_das_bacias em CONTORNOS/CADASTRADAS
#
#
#  FIGURA PAISAGEM  SEMANA OPERATIVA 1
#
echo "if (tipo = "PAISAGEM" & page ="11" & plota="SIM" ) "   >>figura3.gs
echo "'c'"                        >>figura3.gs
echo "'set parea 0.5 10.5 1.88392 7.31608'"                     >>figura3.gs
echo "'set t 1'"                        >>figura3.gs
echo "'cores.gs'"                    >>figura3.gs
echo "'d sum(prec,t=1,t='t0')'"         >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 1'"  >>figura3.gs
echo "'draw string 2.5 8.1 RODADA:"$DATA0" - "$hora"Z'"                >>figura3.gs
echo "'draw string 2.5 7.9 PERIODO:'dia1'/'mes1'/'ano1' a 'dia2'/'mes2'/'ano2  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs   
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                  >>figura3.gs
echo "say shape" >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "'printim 'bacia'_semanaoperativa_1_"$data".png white'"                       >>figura3.gs
#
# FIGURA PAISAGEM SEMANA OPERATIVA 2
#
echo "'c'"                                                             >>figura3.gs
echo "'set parea 0.5 10.5 1.88392 7.31608'"                     >>figura3.gs
echo "'cores.gs'"                                                >>figura3.gs
echo "'d sum(prec,t='t2',t=10)'"                                       >>figura3.gs
echo "'cbarn.gs'"                                                      >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 2 '">>figura3.gs
echo "'draw string 2.5 8.1 RODADA:"$DATA0" - "$hora"Z'"                >>figura3.gs
echo "'draw string 2.5 7.9 PERIODO:'dia2'/'mes2'/'ano2' a 'dia3'/'mes3'/'ano3  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs     
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                        >>figura3.gs
echo "'cbarn.gs'" >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "'printim 'bacia'_semanaoperativa_2_"$data".png white'"                       >>figura3.gs
#
# FIGURA PAISAGEM SEMANA OPERATIVA 2
#
echo "'c'"   >>figura3.gs
echo "*'set parea 0.5 10.5 1.88392 7.31608'"                     >>figura3.gs
echo "'set parea off'"                                    >>figura3.gs
echo "'set mpdset hires'"                                    >>figura3.gs
echo "'cores.gs'"                                         >>figura3.gs
echo "'set gxout shaded'"                                    >>figura3.gs
echo "'d sum(prec,t=1,t=7)'"                                 >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO ACUMULADA 7 DIAS '"  >>figura3.gs
echo "'draw string 2.5 8.1 RODADA :"$DATA0" - "$hora"Z'"     >>figura3.gs
echo "'draw string 2.5 7.9 Periodo:"$DATA2" a "$DATA1"'"     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs     
echo "'cbarn.gs'"                                            >>figura3.gs
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"     >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "'printim 'bacia'_prec07dias_"$data"_"$hora"Z.png white'"       >>figura3.gs

#
# PARTE FINAL DO SCRIPT . NÃO MEXER 
#
echo "*say t0"                           >>figura3.gs
echo "endif"                            >>figura3.gs 
echo "endif"                            							>>figura3.gs 
echo "endwhile"                          							>>figura3.gs

#
# modulo de debug . para ativar MODDEBUG=1 
#

if [  MODDEBUG=1 ];then 
echo "'set lon -80.0000   -30.0000   '"                     >>figura3.gs
echo "'set lat   -35 06.0000         ' "                                    >>figura3.gs
echo " t=1"                                    >>figura3.gs
echo " while (t<=10)"                                    >>figura3.gs
echo "'c'"   >>figura3.gs
echo "'set t 't"                                    >>figura3.gs
echo "'q time'"                                    >>figura3.gs
echo "datah=subwrd(result,3) "                                    >>figura3.gs
echo "'cores.gs'"                                         >>figura3.gs
echo "'set gxout shaded'"                                    >>figura3.gs
echo "'d prec'"                                 >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO DIARIA '"  >>figura3.gs
echo "'draw string 2.5 8.1 RODADA :"$DATA0" - "$hora"Z'"     >>figura3.gs
echo "'draw string 2.5 7.9 Periodo:'datah"    >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs     
echo "'cbarn.gs'"                                            >>figura3.gs
echo "'draw shp ../../CONTORNOS/SHAPES/BRASIL.shp'"     >>figura3.gs
#echo  "plotausina(bacia,page)"                          >>figura3.gs  
echo "'plota_hidrografia.gs'"                          >>figura3.gs
echo "'printim prec_diaria_'datah'.png white'"      >>figura3.gs
echo "t=t+1"                                    >>figura3.gs
echo "endwhile"                                    >>figura3.gs
fi 



 
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


#
# ESSE ARQUIVO CONTEM AS LOCALIZACOES DAS USNINAS
# A SEREM PLOTADOS NAS FIGURAS
#
cat  ../../UTIL/modulo_grads.mod  >> figura3.gs





echo "["`date`"] CALCULANDO MEDIA POR BACIA" 
#
# Geracao de produtos
#
cp ../../calcula_versao3.gs .



echo "["`date`"] PLOTANDO FIGURAS SEMANA OPERATIVA FORMATO RETRATO POR BACIAS" 
grads -pbc "figura3.gs"  >>./LOG.prn 2>&1
echo "["`date`"] PLOTANDO FIGURAS SEMANA OPERATIVA FORMATO PAISAGEM POR BACIAS" 
grads -lbc "figura3.gs"  >>./LOG.prn 2>&1
echo "["`date`"] CALCULANDO MÉDIA POR BACIA " 
grads -lbc "calcula_versao3.gs" >>./LOG.prn 2>&1
echo "["`date`"] AJUSTANDO CRIAÇÕES " 
mkdir imagens_semanaoperativa_1  >>./LOG.prn 2>&1
mkdir imagens_semanaoperativa_2 >>./LOG.prn 2>&1
mkdir imagens_7dias   >>./LOG.prn 2>&1
mkdir diaria >>./LOG.prn 2>&1
mv *semanaoperativa_1*  imagens_semanaoperativa_1  >>./LOG.prn 2>&1
mv *semanaoperativa_2*  imagens_semanaoperativa_2  >>./LOG.prn 2>&1
mv *prec07dias* imagens_7dias                      >>./LOG.prn 2>&1
mv prec_diaria* diaria

cd ..

echo "["`date`"] FIM" 

