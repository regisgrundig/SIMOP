'open modelo_all.ctl'
'set mpdset hires'
'../../cores.gs'
'set gxout shaded'
'd sum(prec,t=2,t=8)'
'draw string 0.5 8.3 PRECIPITACAO ACUMULADA 7 DIAS '
'draw string 0.5 8.1 RODADA :13/08/2015 - 00Z'
'draw string 0.5 7.9 Periodo:14/08/2015 a 20/08/2015'
'cbarn.gs'
'../../plota.gs'
'printim prec07dias_20150813_00Z.png white'
'quit'
