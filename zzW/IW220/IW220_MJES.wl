//EXTERN ".\zzW\IW220\IW220_MJES.wl"

//Ejecuta("MJES","SKU;Escan Sku")	// mensaje a desplegar
// Ejecuta("XXX_MJES","LOGIN")  // sin prefijo   "XXX_xxxx"    es codigo base
/////////////////////////////////////////////////////////////////////////
// Flujo:   BTN_<0..1> --> EDT_Captura / EDT_Usuario (ciclo)
//            BTN_E --> ENTER --> FIND --> FORM (INI)     // login
//            BTN_E --> ENTER --> FIND --> FORM (Recibo)  // sku
//            BTN_P --> ENTER --> FIND --> FORM (kata)    // pago
//            BTN_C --> ABRE  (cancela)
//          MJES --> IWxxx_ZALI   (muy variado)
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// Valida ...
IF Upper(gapA[1]) NOT IN("LOGIN","SKU","PAGO")  THEN gapA[1] = ""
IF gapA[1] = "" THEN
  Error("X parametro CAPA aucente/erroneo en "+sCompilaTXT)
  SWITCH {gestoyEn,indWindow}..Plane
    CASE gnCapaLogin: gapA[1] = "LOGIN"
    CASE gnCapaSku: gapA[1] = "SKU"
    CASE gnCapaPago: gapA[1] = "PAGO"
    OTHER CASE: Error("X no definida Tarea en "+sCompilaTXT); EndProgram()
  END
END

IF gapA[1] = "LOGIN" THEN
	{gestoyEn,indWindow}..Plane = gnCapaLogin
	//GR_mjes..Visible = False //0219

ELSE IF gapA[1] = "SKU"
	{gestoyEn,indWindow}..Plane = gnCapaSku
	//GR_mjes..Visible = True
	STC_1 = ""; STC_2 = ""; STC_3 = ""; STC_4 = ""

	// * = salta
	IF Left(gapA[2],1) <> "*" THEN STC_1 = gapA[2]
	IF Left(gapA[3],1) <> "*" THEN STC_2 = gapA[3]
	IF Left(gapA[4],1) <> "*" THEN STC_3 = gapA[4]
	IF Left(gapA[5],1) <> "*" THEN STC_4 = gapA[5]

	IF HnbRec(Recibo) > 0 THEN
    Ejecuta("CALC","SKU")
    STC_TotalRecibo = "TOTAL "+NumToString(gcyImporte,"8.2f")
    STC_4 = "TOTAL "+NumToString(gcyImporte,"8.2f")

    // ciclo infinito ??????????????
		//ggsA = "IW_recibo"  // Widget (INI: [cfg]DASH=WIN_MAIN.DASH1)
		////EXTERN ".\zzW\Z\IW_EXISTE.wl"
		//IF bCpa1 THEN Ejecuta("MJES","SKU")
	ELSE
		ggsA = "IW_grafica"  // Widget (INI: [cfg]DASH=WIN_MAIN.DASH1)
    IF ggsDash_Nombre = "" THEN Error("X no definido DASH en ini..."); RETURN
    IF ggsA = "" THEN Error("X no definido Widget..."); RETURN   // ggsA = "IW_grafica"

    IF ggsA <> "" AND ggsA1 <> "" THEN
    	FOR nCpa1 = 1 TO DashCount({ggsDash_Nombre,indControl},toTotal)
    		IF {ggsDash_Nombre,indControl}[nCpa1]..Name = ggsA THEN bCpa1 = True; BREAK
    	END
    END

	  IF bCpa1 THEN
	    ArrayDeleteAll(garrTit1); ArrayDeleteAll(garrVal11)
	    ArrayAdd(garrTit1,"uno"); ArrayAdd(garrTit1,"dos"); ArrayAdd(garrTit1,"tres")
	    ArrayAdd(garrVal11,15); ArrayAdd(garrVal11,35); ArrayAdd(garrVal11,50)
	    IW_grafica.Ejecuta("ABRE","C1;VENTAS")
	  END
	END
ELSE
	IF nDebug = Today() THEN Error(gapA[1]+" es una capa inexistente en "+sCompilaTXT); RETURN
END
