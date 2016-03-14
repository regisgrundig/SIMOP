
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
'quit'


function baixagfs(config)

'sdfopen http://nomads.ncep.noaa.gov:9090/dods/gfs_1p00/gfs'config'/gfs_1p00_00z'

'set lon 280 330'
'set lat -40 10'
t=2
k=1
'set fwrite 'config'_1P0.bin'
'set gxout fwrite'
while (t<=33)
'set t 't
'd pratesfc(t='t')*12*3600+pratesfc(t='t+1')*12*3600'
*'d apcpsfc'
t=t+2
k=k+1
endwhile
'disable fwrite'
'set gxout shaded'
say k' 't
return
