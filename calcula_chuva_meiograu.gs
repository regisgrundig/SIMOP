*------------------------------------------------------------------------
*
*
*  SCRIPT CALCULAR CHUVA NA BACIA USANDO CHUVA DE GRADE
*  CALCULAR CHUVA ACUMULADA POR BACIA DO SIN 
*
*  VERSAO 2.0 
*
*
*  bY regis  reginaldo.venturadesa@gmail.com 
*  uso:
*      calcula.gs (exige grads)   [00/12]   
*------------------------------------------------------------------------- 
*
*
'reinit'
'open chuvameiograu.ctl'
'q time'
data=subwrd(result,3)
'q files'
ans=sublin(result,3)
var=subwrd(ans,2)
*
* datas
*
'set t 1 last'
'q time'
data1=subwrd(result,3)
data2=subwrd(result,5)
 


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
say "deu ruim!"
'quit'
endif



var=sublin(id,2)
bacia=subwrd(var,1)
label=subwrd(var,2)
xxx=write("todomundo.prn",label' 'bacia,append)
say "calculando para  bacia:"bacia
status2=status
chuva=0
conta=0

t=1
while (t<=33)
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
* pego a chuva do ponto de grade
*
'd rain/10'
valor=subwrd(result,4) 
if valor > 0
chuva=chuva+valor
conta=conta+1
endif 
endif
endwhile
media=chuva/(conta+(0.00001))
rc1 = math_format("%7.2f",chuva)
rc2 = math_format("%7.0f",conta)
rc3 = math_format("%5.2f",media)
fim=write(bacia,dataprev' 'rc3,append)
xxx=write("todomundo.prn",dataprev' 'rc3,append)
t=t+1
endwhile
************  da linha 36
endwhile     
'quit'



