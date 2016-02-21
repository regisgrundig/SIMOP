#/bin/bash 
#*                                                     	
#*██╗      █████╗ ███╗   ███╗ ██████╗  ██████╗    ██╗   ██╗███████╗███████╗
#*██║     ██╔══██╗████╗ ████║██╔═══██╗██╔════╝    ██║   ██║██╔════╝██╔════╝
#*██║     ███████║██╔████╔██║██║   ██║██║         ██║   ██║█████╗  █████╗  
#*██║     ██╔══██║██║╚██╔╝██║██║   ██║██║         ██║   ██║██╔══╝  ██╔══╝  
#*███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝╚██████╗    ╚██████╔╝██║     ██║     
#*╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝     ╚═════╝ ╚═╝     ╚═╝    
#*  
#*
#  █████╗ ██╗   ██╗████████╗ ██████╗     ███████╗ ██████╗██████╗ ██╗██████╗ ████████╗
# ██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗    ██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝
# ███████║██║   ██║   ██║   ██║   ██║    ███████╗██║     ██████╔╝██║██████╔╝   ██║   
# ██╔══██║██║   ██║   ██║   ██║   ██║    ╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   
# ██║  ██║╚██████╔╝   ██║   ╚██████╔╝    ███████║╚██████╗██║  ██║██║██║        ██║   
# ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝     ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   
                                                                       
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
# essa versao é feita pela conta regisgrundig e nao pela lAMOC
#
#--------------------------------------------------------------------------
#
# Existem duas rodadas do modelo ao dia. Uma as 00Z e outra as 12Z
# se nada for informada na linha de comando assume-se 00z
#
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
# Pega data do dia (relogio do micro)
# 
if [ $1 ="" ];then
data=`date +"%Y%m%d"`
datagrads=`date +"%d%b%Y" -d "1 days"` 
else
let b="$1-1"
data=`date +"%Y%m%d" -d "$1 days ago"`
datagrads=`date +"%d%b%Y" -d "$b  days ago"` 
fi
#
# há duas rodas por dia. Utilizamos somente a rodada 00Z!
# com pirmeira chuva as 12Z. 
#
hora="00"
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
mkdir $data   >>./LOG.prn 2>&1 
cd $data      
echo "["`date`"] INICIO DO LOG ETA40KM "  >./LOG.prn 2>&1 
echo $data           >>./LOG.prn 2>&1
echo $datagrads      >>./LOG.prn 2>&1


#
# Adquire os dados no site do CPTEC. 
# Atençao:  
# Verifique pois o CPTEC altera os caminhos sem avisar!!!
#
echo "["`date`"] BAIXANDO DADOS ETA 40KM " 
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

let b="1"
echo "DSET ^"$data$hora".bin" >modelo_all.ctl
echo "UNDEF -9999." >>modelo_all.ctl 
echo "TITLE eta 10 dias" >>modelo_all.ctl
echo "XDEF  144 LINEAR  -83.00   0.40" >>modelo_all.ctl
echo "YDEF  157 LINEAR  -50.20   0.40" >>modelo_all.ctl
echo "ZDEF   1 LEVELS 1000" >>modelo_all.ctl
echo "TDEF   10 LINEAR 12Z"$datagrads" 24hr" >>modelo_all.ctl
echo "VARS  1" >>modelo_all.ctl
echo "PREC  0  99  Total  24h Precip.        (m)" >>modelo_all.ctl
echo "ENDVARS" >>modelo_all.ctl


#-----------------------------------------------------------------------------------------
#  cria o script para data operativa por bacia cadastrada
#  as bacias estao cadastradas em CADASTRO/CADASTRADAS
# ver documentacao para maiores detalhes
##
echo "*"                                                                 >figura3.gs
echo "* esse script é auto gerado. documentação em adquire_eta.sh"      >>figura3.gs
echo "*By reginaldo.venturadesa@gmail.com "                             >>figura3.gs
echo "'open modelo_all.ctl'"            >>figura3.gs
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
echo "t0=10"                            >>figura3.gs  
echo "tfinal=10"                        >>figura3.gs  
echo "'set t 1 last'"                   >>figura3.gs
echo "'q time'"                         >>figura3.gs
echo "var3=subwrd(result,5)"            >>figura3.gs
echo "tt=1"                             >>figura3.gs
echo "while (tt<=10)"                   >>figura3.gs
echo "'set t ' tt"                      >>figura3.gs
echo "'q time'"                         >>figura3.gs
echo "var=subwrd(result,6)"             >>figura3.gs
echo "if (var = "Fri" )"                >>figura3.gs
echo "t0=1"                            >>figura3.gs
echo "tsex=tt"                            >>figura3.gs
echo "tt=12"                            >>figura3.gs
echo "endif"                            >>figura3.gs
echo "tt=tt+1"                          >>figura3.gs
echo "endwhile"                         >>figura3.gs
echo "*say t0"                           >>figura3.gs
echo "tsab=tsex+1"                       >>figura3.gs
echo "tfinal=tsab+6"                    >>figura3.gs
#
# pega informacoes
# de data
# data de inicio 
# data do sabado 
# data final 
#
#
#  data RODADA
#
echo "'set t 0'"                     >>figura3.gs
echo "'q time'"                         >>figura3.gs
echo "var0=subwrd(result,3)"            >>figura3.gs
#
#  data da semana operativa 1
#
echo "'set t 1 'tsex"                     >>figura3.gs
echo "'q time'"                         >>figura3.gs
echo "var1=subwrd(result,3)"            >>figura3.gs
echo "var2=subwrd(result,5)"            >>figura3.gs
#
#  data da semana operativa 2
#
echo "'set t 'tsab' 'tfinal"                     >>figura3.gs   
echo "'q time'"                           >>figura3.gs 
echo "var3=subwrd(result,3)"            >>figura3.gs
echo "var4=subwrd(result,5)"            >>figura3.gs

#
# semana 7 dias
#
echo "'set t 1 7'"                     >>figura3.gs   
echo "'q time'"                           >>figura3.gs 
echo "var5=subwrd(result,5)"            >>figura3.gs

# data  rodada
echo "ano0=substr(var0,9,4)"                       >>figura3.gs
echo "mes0=substr(var0,6,3)"                       >>figura3.gs
echo "dia0=substr(var0,4,2)"                       >>figura3.gs

# data inicial previsao 
echo "ano1=substr(var1,9,4)"                       >>figura3.gs
echo "mes1=substr(var1,6,3)"                       >>figura3.gs
echo "dia1=substr(var1,4,2)"                       >>figura3.gs
# data proxima sexta-feira
echo "ano2=substr(var2,9,4)"                       >>figura3.gs
echo "mes2=substr(var2,6,3)"                       >>figura3.gs
echo "dia2=substr(var2,4,2)"                       >>figura3.gs
# data sabado
echo "ano3=substr(var3,9,4)"                       >>figura3.gs
echo "mes3=substr(var3,6,3)"                       >>figura3.gs
echo "dia3=substr(var3,4,2)"                       >>figura3.gs
# data final
echo "ano4=substr(var4,9,4)"                       >>figura3.gs
echo "mes4=substr(var4,6,3)"                       >>figura3.gs
echo "dia4=substr(var4,4,2)"                       >>figura3.gs
# data 7 dias
echo "ano5=substr(var5,9,4)"                       >>figura3.gs
echo "mes5=substr(var5,6,3)"                       >>figura3.gs
echo "dia5=substr(var5,4,2)"                       >>figura3.gs


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
echo "say linha"       >>figura3.gs
echo "bacia=subwrd(linha,4)"     >>figura3.gs
echo "shape=subwrd(linha,5)"     >>figura3.gs
echo "x0=subwrd(linha,6)"       >>figura3.gs
echo "x1=subwrd(linha,7)"       >>figura3.gs
echo "y0=subwrd(linha,8)"       >>figura3.gs
echo "y1=subwrd(linha,9)"       >>figura3.gs
echo "tipo=subwrd(linha,10)"     >>figura3.gs
echo "say bacia' 'shape' 'x0' 'x1' 'y0' 'y1' 'tipo"    >>figura3.gs
echo "plota=subwrd(linha,11)"    >>figura3.gs
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
echo "'d sum(prec,t=1,t='tsex')'"         >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 10.8 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 1'"  >>figura3.gs
echo "'draw string 2.5 10.6 RODADA :'dia0'/'mes0'/'ano0 "               >>figura3.gs
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
echo "'plota_hidrografia.gs'"     >>figura3.gs  
echo "plotausina(bacia,page)" >>figura3.gs    
echo "'printim 'bacia'_semanaoperativa_1_"$data".png white'"                       >>figura3.gs
#
# FIGURAS RETARTO SEMANA OPERATIVA 2
#
echo "'c'"                                                             >>figura3.gs
echo "'set parea 0.5 8.5 1.5 10.2'"                                  >>figura3.gs
echo "'cores.gs'"                                                >>figura3.gs
echo "'d sum(prec,t='tsab',t='tfinal')'"                                       >>figura3.gs
echo "*'cbarn.gs'"                                                      >>figura3.gs
echo "'draw string 2.5 10.8 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 2 '">>figura3.gs
echo "'draw string 2.5 10.6 RODADA :'dia0'/'mes0'/'ano0 "               >>figura3.gs
echo "'draw string 2.5 10.4 PERIODO:'dia3'/'mes3'/'ano3' a 'dia4'/'mes4'/'ano4  "                     >>figura3.gs
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
echo "'plota_hidrografia.gs'"     >>figura3.gs  
echo "plotausina(bacia,page)" >>figura3.gs    
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
echo "'draw string 2.5 10.6 RODADA :'dia0'/'mes0'/'ano0 "               >>figura3.gs
echo "'draw string 2.5 10.4 PERIODO:'dia1'/'mes1'/'ano1' a 'dia5'/'mes5'/'ano5  "                     >>figura3.gs
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
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  
echo "'printim 'bacia'_prec07dias_"$data"_"$hora"Z.png white'"       >>figura3.gs
echo "*say t0"                           >>figura3.gs
#
#
#
echo "'c'" >>figura3.gs 
echo "t=1 "    >>figura3.gs 
echo "while (t<=10) "    >>figura3.gs 
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
echo "'d prec'"         >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 10.8 PRECIPITACAO DIARIA ETA 40KM '"  >>figura3.gs
echo "'draw string 2.5 10.6 RODADA :'dia0'/'mes0'/'ano0 "               >>figura3.gs
echo "'draw string 2.5 10.4 PERIODO:'dia1'/'mes1'/'ano1   "                     >>figura3.gs
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
echo "t=t+1"                    >>figura3.gs
echo "'c'"                    >>figura3.gs
echo "endwhile"                    >>figura3.gs

#
#
#



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
echo "'d sum(prec,t=1,t='tsex')'"         >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 1'"  >>figura3.gs
#echo "'draw string 2.5 8.1 RODADA:"$DATA0" - "$hora"Z'"                >>figura3.gs
#echo "'draw string 2.5 7.9 PERIODO:'dia1'/'mes1'/'ano1' a 'dia2'/'mes2'/'ano2  "                     >>figura3.gs
echo "'draw string 2.5 8.1 RODADA :'dia0'/'mes0'/'ano0 "               >>figura3.gs
echo "'draw string 2.5 7.9 PERIODO:'dia1'/'mes1'/'ano1' a 'dia2'/'mes2'/'ano2  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs   
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                  >>figura3.gs
echo "say shape" >>figura3.gs
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  
echo "'printim 'bacia'_semanaoperativa_1_"$data".png white'"                       >>figura3.gs
#
# FIGURA PAISAGEM SEMANA OPERATIVA 2
#
echo "'c'"                                                             >>figura3.gs
echo "'set parea 0.5 10.5 1.88392 7.31608'"                     >>figura3.gs
echo "'cores.gs'"                                                >>figura3.gs
echo "'d sum(prec,t='tsab',t='tfinal')'"                                       >>figura3.gs
echo "'cbarn.gs'"                                                      >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 2 '">>figura3.gs
echo "'draw string 2.5 8.1 RODADA :'dia0'/'mes0'/'ano0"               >>figura3.gs
echo "'draw string 2.5 7.9 PERIODO:'dia3'/'mes3'/'ano3' a 'dia4'/'mes4'/'ano4  "      >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs     
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"                                                        >>figura3.gs
echo "'cbarn.gs'" >>figura3.gs
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs  

echo "'printim 'bacia'_semanaoperativa_2_"$data".png white'"                       >>figura3.gs
#
# FIGURA PAISAGEM SEMANA 7 dias
#
echo "'c'"   >>figura3.gs
echo "*'set parea 0.5 10.5 1.88392 7.31608'"                     >>figura3.gs
#echo "'set parea off'"                                    >>figura3.gs
echo "'set mpdset hires'"                                    >>figura3.gs
echo "'cores.gs'"                                         >>figura3.gs
echo "'set gxout shaded'"                                    >>figura3.gs
echo "'d sum(prec,t=1,t=7)'"                                 >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO ACUMULADA 7 DIAS '"  >>figura3.gs
echo "'draw string 2.5 8.1 RODADA :'dia0'/'mes0'/'ano0"               >>figura3.gs
echo "'draw string 2.5 7.9 PERIODO:'dia1'/'mes1'/'ano1' a 'dia5'/'mes5'/'ano5  "                     >>figura3.gs
echo "'set rgb 50   255   255    255'" >>figura3.gs
echo "'basemap.gs O 50 0 M'" >>figura3.gs
echo "'set mpdset hires'" >>figura3.gs
echo "'set map 15 1 6'" >>figura3.gs
echo "'draw map'" >>figura3.gs     
echo "'cbarn.gs'"                                            >>figura3.gs
echo "'draw shp ../../CONTORNOS/SHAPES/'shape"     >>figura3.gs
echo "'plota_hidrografia.gs'"     >>figura3.gs
echo "plotausina(bacia,page)" >>figura3.gs 
echo "'printim 'bacia'_prec07dias_"$data"_"$hora"Z.png white'"       >>figura3.gs

#
#
#
#
echo "'c'" >>figura3.gs 
echo "t=1 "    >>figura3.gs 
echo "while (t<=10) "    >>figura3.gs 
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
echo "'d prec'"         >>figura3.gs
echo "'cbarn.gs'"                       >>figura3.gs
echo "'draw string 2.5 8.3 PRECIPITACAO DIARIA ETA 40KM'"  >>figura3.gs
echo "'draw string 2.5 8.1 RODADA :'dia0'/'mes0'/'ano0"               >>figura3.gs
#echo "'draw string 2.5 8.1 RODADA :"$data_rodada"'"               >>figura3.gs
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
echo "t=t+1"                    >>figura3.gs
echo "'c'"                    >>figura3.gs
echo "endwhile"                    >>figura3.gs


#
#
#
#

echo "endif"                            >>figura3.gs 
#
# PARTE FINAL DO SCRIPT . NÃO MEXER 
#

echo "endif"                            							>>figura3.gs 
echo "endwhile"                          							>>figura3.gs
echo "'quit'"                          								>>figura3.gs

#
#  cria parte comum como tabelas de cores e escalas, hidrografoa etc...
#
../../common_stuff.sh  


#
# ESSE ARQUIVO CONTEM AS LOCALIZACOES DAS USNINAS
# A SEREM PLOTADOS NAS FIGURAS xxxxxxx
#
cat  ../../UTIL/modulo_grads.mod  >> figura3.gs
echo "["`date`"] CALCULANDO MEDIA POR BACIA" 
#
# Geracao de produtos
#
cp ../../calcula_versao3.gs .
echo "["`date`"] CALCULANDO MÉDIA POR BACIA " 
grads -lbc "calcula_versao3.gs" >>./LOG.prn 2>&1
echo "["`date`"] PLOTANDO FIGURAS SEMANA OPERATIVA FORMATO RETRATO POR BACIAS" 
grads -pbc "figura3.gs"  >>./LOG.prn 2>&1
echo "["`date`"] PLOTANDO FIGURAS SEMANA OPERATIVA FORMATO PAISAGEM POR BACIAS" 
grads -lbc "figura3.gs"  >>./LOG.prn 2>&1
echo "["`date`"] AJUSTANDO CRIAÇÕES " 
mkdir imagens_semanaoperativa_1  >>./LOG.prn 2>&1
mkdir imagens_semanaoperativa_2 >>./LOG.prn 2>&1
mkdir imagens_7dias   >>./LOG.prn 2>&1
mkdir diaria >>./LOG.prn 2>&1
mv *semanaoperativa_1*  imagens_semanaoperativa_1  >>./LOG.prn 2>&1
mv *semanaoperativa_2*  imagens_semanaoperativa_2  >>./LOG.prn 2>&1
mv *prec07dias* imagens_7dias                      >>./LOG.prn 2>&1
mv *.png diaria  >>./LOG.prn 2>&1
cd ..
cd ..
pwd

echo "["`date`"] FIM DO PROCESSO ETA 40KM" 
