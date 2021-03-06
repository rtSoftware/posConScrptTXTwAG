//EXTERN ".\zzW\IW220\IW220_BTN_PAGAR.wl"

// Ejecuta("ABRE_PAGO")
// Ejecuta("XXX_ABRE_PAGO","LOGIN")  // sin prefijo   "XXX_xxxx"    es codigo base
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

ggsA = "IW_recibo"  // Widget (INI: [cfg]DASH=WIN_MAIN.DASH1)
IF ggsDash_Nombre = "" THEN Error("X no definido DASH en ini..."); RETURN
IF ggsA = "" THEN Error("X no definido Widget..."); RETURN   // ggsA = "IW_grafica"

IF ggsA <> "" AND ggsA1 <> "" THEN
	FOR nCpa1 = 1 TO DashCount({ggsDash_Nombre,indControl},toTotal)
		IF {ggsDash_Nombre,indControl}[nCpa1]..Name = ggsA THEN bCpa1 = True; BREAK
	END
END

IF bCpa1 THEN
  Ejecuta("ABRE","PAGO")
  RETURN
END


IF NOT YesNo("Registra escan(PAGO) ?") THEN RETURN
