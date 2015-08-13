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
'set t 1'
'../../cores.gs'
'd sum(prec,t=2,t='t0')'
'cbarn.gs'
'draw string 0.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 1'
'draw string 0.5 8.1 RODADA:13/08/2015 - 00Z'
'draw string 0.5 7.9 PERIODO:'var1' a 'var2
'../../plota.gs'
'printim semanaoperativa_1_20150813.png white'
'c'
'../../cores.gs'
'd sum(prec,t='t0',t=10)'
'cbarn.gs'
'draw string 0.5 8.3 PRECIPITACAO ACUMULADA SEMANA OPERATIVA 2 '
'draw string 0.5 8.1 RODADA:13/08/2015 - 00Z'
'draw string 0.5 7.9 PERIODO:'var2' a 'var3
'../../plota.gs'
'printim semanaoperativa_2_20150813.png white'
say t0
'quit'
