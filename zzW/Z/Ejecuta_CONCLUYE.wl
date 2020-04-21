////EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl" // windows



////////////////////////////////////////////////////
//							ggArrEjecuta
// 			Formado en Ejecuta_INICIO.wl
// Continene sentencia a Ejecuta(ggArrEjecuta[n])
// al  CONCLUIR  una  Tarea proxima ...
// Ejecuta("ABRE","CALENDARIO;RADI~a~b~c;CHEC~1~2")
// donde:      ~ --> ;    en esta rutina
////////////////////////////////////////////////////

//Info("Respuesta="+ggsA)
//Info("Concluye...","", "ggArrEjecuta="+ArrayCount(ggArrEjecuta)) //--------------
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
//Info("ggsE(sentencia actual)="+ggsE,"ggnE(numero actual)="+ggnE,"","ggArrE(desglose)="+ArrayCount(ggArrE),"ggArrEjecuta(sentencias)="+ArrayCount(ggArrEjecuta))
// --------------------------------------------------
ggsE = ""; ggsE1 = ""; ggsE2 = ""
IF ArrayCount(ggArrE) > 1 THEN
	ggsE1 = ggArrE[1]
	FOR ggnE = 2 TO ArrayCount(ggArrE)
		ggsE2 = ggArrE[ggnE] + ";"
	END
	IF ggsE2 <> "" THEN Left(ggsE2,Length(ggsE2)-1)
	//Info("(Concluye)ggArrE="+ArrayCount(ggArrE),"",">>> Ejecuta("+ggArrE[1]+" , "+ggArrE[2]+") <<<")
	Ejecuta(ggsE1,ggsE2)
ELSE
	Ejecuta("ABRE")	// capa por default
END
