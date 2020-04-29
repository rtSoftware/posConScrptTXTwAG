//EXTERN ".\zzW\MAIN\MAIN_ABRE.wl" // windows



// Ejecuta("ABRE")
// Ejecuta("ABRE","tarea;param1,2,3 ... n")
// Ejecuta("ABRE;tarea;param1,2,3 ... n")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

SWITCH gapA[1]
	CASE ""
	CASE ~~"DASH"
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		// >>>>>>>>>>>>>> No acepta script compilacion <<<<<<<<<<<<
		// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		
		// Nombre Dash...				
		ggsDash_Nombre = INIRead("cfg","DASH","",ggsIni)
		IF ggsDash_Nombre = "" THEN
			// Widget (INI: [cfg]DASH=WIN_MAIN.DASH1)
			ggsDash_Nombre = ""; Input("Nombre del VENTANA.DASH ?",ggsDash_Nombre)
			IF ggsDash_Nombre = "" THEN Error("Imposible continuar sin nombre Ventana.Dash"); EndProgram()
			
			INIWrite("cfg","DASH",ggsDash_Nombre,ggsIni)
		END
		
		WIN_MAIN..Plane = 1
		// Si existe IW_captura asigna foco a EDT_2 ...
		FOR i = 1 TO DashCount({ggsDash_Nombre,indControl},toTotal)
			IF WIN_MAIN.DASH_1[i]..Name = "IW_captura" THEN ReturnToCapture(IW_captura.EDT_Usuario); BREAK
		END
		// Cuidado ReturnToCapture en IW_captura no permite pasar nunca por aqui ...
		
		FOR i = 1 TO DashCount({ggsDash_Nombre,indControl},toTotal)
			IF WIN_MAIN.DASH_1[i]..Name = "IW_recibo" THEN IW_recibo.Ejecuta("ABRE","LOGIN"); BREAK
		END

	CASE ~~"COMB": Ejecuta(gapA[1])	//;gnCapa = 5
	CASE ~~"CHEC": Ejecuta(gapA[1])	//;gnCapa = 6
	CASE ~~"RADI": Ejecuta(gapA[1])	//;gnCapa = 7
	OTHER CASE
		SWITCH {gestoyEn,indWindow}..Plane
			CASE 1
			CASE 2
			CASE 3
			CASE 4
			CASE 5
			CASE 6
			OTHER CASE: Error("(38503)Tarea no definida en "+sCompilaTXT); RETURN
		END
END
