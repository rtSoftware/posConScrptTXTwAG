//EXTERN ".\zzW\IW220\IW220_MZ4.wl"



// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

SWITCH MZ_4 // gapE[1]
	CASE 1
		// Calcula pago recibido ...
		gcyPagado = Val(MZ_4.STC_Static1..Caption) // solo pago en efectivo
		FOR i = 1 TO ArrayCount(garrPagoVal)
			gcyPagado = gcyPagado +	garrPagoVal[i]
		END

		// Faltan pagos ...
		IF gcyPagado < ggcrT THEN
			// continua en modo pago
			STC_pagado = "Falta: "+NumToString(ggcrT-gcyPagado)
		ELSE
			//181022
			IF Val(MZ_4.STC_Static1..Caption) > 0 THEN
				ArrayAdd(garrPagoRef,"")
				ArrayAdd(garrPagoMoneda,"EF")
				ArrayAdd(garrPagoVal,Val(MZ_4.STC_Static1..Caption))
				MZ_4.STC_Static1..Caption = ""	//420
			END


			Ejecuta("ZALI","PAGO") // Aplica el pago ...
		END
END
