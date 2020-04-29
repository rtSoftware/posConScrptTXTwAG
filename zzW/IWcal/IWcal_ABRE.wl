//EXTERN ".\zzW\IWcal\IWcal_ABRE.wl" // windows

// Ejecuta("ABRE") // le sera asignada la 1a tarea por defecto
// Ejecuta("ABRE","TAREA")
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
IF Upper(gapA[1]) IN("COMBO","CHECK","RADIO") THEN gapA[1] = Left(gapA[1],4)	// AutoCorrige
IF Upper(gapA[1]) NOT IN("CALENDARIO","TOOLS","FUNCIONES","CLAVE","COMB","CHEC","COMB","EDT","RADI","TREE")  THEN
	Error(gapA[1]+"<-- tarea no definida en "+sCompilaTXT,"Sera asignada la tarea por defecto...")
	gapA[1] = ""
END
IF gapA[1] = "" THEN gapA[1] = "CALENDARIO"

{gestoyEn,indWindow}..Plane = 0 // capa
SWITCH gapA[1]
	CASE ~~"CALENDARIO"
		{gestoyEn,indWindow}..Plane = 1

		IF ArrayCount(gapA) > 0 THEN
			IF gapA[1] = "OK" THEN CLOSE()

			IF ArrayCount(gapA) > 1 THEN
				ggsX = Upper(gapA[2])
				IF ggsX NOT IN ("FECHA","RANGO") THEN
				 	Error("X parametro invalido para Calendario... es "+ggsX); ggsX = ""
				END
			END
		END
		ggsFECHA1 = ""; ggsFECHA2 = ""
	CASE ~~"CLAVE"
		{gestoyEn,indWindow}..Plane = 4 // capa
		IF EDT_clave..Caption = "" THEN
			EDT_clave..Caption = gapA[2]; gsClave = gapA[3]
			ReturnToCapture(EDT_clave)
		END

		// Inexistente... compara Ejecuta("ABRE","CLAVE;blanco;negro")
		ggbContinua = False; ToClipboard("X"); gapA[1] = "X"
		IF gsClave <> "" AND EDT_clave = gsClave THEN
			ggbContinua = True; ToClipboard("OK"); gapA[1] = "OK"
		END
		EDT_clave..Caption = ""; EDT_clave = "" // importante...
		//EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
	CASE ~~"CHEC": gnCapa = 7; Ejecuta(gapA[1])	//424
	CASE ~~"COMB": gnCapa = 5; Ejecuta(gapA[1])	//424
	CASE ~~"FUNCIONES": {gestoyEn,indWindow}..Plane = 3
	CASE ~~"RADI": gnCapa = 6; Ejecuta(gapA[1])	//424
	CASE ~~"TOOLS": {gestoyEn,indWindow}..Plane = 2
	OTHER CASE: Error(gapA[1]+" tarea (2002292003) no definida en "+sCompilaTXT); RETURN
END

// Redirecciona a una funcionalidad particular
IF {gestoyEn,indWindow}..Plane = 0 THEN
	// Ejecuta("ABRE","tarea;param1,2,3 ... n")
	gapE[1] = gapA[1]; gapA[1] = ""
	FOR nCpa = 2 _TO_ ArrayCount(gapA)
		gapE[1] = gapA[nCpa] + ";"
	END
	IF gapA[1] <> "" THEN gapA[1] = Left(gapA[1],Length(gapA[1])-1)
	Ejecuta(gapE[1],gapA[1])
END
