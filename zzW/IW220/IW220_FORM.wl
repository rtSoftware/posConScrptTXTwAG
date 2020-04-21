//EXTERN ".\zzW\IW220\IW220_FORM.wl"

// Ejecuta("XXX_EDT")  // sin prefijo   "XXX_xxxx"    es codigo base
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
  Error("X (2191931) parametro CAPA aucente/erroneo en "+sCompilaTXT)
  SWITCH {gestoyEn,indWindow}..Plane
    CASE gnCapaLogin: gapA[1] = "LOGIN"
    CASE gnCapaSku: gapA[1] = "SKU"
    CASE gnCapaPago: gapA[1] = "PAGO"
    OTHER CASE: Error("X no definida Tarea en "+sCompilaTXT); EndProgram()
  END
END

IF Upper(gapA[1]) = "SKU" THEN
	// sku
	// Lo unico por formar es el RECIBO que solo basta con
	// desplegar    LooperDisplay(LOOP_Recibo)
	// tarea definidad en IW_recibo o IW_escan ...
	IF nDebug = Today() THEN Info("Nada que formar en capa SKU ...")
ELSE IF Upper(gapA[1]) = "LOGIN"
	// T E R M I N A      F I R M A
	IF nDebug = Today() THEN Info("ggsSoy="+ggsSoy)
	sCorreo,sCelular is string
	IF ArrayCount(gapA) > 17 THEN
		ggsSoy = gapA[3]; ggsSoyNombre = gapA[4]
		sCelular = gapA[11]; sCorreo= gapA[14]

		IF nDebug = Today() THEN Info("Fecha EMPL","",gapA[17])
		IF gapA[17] = "20000101" THEN ggsLog = "Usuario dado de baja"; ggsSoy = ""; ggsSoyNombre = ""
	ELSE
			ggsLog = " DATA inexistente ...."
	END

	IF ggsSoy = "" THEN Error("Acceso Denegado "+ggsLog); RETURN

	// Broxel ...
	IF ggsCia = "BX" AND Length(sCelular) <> 10 THEN
		Error("Imposible entrar sin numero celular valido..."); Ejecuta("ABRE") //0201
	END

	INIWrite("EMPL","Nombre",ggsSoyNombre,ggsIni)
	INIWrite("EMPL","Usuario",ggsSoy,ggsIni)

	ndelimita is int = Position(sCorreo,"~")
	IF ndelimita > 0 THEN
		INIWrite("EMPL","Correo",Left(sCorreo,ndelimita-1),ggsIni)
		INIWrite ("EMPL","Celular",sCelular,ggsIni) // XMG 17072019 escribir en el .ini el correo de la persona
		INIWrite("CORREO","A",Left(sCorreo,ndelimita-1))
	ELSE
		INIWrite("EMPL","Correo",sCorreo,ggsIni)
		INIWrite ("EMPL","Celular",sCelular,ggsIni) // XMG 17072019 escribir en el .ini el correo de la persona
		INIWrite("CORREO","A",sCorreo,ggsIni)
	END
	IF ggsSoy <> "" THEN
		//ToastDisplay("Bienvenido "+INIRead("EMPL","Correo","",ggsIni),toastShort,vaTop,haCenter)
	END
ELSE
	Error(gapA[1]+" es una capa inexistente en "+sCompilaTXT); Close()
END
