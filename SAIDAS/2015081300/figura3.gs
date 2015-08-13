'open modelo_all.ctl'
'set mpdset hires'
'set gxout shaded'
t0=10
'set t 2 last'
'q time'
var3=subwrd(result,5)
tt=1
while (tt<=10)
'set t ' tt
'q time'
var=subwrd(result,6)
if (var = "Sat" )
t0=tt
endif
tt=tt+1
endwhile
say t0
'set t 2 't0
'q time'
var1=subwrd(result,3)
var2=subwrd(result,5)
say result
status2=0
while(!status2)
fd=read("../../CONTORNOS/CADASTRADAS/limites_das_bacias.dat")
status2=sublin(fd,1) 
if (status2 = 0) 
linha=sublin(fd,2)
bacia=subwrd(linha,1)
shape=subwrd(linha,2)
x0=subwrd(linha,3)
x1=subwrd(linha,4)
y0=subwrd(linha,5)
y1=subwrd(linha,6)
'set lon 'x1' 'x0 
'set lat 'y1' 'y0 
'c'
'set t 1'
'../../cores.gs'
'd sum(prec,t=2,t='t0')'
'cbarn.gs'
'draw string 0.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 1'
'draw string 0.5 8.1 RODADA:13/08/2015 - 00Z'
'draw string 0.5 7.9 PERIODO:'var1' a 'var2
'draw shp ../../CONTORNOS/SHAPES/'shape
say shape
'printim 'bacia'_semanaoperativa_1_20150813.png white'
'c'
'../../cores.gs'
'd sum(prec,t='t0',t=10)'
'cbarn.gs'
'draw string 0.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 2 '
'draw string 0.5 8.1 RODADA:13/08/2015 - 00Z'
'draw string 0.5 7.9 PERIODO:'var2' a 'var3
'draw shp ../../CONTORNOS/SHAPES/'shape
'printim 'bacia'_semanaoperativa_2_20150813.png white'
'c'
'set mpdset hires'
'../../cores.gs'
'set gxout shaded'
'd sum(prec,t=2,t=8)'
'draw string 0.5 8.3 PRECIPITACAO ACUMULADA 7 DIAS '
'draw string 0.5 8.1 RODADA :13/08/2015 - 00Z'
'draw string 0.5 7.9 Periodo:14/08/2015 a 20/08/2015'
'cbarn.gs'
'../../plota.gs'
'printim 'bacia'_prec07dias_20150813_00Z.png white'
say t0
endif
endwhile
'quit'
