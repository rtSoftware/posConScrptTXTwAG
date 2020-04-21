//EXTERN ".\zzW\Z\titula_carga.wl" // windows



SWITCH INIRead(gsPCata,sCpo+"_m","maskNone",ggsIni)
	CASE "maskAlpha": LooperAdd(LOOP_titula,INIRead(gsPCata,sCpo,"ESCONDE",ggsIni)+TAB+"abc"); ATT_mascara[ggnX] = 2
	CASE "maskFUpper": LooperAdd(LOOP_titula,INIRead(gsPCata,sCpo,"ESCONDE",ggsIni)+TAB+"Abc"); ATT_mascara[ggnX] = 2
	CASE "maskUpper": LooperAdd(LOOP_titula,INIRead(gsPCata,sCpo,"ESCONDE",ggsIni)+TAB+"ABC"); ATT_mascara[ggnX] = 1
	CASE "maskEmail": LooperAdd(LOOP_titula,INIRead(gsPCata,sCpo,"ESCONDE",ggsIni)+TAB+"correo@y.com"); ATT_mascara[ggnX] = 1
	CASE "MoneySystemMask$": LooperAdd(LOOP_titula,INIRead(gsPCata,sCpo,"ESCONDE",ggsIni)+TAB+"$99.99"); ATT_mascara[ggnX] = 4
	CASE "maskNum": LooperAdd(LOOP_titula,INIRead(gsPCata,sCpo,"ESCONDE",ggsIni)+TAB+"9999"); ATT_mascara[ggnX] = 5
	OTHER CASE: LooperAdd(LOOP_titula,INIRead(gsPCata,sCpo,"ESCONDE",ggsIni)+TAB+INIRead(gsPCata,sCpo+"_m","maskNone",ggsIni)); ATT_mascara[ggnX] = 1
END
