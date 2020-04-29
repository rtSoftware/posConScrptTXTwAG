//EXTERN ".\zzW\IWcal\IWcal_ZALI.wl" // windows

//Ejecuta("ZALI")
//Ejecuta("ZALI","CONCLUYE_SELECCION")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

SWITCH gapA[1]
  CASE "CONCLUYE_SELECCION"
    ////////////////////////////////////////////////////
    //							ggArrEjecuta
    // 			Formado en Ejecuta_INICIO.wl
    // Continene sentencia a Ejecuta(ggArrEjecuta[n])
    // al  CONCLUIR  una  Tarea proxima ...
    // Ejecuta("ABRE","CALENDARIO;RADI~a~b~c;CHEC~1~2")
    // donde:      ~ --> ;    en esta rutina 424
    ////////////////////////////////////////////////////

    nDebug = Today()
    IF nDebug = Today() THEN Info("Concluye... respuesta="+ggsRespuesta,"", "ggArrEjecuta="+ArrayCount(ggArrEjecuta))
    // Valida donde debe regresar despues de seleccion...
    IF ArrayCount(ggArrEjecuta) = 0 THEN
      // No esta definido METODO en ggArrEjecuta
      // Despliega error para ser corregido el codigo por administrador
      // Regresa a origen seleccion...
      Error("No definido metodo regreso en ZALI.CONCLUYE_SELECCION"); RETURN
    END

    IF nDebug = Today() THEN Info("ggArrEjecuta="+ArrayCount(ggArrEjecuta),ggArrEjecuta[1])
    FOR ggnE = 1 TO ArrayCount(ggArrEjecuta)
    	IF ggArrEjecuta[ggnE] <> "" THEN
    		ggsE = ggArrEjecuta[ggnE]
    		ggArrEjecuta[ggnE] = ""
    		BREAK
    	END
    END
    ArrayDeleteAll(ggArrE)
    StringToArray(ggsE,ggArrE,"~")
    // --------------------------------------------------
    //IF nDebug = Today() THEN Info("ggsE(sentencia actual)="+ggsE,"ggnE(numero actual)="+ggnE,"","ggArrE(desglose)="+ArrayCount(ggArrE),"ggArrEjecuta(sentencias)="+ArrayCount(ggArrEjecuta))
    IF nDebug = Today() THEN Info("ggsE(sentencia actual)="+ggsE,"ggnE(numero actual)="+ggnE,"","ggArrE(desglose)="+ArrayCount(ggArrE),"ggArrEjecuta(sentencias)="+ArrayCount(ggArrEjecuta))
    // --------------------------------------------------
    ggsE = ""; ggsE1 = ""; ggsE2 = ""
    IF ArrayCount(ggArrE) > 1 THEN
    	ggsE1 = ggArrE[1]
    	FOR ggnE = 2 TO ArrayCount(ggArrE)
    		ggsE2 = ggArrE[ggnE] + ";"
    	END
    	IF ggsE2 <> "" THEN Left(ggsE2,Length(ggsE2)-1)
      IF nDebug = Today() THEN Info("(Concluye)ggArrE="+ArrayCount(ggArrE),"",">>> Ejecuta("+ggArrE[1]+" , "+ggArrE[2]+") <<<")
    	Ejecuta(ggsE1,ggsE2)
    ELSE
    	Ejecuta("ABRE")	// capa por default
    END
  OTHER CASE
    SWITCH {gestoyEn,indWindow}..Plane
    	CASE 1
      OTHER CASE: Error(gapA[1]+"<-- Tarea no definido ("+gestoyEn+" - 385799) metodo: ZALI parametros: "+gapA[2])
    END
END
NextTitle("")
