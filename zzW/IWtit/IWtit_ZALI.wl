//EXTERN ".\zzW\IWtit\IWtit_ZALI.wl" // windows



//Ejecuta("ZALI"[,"tarea"])
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

SWITCH {gestoyEn,indWindow}..Plane
	CASE 1

	OTHER CASE: Error(gapA[1]+" es una capa inexistente en "+sCompilaTXT); Close()
END
