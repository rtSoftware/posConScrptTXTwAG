//EXTERN ".\zzW\IW220\IW220_CALC.wl



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

gnUniTot = 0; gcyImporte = 0; gcyDescTot = 0
HReadFirst(Recibo)
WHILE HOut(Recibo) = False
	IF NOT HModify(Recibo,hRecNumCurrent) THEN
		Error(""+HErrorInfo())
	ELSE
		gcyImporte += Recibo.extendido
		gnUniTot += Recibo.uni
		gcyDescTot += Recibo.descuento
	END

	HReadNext(Recibo)
END
Ejecuta("LOOPER_RECIBO") // vacio en Ejecuta(gapE[1],gapA[1],pN) cuando no aplica
