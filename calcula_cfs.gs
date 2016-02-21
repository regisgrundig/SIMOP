*  VERSAO 2.0 
*
*
*  bY regis  reginaldo.venturadesa@gmail.com 
*  uso:
*      calcula.gs (exige grads)   [00/12]   
*------------------------------------------------------------------------- 
*
*
'open cfs.ctl'
'open cfs03.ctl'
'open cfs04.ctl'

'set t 1'
'q time'
data=subwrd(result,3)
say result 



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
'quit'
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
t=1000
else 
t=5
endif
xxx=write("todomundo.prn",label' 'bacia)
yyy=write("comremocao.prn",label' 'bacia)
say "calculando para  bacia:"bacia
status2=status
chuva=0
conta=0
conta1=0
conta2=0

p=0 
precip=0
precip1=0
precip2=0

_pchuva.1=0
while (t<=400)
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
'd sum(pratesfc*6*3600,t='t',t='t+3')'
var=sublin(result,2)
valor=subwrd(var,4)
*say valor' 't
*say result
if (valor >=0 )
*say precip' 't
precip=precip+valor
conta=conta+1
endif

'd sum(pratesfc.2*6*3600,t='t',t='t+3')'
var=sublin(result,2)
valor1=subwrd(var,4)
*say valor' 't
*say result
if (valor1 >=0 )
*say precip' 't
precip1=precip1+valor1
conta1=conta1+1
endif

'd sum(pratesfc.3*6*3600,t='t',t='t+3')'
var=sublin(result,2)
valor2=subwrd(var,4)
*say valor' 't
*say result
if (valor2 >=0 )
*say precip' 't
precip2=precip2+valor2
conta2=conta2+1
endif


else
say "xxxxxxxxxxxxxxxxxxxxx"
endif
endwhile



media=precip/(conta+(0.00001))
media1=precip1/(conta1+(0.00001))
media2=precip2/(conta2+(0.00001))

rc1 = math_format("%7.2f",precip)
rc2 = math_format("%7.0f",conta)
rc3 = math_format("%5.2f",media)
rc31 = math_format("%5.2f",media1)
rc32 = math_format("%5.2f",media2)

fim=write(bacia,data' 'dataprev' 'rc3)
xxx=write("todomundo.prn",data' 'dataprev' 'rc3' 'rc31' 'rc32,append)
t=t+4
endwhile ****************linha 68

************  da linha 26
endwhile    
'quit'
'quit'










