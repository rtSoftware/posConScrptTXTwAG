//EXTERN ".\zzW\Z\titula_descarga.wl" // windows



INIWrite(gsPCata,sCpo,sTitulo,ggsIni)

SWITCH sMascara
	CASE "ABC": INIWrite(gsPCata,sCpo+"_m","maskUpper",ggsIni)
	CASE "Abc": INIWrite(gsPCata,sCpo+"_m","maskFUpper",ggsIni)
	CASE "abc": INIWrite(gsPCata,sCpo+"_m","maskAlpha",ggsIni)
	CASE "$99.99": INIWrite(gsPCata,sCpo+"_m","MoneySystemMask",ggsIni)
	CASE "9999": INIWrite(gsPCata,sCpo+"_m","maskNum",ggsIni)
	CASE "correo@y.com": INIWrite(gsPCata,sCpo+"_m","maskEmail",ggsIni)
	OTHER CASE: INIWrite(gsPCata,sCpo+"_m",sMascara,ggsIni)
END
