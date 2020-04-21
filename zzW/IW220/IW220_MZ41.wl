//EXTERN ".\zzW\IW220\IW220_MZ41.wl"



// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

cyValor is currency

// Verifica pago actual = pago exacto
IF Val(MZ_4.STC_Static1) = gcyPaga THEN
	MZ_4.STC_Static1 = 0
END

SWITCH MZ_41
	CASE 1: cyValor = 500
	CASE 2: cyValor = 200
	CASE 3: cyValor = 100
	CASE 4: cyValor = 50
	CASE 5: cyValor = 20
	CASE 6: cyValor = 10
	CASE 7: cyValor = 5
	CASE 8: cyValor = 1
END
IF gbSumaResta THEN
	cyValor = cyValor + Val(MZ_4.STC_Static1)
ELSE
	IF Val(MZ_4.STC_Static1) >= cyValor THEN
		cyValor = Val(MZ_4.STC_Static1) - cyValor
	ELSE
		RETURN
	END
END
MZ_4.STC_Static1 = NumToString(cyValor)
gcyPagado = cyValor
IF ggcrT > gcyPagado THEN
	STC_pagado = "Falta: "+(ggcrT-gcyPagado)
ELSE
	STC_pagado = "Cambio: "+(gcyPagado-ggcrT)
END
