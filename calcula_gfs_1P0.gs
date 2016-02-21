
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
fi=baixagfs(data)
'close 1'
pi=extrai(data)

'quit'


function  extrai(data)

'open gfs_1P0.ctl'

say '------------->'data
*
*  leio arquivo bacia e processo 
* para cada item dentro desse arquivo
*

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
chuva=0
conta=0
p=0 
precip=0
_pchuva.1=0
while (t<=31)
'set t ' t+1
'q time'
dataprev=subwrd(result,3)
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
'd sum(chuva,t='t',t='t+1')'
var=sublin(result,2)
valor=subwrd(var,4)
*say valor' 't
*say result
if (valor >=0 )
precip=precip+valor
conta=conta+1
yyy=write("logao.prn",bacia' 'xlat' 'xlon' 'valor' 'conta' 'precip' 't,append)
endif 
*ay result
endif
endwhile



media=precip/(conta+(0.00001))
rc1 = math_format("%7.2f",precip)
rc2 = math_format("%7.0f",conta)
rc3 = math_format("%5.2f",media)
fim=write(bacia,data' 'dataprev' 'rc3)
xxx=write("todomundo.prn",data' 'dataprev' 'rc3,append)
t=t+2
endwhile

************  da linha 36
endwhile    
'quit'







function baixagfs(config)

'sdfopen http://nomads.ncep.noaa.gov:9090/dods/gfs_1p00/gfs'config'/gfs_1p00_00z'

'set lon 280 330'
'set lat -40 10'
t=2
'set fwrite 'config'_1P0.bin'
'set gxout fwrite'
while (t<=33)
'set t 't
'd pratesfc*12*3600'
*'d apcpsfc'
t=t+1
endwhile
'disable fwrite'
'set gxout shaded'
return
