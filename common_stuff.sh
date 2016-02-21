#!/bin/bash 
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
echo "'set line 15 1 1'"                                             >plota_hidrografia.gs
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