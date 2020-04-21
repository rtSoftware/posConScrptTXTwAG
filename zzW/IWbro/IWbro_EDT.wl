//EXTERN ".\zzW\IWbro\IWbro_EDT.wl" // windows

//Ejecuta("EDT_x")
//Ejecuta("EDT_x","?")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

sCTL = MySelf..Name; IF gapA[1] = "" THEN gapA[1] = sCTL
sCpa1 = MySelf..Caption
IF nDebug = Today() THEN Info("sCTL="+sCTL,"gapA[1]="+gapA[1],"","Caption="+sCpa1,"Caption="+{sCTL}..Caption)
