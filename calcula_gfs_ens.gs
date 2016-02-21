
*  VERSAO 2.0 
*
*
*  bY regis  reginaldo.venturadesa@gmail.com 
*  uso:
*      calcula.gs (exige grads)   [00/12]   
*------------------------------------------------------------------------- 
*
*
id=read('gfs.config')
status=sublin(id,1)
config=sublin(id,2)
say config
data=subwrd(config,1)
say data
*fi=baixagfs(data)
*'close 1'
pi=extrai(data)

'quit'


function  extrai(data)

'open gfsens.ctl'

say '- de processamento ------------>'data
*
*  leio arquivo bacia e processo 
* para cada item dentro desse arquivo
*
say '   inicio  -------------------------------'







while ( 0=0 )       
*
* abre o arquivo bacias
*
id=read("../../UTIL/limites_das_bacias.dat")
*
* se status=0 tudo ok. se não ...
*
status=sublin(id,1)   

if (status>0) 
return
endif
var=sublin(id,2)
opcao=subwrd(var,1)
bacia=subwrd(var,2)
label=subwrd(var,3)
*
* SE EM LIMITES-DAS-BACIAS.DAT
* EH MARCADO COMO NAO , NÃO FAZ
* CALCULO PARA AQUELA  BACIA
*
if (opcao = "NAO") 
t=100
else 
t=1
endif
xxx=write("todomundo.prn",label' 'bacia)
yyy=write("comremocao.prn",label' 'bacia)
say "calculando para  bacia:"bacia
status2=status

pt.00=0
ct.00=0
pt.01=0
ct.01=0
pt.02=0
ct.02=0
pt.03=0
ct.03=0
pt.04=0
ct.04=0
pt.05=0
ct.05=0
pt.06=0
ct.06=0
pt.07=0
ct.07=0
pt.08=0
ct.08=0
pt.09=0
ct.09=0
pt.10=0
ct.10=0
pt.11=0
ct.11=0
pt.12=0
ct.12=0
pt.13=0
ct.13=0
pt.14=0
ct.14=0
pt.15=0
ct.15=0
pt.16=0
ct.16=0
pt.17=0
ct.17=0
pt.18=0
ct.18=0
pt.19=0
ct.19=0
pt.20=0
ct.20=0


say ' -------------------  processa no tempo ----'
while (t<=61)
'set t ' t
'q time'
dataprev=subwrd(result,3)
say '----------------TEMPO:'t
*
* tendo o nome da bacia lido no arquivo "bacia"
* vou pegar os pontos d egrade que estao
* dentro da bacia
*
fd=close("../../CONTORNOS/CADASTRADAS/"bacia)
status2=0
*
* execuo esse esse bloco ate  a leitura
* de todos os pontos de grade que estao na bacia
*

while (!status2)
fd=read("../../CONTORNOS/CADASTRADAS/"bacia)
status2=sublin(fd,1)
if (status2 = 0) 
*
* ajusto set lat e set lon com as coordenadas lidas
* no arquivo que contem os pontos de grade
*
coord=sublin(fd,2)
xlon=subwrd(coord,1)
xlat=subwrd(coord,2)
'set lat 'xlat
'set lon 'xlon
*
* pego a precip do ponto de grade
*
say '-------- processa ensembles -----'


'd sum(gec00,t='t',t='t+3')'
var=sublin(result,2)
gec00=subwrd(var,4)

'd sum(gep01,t='t',t='t+3')'
var=sublin(result,2)
gep01=subwrd(var,4)

'd sum(gep02,t='t',t='t+3')'
var=sublin(result,2)
gep02=subwrd(var,4)

'd sum(gep03,t='t',t='t+3')'
var=sublin(result,2)
gep03=subwrd(var,4)

'd sum(gep04,t='t',t='t+3')'
var=sublin(result,2)
gep04=subwrd(var,4)

'd sum(gep05,t='t',t='t+3')'
var=sublin(result,2)
gep05=subwrd(var,4)

'd sum(gep06,t='t',t='t+3')'
var=sublin(result,2)
gep06=subwrd(var,4)

'd sum(gep07,t='t',t='t+3')'
var=sublin(result,2)
gep07=subwrd(var,4)

'd sum(gep08,t='t',t='t+3')'
var=sublin(result,2)
gep08=subwrd(var,4)

'd sum(gep09,t='t',t='t+3')'
var=sublin(result,2)
gep09=subwrd(var,4)

'd sum(gep10,t='t',t='t+3')'
var=sublin(result,2)
gep10=subwrd(var,4)

'd sum(gep11,t='t',t='t+3')'
var=sublin(result,2)
gep11=subwrd(var,4)

'd sum(gep12,t='t',t='t+3')'
var=sublin(result,2)
gep12=subwrd(var,4)

'd sum(gep13,t='t',t='t+3')'
var=sublin(result,2)
gep13=subwrd(var,4)

'd sum(gep14,t='t',t='t+3')'
var=sublin(result,2)
gep14=subwrd(var,4)

'd sum(gep15,t='t',t='t+3')'
var=sublin(result,2)
gep15=subwrd(var,4)


'd sum(gep16,t='t',t='t+3')'
var=sublin(result,2)
gep16=subwrd(var,4)

'd sum(gep17,t='t',t='t+3')'
var=sublin(result,2)
gep17=subwrd(var,4)

'd sum(gep18,t='t',t='t+3')'
var=sublin(result,2)
gep18=subwrd(var,4)

'd sum(gep19,t='t',t='t+3')'
var=sublin(result,2)
gep19=subwrd(var,4)

'd sum(gep20,t='t',t='t+3')'
var=sublin(result,2)
gep20=subwrd(var,4)

*say valor' 't
*say result

if (gec00 >=0 )
pt.00=pt.00+gec00
ct.00=ct.00+1
else
pt.00=pt.00+0.0
endif

if (gep01 >=0 )
pt.01=pt.01+gep01
ct.01=ct.01+1
else
pt.01=pt.01+0.0
endif


if (gep02 >=0 )
pt.02=pt.02+gep02
ct.02=ct.02+1
else
pt.02=pt.02+0.0
endif


if (gep03 >=0 )
pt.03=pt.03+gep03
ct.03=ct.03+1
else
pt.03=pt.03+0.0
endif


if (gep04 >=0 )
pt.04=pt.04+gep04
ct.04=ct.04+1
else
pt.04=pt.04+0.0
endif


if (gep05 >=0 )
pt.05=pt.05+gep05
ct.05=ct.05+1
else
pt.05=pt.05+0.0
endif


if (gep06 >=0 )
pt.06=pt.06+gep06
ct.06=ct.06+1
else
pt.06=pt.06+0.0
endif


if (gep07 >=0 )
pt.07=pt.07+gep07
ct.07=ct.07+1
else
pt.07=pt.07+0.0
endif


if (gep08 >=0 )
pt.08=pt.08+gep08
ct.08=ct.08+1
else
pt.08=pt.08+0.0
endif


if (gep09 >=0 )
pt.09=pt.09+gep09
ct.09=ct.09+1
else
pt.09=pt.09+0.0
endif


if (gep10 >=0 )
pt.10=pt.10+gep10
ct.10=ct.10+1
else
pt.10=pt.10+0.0
endif


if (gep11 >=0 )
pt.11=pt.11+gep11
ct.11=ct.11+1
else
pt.11=pt.11+0.0
endif


if (gep12 >=0 )
pt.12=pt.12+gep12
ct.12=ct.12+1
else
pt.12=pt.12+0.0
endif


if (gep13 >=0 )
pt.13=pt.13+gep13
ct.13=ct.13+1
else
pt.13=pt.13+0.0
endif


if (gep14 >=0 )
pt.14=pt.14+gep14
ct.14=ct.14+1
else
pt.14=pt.14+0.0
endif


say gep15
if (gep15 >=0 )
pt.15=pt.15+gep15
ct.15=ct.15+1
else
pt.15=pt.15+0.0
endif


if (gep16 >=0 )
pt.16=pt.16+gep16
ct.16=ct.16+1
else
pt.16=pt.16+0.0
endif


if (gep17 >=0 )
pt.17=pt.17+gep17
ct.17=ct.17+1
else
pt.17=pt.17+0.0
endif


if (gep18 >=0 )
pt.18=pt.18+gep18
ct.18=ct.18+1
else
pt.18=pt.18+0.0
endif


if (gep19 >=0 )
pt.19=pt.19+gep19
ct.19=ct.19+1
else
pt.19=pt.19+0.0
endif


if (gep20 >=0 )
pt.20=pt.20+gep20
ct.20=ct.20+1
else
pt.20=pt.20+0.0
endif



yyy=write("logao.prn",bacia' 'xlat' 'xlon' 'valor' 'conta' 'precip' 't,append)

endif
endwhile
say pt.00
say ct.00

md.00=pt.00/(ct.00+0.000001)
md.01=pt.01/(ct.01+0.000001)
md.02=pt.02/(ct.02+0.000001)
md.03=pt.03/(ct.03+0.000001)
md.04=pt.04/(ct.04+0.000001)
md.05=pt.05/(ct.05+0.000001)
md.06=pt.06/(ct.06+0.000001)
md.07=pt.07/(ct.07+0.000001)
md.08=pt.08/(ct.08+0.000001)
md.09=pt.09/(ct.09+0.000001)
md.10=pt.10/(ct.10+0.000001)
md.11=pt.11/(ct.11+0.000001)
md.12=pt.12/(ct.12+0.000001)
md.13=pt.13/(ct.13+0.000001)
md.14=pt.14/(ct.14+0.000001)
md.15=pt.15/(ct.15+0.000001)
md.16=pt.16/(ct.16+0.000001)
md.17=pt.17/(ct.17+0.000001)
md.18=pt.18/(ct.18+0.000001)
md.19=pt.19/(ct.19+0.000001)
md.20=pt.20/(ct.20+0.000001)
say md.00
rc.00 = math_format("%5.2f",md.00)
rc.01 = math_format("%5.2f",md.01)
rc.02 = math_format("%5.2f",md.02)
rc.03 = math_format("%5.2f",md.03)
rc.04 = math_format("%5.2f",md.04)
rc.05 = math_format("%5.2f",md.05)
rc.06 = math_format("%5.2f",md.06)
rc.07 = math_format("%5.2f",md.07)
rc.08 = math_format("%5.2f",md.08)
rc.09 = math_format("%5.2f",md.09)
rc.10 = math_format("%5.2f",md.10)
rc.11 = math_format("%5.2f",md.11)
rc.12 = math_format("%5.2f",md.12)
rc.13 = math_format("%5.2f",md.13)
rc.14 = math_format("%5.2f",md.14)
rc.15 = math_format("%5.2f",md.15)
rc.16 = math_format("%5.2f",md.16)
rc.17 = math_format("%5.2f",md.17)
rc.18 = math_format("%5.2f",md.18)
rc.19 = math_format("%5.2f",md.19)
rc.20 = math_format("%5.2f",md.20)



fim=write(bacia'.gens',data' 'dataprev' 'rc.00' 'rc.01' 'rc.02' 'rc.03' 'rc.04' 'rc.05' 'rc.06' 'rc.07' 'rc.08' 'rc.09' 'rc.10' 'rc.11' 'rc.12' 'rc.13' 'rc.14' 'rc.15' 'rc.16' 'rc.17' 'rc.18' 'rc.19' 'rc.20)
t=t+4
endwhile   ************  da linha 36
endwhile    
'return'







function baixagfs(config)
*'sdfopen http://nomads.ncep.noaa.gov:9090/dods/gfs_1p00/gfs'config'/gfs_1p00_00z'
'sdfopen http://nomads.ncep.noaa.gov:9090/dods/gens/gens'config'/gep_all_00z'

'set lon 280 330'
'set lat -40 10'
t=1
'set fwrite 'config'_gens.bin'
'set gxout fwrite'
while (t<=65)
'set t 't
n=1
while (n<=21)
'set e 'n
'd pratesfc*6*3600'
*'d apcpsfc'
n=n+1
endwhile
t=t+1
endwhile
'disable fwrite'
'set gxout shaded'
return
