//EXTERN ".\zzW\IWmem\IWmem_TITU.wl"



// Ejecuta("ABRE")
// Ejecuta("ABRE","tarea;param1,2,3 ... n")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
// 						generalmente viene de:   libA[K].MEV
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"


////IF sCpa1 = "" THEN Error("X  aucente en "+sCompilaTXT); RETURN
sCapituloINI = gapA[1]
IF sCapituloINI = "" THEN sCapituloINI = gsPCata; Input("Titula CAT�LOGO ?",sCapituloINI)
IF sCapituloINI = "" THEN Error("Imposible asignar TITULOS a tabla...","Puede hacerlo mas adelante","Seleccione opciones: Titular"); RETURN

sPreObj = "TABLE_memoria"; sCpo = "Cata"
sObjeto = sPreObj+".COL_"+sCpo; {sObjeto}..Caption = sCapituloINI
EXTERN ".\zzW\Z\titula_pinta.wl"
sCapituloINI = ""
TableDisplay({sPreObj})
