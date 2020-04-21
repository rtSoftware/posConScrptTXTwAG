//EXTERN ".\zzW\IW220\IW220_MZ42.wl"



// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

SWITCH MZ_42
	CASE 1
		ggsA = ""; Input("Numero Tarjeta Credito ?",ggsA)
		IF Length(ggsA) <> 16 THEN
			Error("Numero TC invalido !")
			ggsA = ""
		ELSE
			ggsA1 = ""; Input("Importe ?",ggsA1)
			Info("(ref:2201812) en construccion ...")
		END

	CASE 2
		// cuenta CLIENTE (nomina)
		Info("(ref:2201815) en construccion ...")
	CASE 3
	Info("(ref:2201817) en construccion ...")

END
