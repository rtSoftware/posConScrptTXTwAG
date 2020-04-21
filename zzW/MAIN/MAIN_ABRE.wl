//EXTERN ".\zzW\MAIN\MAIN_ABRE.wl" // windows



// Ejecuta("ABRE")
// Ejecuta("ABRE","tarea;param1,2,3 ... n")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// Valida ...
IF Upper(gapA[1]) NOT IN("DASH") THEN
	Error(gapA[1]+"<-- tarea no definida filtro inicial en "+sCompilaTXT,"Sera asignada la tarea por defecto...")
	gapA[1] = ""
END
IF gapA[1] = "" THEN gapA[1] = "DASH"


{gestoyEn,indWindow}..Plane = 0 // capa
SWITCH gapA[1]
	CASE ~~"ABRE"
	
	OTHER CASE: Error(gapE[1]+" tarea (419634) no definida en "+sCompilaTXT); RETURN
END
