*  VERSAO 2.0 
*
*
*  bY regis  reginaldo.venturadesa@gmail.com 
*  uso:
*      calcula.gs (exige grads)   [00/12]   
*------------------------------------------------------------------------- 
*
*

'open modelo_all.ctl'

'q time' 
*Time = 07:29Z16APR2015 to 07:29Z16APR2015  Thu to Thu
data=subwrd(result,3)
dia=substr(data,7,2)
mes=substr(data,9,3)
ano=substr(data,12,4)
hora=substr(data,1,5)
*
*  leio arquivo bacia e processo 
* para cada item dentro desse arquivo
*

while ( 0=0 )       
*
* abre o arquivo bacias
*
id=read("../../bacias")
*
* se status=0 tudo ok. se não ...
*
status=sublin(id,1)   

if (status>0) 
return
endif



var=sublin(id,2)
bacia=subwrd(var,1)
label=subwrd(var,2)
xxx=write("todomundo.prn",label' 'bacia,append)
*say "calculando para  bacia:"bacia
status2=status
precip=0
conta=0
t=5
while (t<=818)
'set t ' t
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
'd prec(t='t-1')*3600*6+prec(t='t')*3600*6+prec(t='t+1')*3600*6+prec(t='t+2')*3600*6'
*var=sublin(result,2)
valor=subwrd(result,4)
*say valor' 't
*say result
if (valor >=0 )
precip=precip+valor
conta=conta+1
endif 
*ay result
endif
endwhile



media=precip/(conta+(0.00001))
rc1 = math_format("%7.2f",precip)
rc2 = math_format("%7.0f",conta)
rc3 = math_format("%5.2f",media)
fim=write(bacia,data' 'dataprev' 'rc3,append)
xxx=write("todomundo.prn",data' 'dataprev' 'rc3,append)
t=t+4
endwhile

************  da linha 36
endwhile     
'return'







function baixagfs(config)
'sdfopen http://nomads.ncep.noaa.gov:9090/dods/gfs_0p25/gfs'config'/gfs_0p25_00z'
'set lon 280 330'
'set lat -40 10'
t=1
'set fwrite 'config'.bin'
'set gxout fwrite'
while (t<=81)
'set t 't
'd pratesfc*3*3600'
t=t+1
endwhile
'disable fwrite'
'set gxout shaded'
return