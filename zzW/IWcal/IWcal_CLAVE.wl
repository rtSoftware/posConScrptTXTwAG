//EXTERN ".\zzW\IWcal\IWcal_CLAVE.wl" // windows

// Ejecuta("CLAVE","Blanco;Negro")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"


{gestoyEn,indWindow}..Plane = 4 // capa
IF EDT_clave..Caption = "" THEN
	EDT_clave..Caption = gapA[1]; gsClave = gapA[2]
	RETURN
END

// Inexistente... compara Ejecuta("ABRE","CLAVE;blanco;negro")
ggbContinua = False; ToClipboard("X"); gapA[1] = "X"
IF gsClave <> "" AND EDT_clave = gsClave THEN
	ggbContinua = True; ToClipboard("OK"); gapA[1] = "OK"
END
EDT_clave..Caption = ""; EDT_clave = "" // importante...
IW_calendario..Plane = 1
