*                                                     	
*██╗      █████╗ ███╗   ███╗ ██████╗  ██████╗    ██╗   ██╗███████╗███████╗
*██║     ██╔══██╗████╗ ████║██╔═══██╗██╔════╝    ██║   ██║██╔════╝██╔════╝
*██║     ███████║██╔████╔██║██║   ██║██║         ██║   ██║█████╗  █████╗  
*██║     ██╔══██║██║╚██╔╝██║██║   ██║██║         ██║   ██║██╔══╝  ██╔══╝  
*███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝╚██████╗    ╚██████╔╝██║     ██║     
*╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝     ╚═════╝ ╚═╝     ╚═╝    
*  
*
*███████╗ ██████╗██████╗ ██╗██████╗ ████████╗    ██████╗  █████╗ ██████╗  █████╗      ██████╗ █████╗ ██╗      ██████╗██╗   ██╗██╗      ██████╗     
*██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝    ██╔══██╗██╔══██╗██╔══██╗██╔══██╗    ██╔════╝██╔══██╗██║     ██╔════╝██║   ██║██║     ██╔═══██╗    
*███████╗██║     ██████╔╝██║██████╔╝   ██║       ██████╔╝███████║██████╔╝███████║    ██║     ███████║██║     ██║     ██║   ██║██║     ██║   ██║    
*╚════██║██║     ██╔══██╗██║██╔═══╝    ██║       ██╔═══╝ ██╔══██║██╔══██╗██╔══██║    ██║     ██╔══██║██║     ██║     ██║   ██║██║     ██║   ██║    
*███████║╚██████╗██║  ██║██║██║        ██║       ██║     ██║  ██║██║  ██║██║  ██║    ╚██████╗██║  ██║███████╗╚██████╗╚██████╔╝███████╗╚██████╔╝    
*╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝     ╚═════╝╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝   ------------------------------------------------------------------------
*
* ██████╗██╗  ██╗██╗   ██╗██╗   ██╗ █████╗      █████╗  ██████╗██╗   ██╗███╗   ███╗██╗   ██╗██╗      █████╗ ██████╗  █████╗     
*██╔════╝██║  ██║██║   ██║██║   ██║██╔══██╗    ██╔══██╗██╔════╝██║   ██║████╗ ████║██║   ██║██║     ██╔══██╗██╔══██╗██╔══██╗    
*██║     ███████║██║   ██║██║   ██║███████║    ███████║██║     ██║   ██║██╔████╔██║██║   ██║██║     ███████║██║  ██║███████║    
*██║     ██╔══██║██║   ██║╚██╗ ██╔╝██╔══██║    ██╔══██║██║     ██║   ██║██║╚██╔╝██║██║   ██║██║     ██╔══██║██║  ██║██╔══██║    
*╚██████╗██║  ██║╚██████╔╝ ╚████╔╝ ██║  ██║    ██║  ██║╚██████╗╚██████╔╝██║ ╚═╝ ██║╚██████╔╝███████╗██║  ██║██████╔╝██║  ██║    
* ╚═════╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝    ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝    
*      
*██╗   ██╗███████╗██████╗ ███████╗ ██████╗     ██████╗ 
*██║   ██║██╔════╝██╔══██╗██╔════╝██╔═══██╗    ╚════██╗
*██║   ██║█████╗  ██████╔╝███████╗██║   ██║     █████╔╝
*╚██╗ ██╔╝██╔══╝  ██╔══██╗╚════██║██║   ██║     ╚═══██╗
* ╚████╔╝ ███████╗██║  ██║███████║╚██████╔╝    ██████╔╝
*  ╚═══╝  ╚══════╝╚═╝  ╚═╝╚══════╝ ╚═════╝     ╚═════╝ 

*
*  bY regis  reginaldo.venturadesa@gmail.com 
*  uso:
*      calcula.gs (exige grads)   [00/12]   
*------------------------------------------------------------------------- 
*
*
'reinit'
'open modelo_all.ctl'
'q time'
data=subwrd(result,3)
'q files'
ans=sublin(result,3)
var=subwrd(ans,2)
*
* data da rodada
*
data1=substr(var,1,10)
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
_pchuva.1=0
while (t<=10)
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
conta=0
chuva=0
while (!status2)
fd=read("../../CONTORNOS/CADASTRADAS/"bacia)
say bacia'============================================'
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
'd prec'
valor=subwrd(result,4) 
if (valor < 0.2) 
valor=0
endif 
chuva=chuva+valor
conta=conta+1 
yyy=write("logao.prn",bacia' 'xlat' 'xlon' 'valor' 'conta' 't)
endif
endwhile

media=chuva/(conta+(0.00001))
rc1 = math_format("%7.2f",chuva)
rc2 = math_format("%7.0f",conta)
rc3 = math_format("%5.2f",media)
p=p+1
_pchuva.p=media
fim=write(bacia,data1' 'dataprev' 'rc3)
xxx=write("todomundo.prn",data1' 'dataprev' 'rc3)
t=t+1
endwhile
say "=================================="label' 'data1' 'bacia
if (opcao ="SIM") 
ih=removiessum(label,data1,bacia) 
endif 
************  da linha 36
endwhile     
'quit'


*============================================================================================================================================================
*██████╗ ███████╗███╗   ███╗ ██████╗  ██████╗ █████╗  ██████╗     
*██╔══██╗██╔════╝████╗ ████║██╔═══██╗██╔════╝██╔══██╗██╔═══██╗    
*██████╔╝█████╗  ██╔████╔██║██║   ██║██║     ███████║██║   ██║    
*██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║██║     ██╔══██║██║   ██║    
*██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝╚██████╗██║  ██║╚██████╔╝    
*╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝ ╚═════╝     
*                                                                 
*██████╗ ███████╗                                                 
*██╔══██╗██╔════╝                                                 
*██║  ██║█████╗                                                   
*██║  ██║██╔══╝                                                   
*██████╔╝███████╗                                                 
*╚═════╝ ╚══════╝                                                 
*                                                                 
*██╗   ██╗██╗███████╗███████╗                                     
*██║   ██║██║██╔════╝██╔════╝                                     
*██║   ██║██║█████╗  ███████╗                                     
*╚██╗ ██╔╝██║██╔══╝  ╚════██║                                     
* ╚████╔╝ ██║███████╗███████║                                     
*  ╚═══╝  ╚═╝╚══════╝╚══════╝  
*=======================================================================================================================================
*
*  ENTRADA: LABEL , DATA1 E BACIA 
*
function removiessum(label,data1,bacia)

*
* verifica o mes
*
mes=substr(data1,5,2)


arquivo=bacia".v"
say arquivo
*
* SOMATORIO DA CHUVA PREVISTA EM 10 DIAS
*
ptoteta10=(_pchuva.1+_pchuva.2+_pchuva.3+_pchuva.4+_pchuva.5+_pchuva.6+_pchuva.7+_pchuva.8+_pchuva.9+_pchuva.10)


*=========================================================================================================================================
*
* MONTANTE FURNAS
*
* MESES DE DEZEMBRO E JANEIRO 
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
*
if  ( label = "MOFURN"  & ( mes =1  | mes =12 )  ) 
*
* constantes a e b 
*
a=0.000204
b=0.47112
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 155.4 )
chuvasem=155.4
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 26 )
chuva=ppre.pp
else
chuva=26
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* MONTANTE FURNAS
*
* MESES DE AGOSTO A SETEMBRO
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
*
*
if  ( label = "MOFURN"  & ( mes >=8  &  mes <=11 )  ) 

*
* constantes a e b 
*
a=0.00019
b=0.52182
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 79.6 )
chuvasem=79.6
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 26 )
chuva=ppre.pp
else
chuva=26
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* MONTANTE FURNAS
*
* MESES DE FEVEREIRO A MARÇO
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
*
*
if  ( label = "MOFURN"  & ( mes >=2  &  mes <=3 )  ) 
*
* constantes a e b 
*
a=0.00152
b=0.51448
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 106.8 )
chuvasem=106.8
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 26 )
chuva=ppre.pp
else
chuva=26
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* JUSANTE FURNAS
*
* MESES DE DEZEMBRO A  MARÇO
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
*
*
if  ( label = "JUFURN"  & ( mes <=3   | mes =12)   ) 
pp=1
if (ptoteta10> 179.5 )
chuvasem=179.5
else
chuvasem=ptoteta10
endif

while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
*ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( _pchuva.pp < 26 )
chuva=_pchuva.pp
else
chuva=26
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* JUSANTE FURNAS
*
* MESES DE AGOSTO A NOVEMBRO
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
*
*
if  ( label = "JUFURN"  & ( mes >=8  &  mes <=11 )  ) 
*
* constantes a e b 
*
a=0.003520
b=0.56935
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 74.9 )
chuvasem=74.9
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 26 )
chuva=ppre.pp
else
chuva=26
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 



*=========================================================================================================================================
*
* EMBORCACAO MONTANTE 
*
* MESES DE SETEMBRO A NOVEMBRO
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
*Montante Emborcação
*
if  ( label = "MOEMBO"  & ( mes >=9  &  mes <=11 )  ) 
*
* constantes a e b 
*
a=0.004139
b=0.56391
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 118.8 )
chuvasem=118.8
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* EMBORCACAO MONTANTE 
*
* MESES DE DEZEMBRO E JANEIRO
* 
*   ( inserido em  10/06/2015)  
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
* DEZ/JAN: a=0,001080; b=0,74100 e limite 10 dias= 179,5 mm
* 
*Montante Emborcação
*
if  ( label = "MOEMBO"  & ( mes =12  |  mes =1 )  ) 
*
* constantes a e b 
*
a=0.001080
b=0.74100
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 179.5 )
chuvasem=179.5
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* EMBORCACAO MONTANTE 
*
* MESES DE FEVEREIRO E MARÇO 
* 
*   ( inserido em  10/06/2015)  
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
* FEV/MAR: a=0,001206; b=0,83948 e limite 10 dias= 139,2 mm
* 
*Montante Emborcação
*
if  ( label = "MOEMBO"  & ( mes >=2  &  mes <=3 )  ) 
*
* constantes a e b 
*
a=0.001206
b=0.83948
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 179.5 )
chuvasem=179.5
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 



*=========================================================================================================================================
*
* EMBORCACAO JUSANTE
*
* MESES DE SETEMBRO A NOVEMBRO
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
*Montante Emborcação
*
if  ( label = "JUEMBO"  & ( mes >=9  &  mes <=11 )  ) 
*
* constantes a e b 
*
a=0.004139
b=0.56391
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 118.8 )
chuvasem=118.8
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* EMBORCACAO JUSANTE
*
* MESES DE DEZEMBRO E JANEIRO
* 
*   ( inserido em  10/06/2015)  
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
* DEZ/JAN: a=0,001080; b=0,74100 e limite 10 dias= 179,5 mm
* 
*Montante Emborcação
*
if  ( label = "JUEMBO"  & ( mes =12  |  mes =1 )  ) 
*
* constantes a e b 
*
a=0.001080
b=0.74100
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 179.5 )
chuvasem=179.5
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* EMBORCACAO JUSANTE
*
* MESES DE FEVEREIRO E MARÇO 
* 
*   ( inserido em  10/06/2015)  
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
* FEV/MAR: a=0,001206; b=0,83948 e limite 10 dias= 139,2 mm
* 
*Montante Emborcação
*
if  ( label = "JUEMBO"  & ( mes >=2  &  mes <=3 )  ) 
*
* constantes a e b 
*
a=0.001206
b=0.83948
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 179.5 )
chuvasem=179.5
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 


*=========================================================================================================================================
*
* MONTANTE TRES MARIAS
*
* MESES DE AGOSTO A NOVEMBRO
*
*   ( inserido em  10/06/2015)
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
*
* AGO/NOV: a=0,0006; b=0,65847 e limite 10 dias= 63,1 mm
*              
if  ( label = "3MARIAS"  & ( mes >=8  &  mes <=11 )  ) 
*
* constantes a e b 
*
a=0.0006
b=0.65847
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 63.1 )
chuvasem=63.1
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* MONTANTE 3 MARIAS
*
* MESES DE DEZEMBRO E JANEIRO
* 
*   ( inserido em  10/06/2015)  
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
* DEZ/JAN: a=0,00008; b=0,76973 e limite 10 dias= 133,7 mm
*Montante Emborcação
*
if  ( label = "3MARIAS"  & ( mes =12  |  mes =1 )  ) 
*
* constantes a e b 
*
a=0.00008
b=0.76973
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 133.7 )
chuvasem=133.7
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 
*=========================================================================================================================================
*
* MONTANTE 3 MARIAS
*
* MESES DE FEVEREIRO E MARÇO 
* 
*   ( inserido em  10/06/2015)  
*                    
* ajustes: 16/11/2015 (Talita Reis e Regis )
* FEV/MAR: a=0,00144; b=0,49365 e limite 10 dias= 123,0 mm
* 
*Montante Emborcação
*
if  ( label = "3MARIAS"  & ( mes >=2  &  mes <=3 )  ) 
*
* constantes a e b 
*
a=0.00144
b=0.49365
pp=1
ptotpre=a*(ptoteta10*ptoteta10)+b*(ptoteta10)
*
* limite semanal 
*
if (ptotpre> 179.5 )
chuvasem=179.5
else
chuvasem=ptotpre
endif
while (pp<=10)
'set t ' pp
'q time'
dataprev=subwrd(result,3)
*
* calcula da chuva com remocao
*
ppre.pp=_pchuva.pp*(chuvasem/ptoteta10)

*
* limite diario
*
if ( ppre.pp < 27 )
chuva=ppre.pp
else
chuva=27
endif
rc3 = math_format("%5.2f",chuva)
yyy=write(arquivo,data1' 'dataprev' 'rc3)
pp=pp+1
endwhile
endif 

return ptoteta10









