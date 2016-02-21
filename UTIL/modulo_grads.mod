*
* BANCO DE FUNCOES DO GRADS 
* 
*
*
* PLOTA USINA DEPENDENDO DA BACIA
*
function plotausina(bacia,page) 


if (bacia = "grande" ) 
'set line 1 1 1'
'q w2xy -44.633 -21.28333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Camargos'

'q w2xy -44.5666 -22.51666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Funil'

'q w2xy -46.316 -20.666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Furnas'

'q w2xy -49.183 -20.3'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Marimbondo'

'q w2xy -47 -20.28'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Mascarenhas de Moraes'

'q w2xy -47.3 -20'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Estreito'

'q w2xy -48.55 -20'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Porto Colombia'

'q w2xy -48.23 -20'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Volta Grande'

'q w2xy -50.35 -19.886'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Agua Vermelha'

endif


if (bacia = "iguacu" ) 
'set line 1 1 1'
'q w2xy -51.6 -26'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Foz Areia'

'q w2xy -52 -25.78'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Segredo'

'q w2xy -52.6166 -25.65'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Santiago'

'q w2xy -53 -25.53333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Osorio'

'q w2xy -53.48 -25.5333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Caxias'

endif

if (bacia = "itaipu" | bacia ="itaipu_d" | bacia ="itaipu_e" ) 
'set line 1 1 1'
'q w2xy -54.58333 -25.41666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Itaipu'

'set line 1 1 1'
'q w2xy -52.96666 -22.46666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Porto Primavera'

'set line 1 1 1'
'q w2xy -51.63333 -20.78333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Jupia'

'q w2xy -51.36665 -20.38333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Ilha Solteira'

endif


if (bacia = "uruguai" ) 
'set line 1 1 1'
'q w2xy -51.9347722 -26.696944'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Passo Maia'

'q w2xy -51.31667 -27.753617'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Moinho'

'q w2xy -51.78333 -27.5166'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Machadinho'

'q w2xy -52.38333 -27.26666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Ita'

'q w2xy -52.73333 -27.55'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*set strsiz 1'
'draw string 'x' 'y' Passo Fundo'  

endif


if (bacia ="paranapanema" )
'set line 1 1 1'
'q w2xy -49.23 -23.21666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Jurumirim'

'q w2xy -49.7333 -23.01'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Xavantes'

'q w2xy -51.33333 -22.65'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Capivara'

'q w2xy -52.8666 -22.5'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Rosana'

endif


if (bacia ="paranaiba" ) 
'set line 1 1 1'
'q w2xy -43.5666 -6.8'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Boa Esperança'

'q w2xy -50.5 -19.01666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Sao Simao'

'q w2xy -49.5 -18.5'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Cachoeira Dourada'

'q w2xy -47.98333 -18.45'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Emborcacao'

'q w2xy -49.1	-18.41666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Itumbiara'

endif


if (bacia = "jacui" ) 
'set line 1 1 1'
'q w2xy -53.26666 -29.43333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Dona Francisca'

'q w2xy -53.18333 -29.01666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Passo real'

endif


if (bacia = "tiete" ) 
'set line 1 1 1'
'q w2xy -46 -23.5666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Ponte Nova'

'q w2xy -48.55 -22.51666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Barra Bonita'

'q w2xy -49.78333 -21.3'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Promissao'

'q w2xy -51.3167 -20.68'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Tres Irmaos'

'q w2xy -50.2 -21.1167'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Nova Avanhandava'

endif

if (bacia = "saofrancisco" ) 
'set line 1 1 1'
'q w2xy -45.2666 -18.16'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Três Marias'

'q w2xy -37.83 -9.58'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Xingo'

'q w2xy -40.83 -9.42'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Sobradinho'

'q w2xy -38.25 -9.35'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Moxoto'

'q w2xy -38.32 -9.1'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Itaparica'

endif

if (bacia = "paraibadosul" ) 
'set line 1 1 1'
'q w2xy -43.55 -21.85'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Ilha dos pombos'

'q w2xy -46 -23.2'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Jaguari'

'q w2xy -45.6666 -23.38333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Paraibuna'

'q w2xy -43.8333 -22.48333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Santa Cecilia'

endif


if (bacia = "tocantins" ) 
'set line 1 1 1'
'q w2xy -48.3 -13.83333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Serra da Mesa'

'q w2xy -48.1333 -13.4'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Cana Brava'

'q w2xy -48.3666 -9.75'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Lajeado'

'q w2xy -49.66666 -3.75'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Tucurui'

endif


if (bacia = "emborcacao" ) 
'set line 1 1 1'
'q w2xy -47.98333 -18.45'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Emborcacao'

endif


if (bacia = "emborcacao-saosimao" ) 
'set line 1 1 1'
'q w2xy -47.98333 -18.45'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Emborcacao'

'q w2xy -48.5166 -17.98333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Corumba'

'q w2xy -48.03 -18.916'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Miranda'

'q w2xy -47.7 -19.1333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Nova Ponte'

'q w2xy -49.1 -18.41666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Itumbiara'

'q w2xy -49.5 -18.5'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Cachoeira Dourada'

'q w2xy -50.5 -19.01666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Sao Simao'

endif


if (bacia = "fareia_jordao_saltoosorio" ) 
'set line 1 1 1'
'q w2xy -53.0 -25.53333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Osorio'

'q w2xy -52.61666 -25.65'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Santiago'

'q w2xy -52.0 -25.78'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Segredo'

'q w2xy -51.65 -26.0'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Foz do Areia'

endif


if (bacia = "foz_do_areia" ) 
'set line 1 1 1'
'q w2xy -51.65 -26.0'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Foz do Areia'

endif


if (bacia = "furnas" ) 
'set line 1 1 1'
'q w2xy -46.316 -20.666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Furnas'

'q w2xy -44.633 -21.28333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Camargos'

endif


if (bacia = "furnaselimoeiro-avermelha" ) 
'set line 1 1 1'
'q w2xy -46.316 -20.666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Furnas'

'q w2xy -47 -20.28'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Mascarenhas de Moraes'

'q w2xy -47.3 -20'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Estreito'

'q w2xy -48.55 -20'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Porto Colombia'

'q w2xy -48.23 -20'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Volta Grande'

'q w2xy -49.183 -20.3'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Marimbondo'

'q w2xy -47.0 -21.6166'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Aso'

'q w2xy -50.35 -19.886'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Agua Vermelha'

endif


if (bacia = "jusante_fozareia" ) 
'set line 1 1 1'
'q w2xy -54.58333 -25.41666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Itaipu'

'q w2xy -51.6 -26'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Foz Areia'

'q w2xy -52 -25.78'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Segredo'

'q w2xy -52.6166 -25.65'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Santiago'

'q w2xy -53 -25.53333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Osorio'

'q w2xy -53.48 -25.5333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Salto Caxias'

endif


if (bacia = "parana" ) 
'set line 1 1 1'
'q w2xy -54.58333 -25.41666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Itaipu'

'q w2xy -50.5 -19.01666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Sao Simao'

'q w2xy -50.35 -19.886'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Agua Vermelha'

'q w2xy -51.36665 -20.38333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Ilha Solteira'

'q w2xy -51.316667 -20.68'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Tres Irmaos'

'q w2xy -51.63333 -20.78333'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Jupia'

'q w2xy -52.96666 -22.46666'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Porto Primavera'

'q w2xy -52.8666 -22.5'
x=subwrd(result,3)
y=subwrd(result,6)
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' Rosana'

endif


return






function plotatudo
status=0
while (!status)
fd=read("../../UTIL/usinas.txt")
status=sublin(fd,1)
linha=sublin(fd,2)
xlon=subwrd(linha,1)
xlat=subwrd(linha,2)
usina=subwrd(linha,3) 
say xlon' 'xlat' 'usina
if (status = 0) 
'set line 1 1 1' 
'q w2xy 'xlon' 'xlat' '
x=subwrd(result,3)
y=subwrd(result,6)
say x' 'y' 'result
'draw mark 9 'x' 'y' 0.3'
*'set strsiz 1'
'draw string 'x' 'y' 'usina
endif
endwhile
return 
