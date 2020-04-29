//EXTERN ".\zzW\IWbro\IWbro_ABRE.wl" // windows



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
IF Upper(gapA[1]) NOT IN("BROWSER","COMB","CHEC","EDT_TEXT","EDT_HTML","EDT_RTF","IMAG","RADI","TEST","TREE","WORD","ZALI") THEN
	Error(gapA[1]+"<-- tarea no definida filtro inicial en "+sCompilaTXT,"Sera asignada la tarea por defecto...")
	gapA[1] = ""
END
IF gapA[1] = "" THEN gapA[1] = "BROWSER"


{gestoyEn,indWindow}..Plane = 0 // capa
SWITCH gapA[1]
	CASE ~~"BROWSER"
		{gestoyEn,indWindow}..Plane = 1 // capa
		IF gapA[2] <> "" THEN HTM_ccp..Value = gapA[2]

		//Info("hhhhHTM_ccp...",HTM_ccp..Value,HTM_ccp..InitialValue)

		//HTM_ccp..Value = "https://www.yahoo.com"
		//Info(IW_browser..Plane,HTM_ccp..Value,HTM_ccp..InitialValue)

  CASE ~~"COMB"
		gnCapa = 5
		Ejecuta(gapA[1])  //EXTERN ".\zzW\Z\param_COMB.wl"
  CASE ~~"CHEC"
		gnCapa = 7
		IF ArrayCount(gapA) < 11 THEN CBOX_1..Height = 350 // lo reduce a la mitad ...
		Ejecuta(gapA[1])  //EXTERN ".\zzW\Z\param_CHEC.wl"
	CASE ~~"EDT_Text"
		{gestoyEn,indWindow}..Plane = 4 // capa
		//IF gapA[2] <> "" THEN EDT_Text..Value = fLoadText(gapA[2])

	CASE ~~"EDT_HTML"
	  Info("En construccion ....")
		{gestoyEn,indWindow}..Plane = 9 // capa

	CASE ~~"EDT_RTF",~~"RTF"
		{gestoyEn,indWindow}..Plane = 2 // capa

	CASE ~~"IMAG"
		{gestoyEn,indWindow}..Plane = 10 // capa

		sSelec is string = ggsA	// regresa seleccion de varias opciones en SWITCH gapA[1]...
		ggsA = ""  // Inicializa ciclo

		IF sSelec IN ("BROWSER","EDT_Text","EDT_RTF","WORD") THEN Ejecuta("ABRE",ggsA)
		IF sSelec = "IMAG" THEN
			ggsA = fSelect("", "Selecciona Archivo...", "TODOS (*.*)"+TAB+"*.*", "*")
			IF ggsA <> "" THEN IMG_1 = ggsA ELSE IMG_1 = "mm3.jpg"
			RETURN
		END
		IF gapA[2] = "OPCIONES" THEN
			// ABRE~IMAG hace que regrese a IMAG con seleccin en ggsA  de RADI
			ggsA = "NADA"
			Ejecuta("ABRE","BROWSER;RADI;EDT_Text;EDT_RTF;IMAG;WORD;ABRE~IMAG")
		END

	CASE ~~"WORD"
		{gestoyEn,indWindow}..Plane = 3 // capa

  CASE ~~"RADI"
		gnCapa = 6
		IF ArrayCount(gapA) < 11 THEN RADIO_1..Height = 350 // lo reduce a la mitad ...
		Ejecuta(gapA[1])  //EXTERN ".\zzW\Z\param_RADI.wl"

	CASE ~~"TEST"
		sSelec is string = ggsA	// regresa seleccion de varias opciones en SWITCH gapA[1]...
		ggsA = ""  // Inicializa ciclo

		IF sSelec NOT IN ("Browser","comb","chec","radi","EDT_Text","EDT_HTML","EDT_RTF","IMAG","WORD") THEN
			// ABRE~TEST hace que regrese a TEST con seleccin en ggsA de COMB
			Ejecuta("ABRE","COMB;Browser;*comb;chec;radi;EDT_Text;EDT_HTML;EDT_RTF;IMAG;WORD;ABRE~TEST")
			// Sintaxis alterna 1 ... (solo didactico)
			//Ejecuta("ABRE;COMB;Browser;*comb;chec;radi;EDT;ABRE~TEST")
			// Sintaxis alterna 2 ... (solo didactico)
			//Ejecuta("ABRE;COMB","Browser;*comb;chec;radi;EDT;ABRE~TEST")
		ELSE
			SWITCH UPPER(sSelec)
				CASE "": Info("Sin respuesta")
				CASE "BROWSER": Ejecuta("ABRE",UPPER(sSelec))
				CASE "COMB","CHEC","RADI"
					ggsA = ""; Input("Opciones ? (separadas por comas)",ggsA)
					Ejecuta("ABRE",UPPER(sSelec)+";"+Replace(ggsA,",",";"))
				CASE "EDT_TEXT": Ejecuta("ABRE",UPPER(sSelec))
				CASE "EDT_HTML": Ejecuta("ABRE",UPPER(sSelec))
				CASE "EDT_RTF": Ejecuta("ABRE",UPPER(sSelec))
				CASE "IMAG": Ejecuta("ABRE",UPPER(sSelec))
				OTHER CASE: Error(ggsA+"<-- Respuesta...")
			END
		END
  CASE ~~"TREE"

	CASE ~~"ZALI"
		IF EDT_TXT <> "" THEN
			IF NOT YesNo("Salir sin guardar cambios en documento TXT ?") THEN
				EXTERN ".\zzW\Z\TXT_SALVA.wl"
			END
		END

		IF ENT_RTF <> "" THEN
			IF NOT YesNo("Salir sin guardar cambios en documento RTF ?") THEN
				{gestoyEn,indWindow}..Plane = 2; Info("Continuar ?")
				//EXTERN ".\zzW\Z\TXT_SALVA.wl"
			END
		END

		IF EDT_HTM <> "" THEN
			IF NOT YesNo("Salir sin guardar cambios en documento HTML ?") THEN
				EXTERN ".\zzW\Z\HTML_SALVA.wl"
			END
		END


	OTHER CASE: Error(gapE[1]+" tarea (200302737) no definida en "+sCompilaTXT); RETURN
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
