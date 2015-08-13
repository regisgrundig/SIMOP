dset ^../NCEP/PRCP_CU_GAUGE_V1.0GLB_0.50deg.lnx.%y4%m2%d2.RT
options  little_endian template 
title global daily analysis 
undef -999.0 
xdef 720 linear    0.25 0.50
ydef 360  linear -89.75 0.50 
zdef 1    linear 1 1 
tdef 13000 linear 0Z0JAN1979 1dy 
vars 2
rain     1  00 the grid analysis (0.1mm/day)
gnum     1  00 the number of stn
ENDVARS
