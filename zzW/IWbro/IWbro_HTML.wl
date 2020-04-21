//EXTERN ".\zzW\IWbro\IWbro_HTML.wl" // windows

//Ejecuta("HTML")
//Ejecuta("HTML","param1,2,3 ... n")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

{gestoyEn,indWindow}..Plane = gnCapa
sCTL = "HTML_1"
