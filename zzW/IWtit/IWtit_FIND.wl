//EXTERN ".\zzW\IW220\IW220_FIND.wl"

// Ejecuta("FIND")
// Ejecuta("FIND","KATA")
// Ejecuta("FIND","EMPL;DB:FIC,DB4=F,FLASH:N")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
// * generalmente independiete de las capas
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

ggsRespuesta = ""

// Valida ...
IF gapA[1] = "" OR gapA[1] = "?" THEN
  gsPCata = ""; Input("Cat�logo ?",gsPCata)
  IF gsPCata = "" THEN RETURN
ELSE
    gsPCata = gapA[1]
END
IF gsPCata = "" THEN Error("X Imposible continuar sin definir catalogo en >>>gsPCata<<<"); RETURN
IF nDebug = Today() THEN Info(gsPCata,"AEM="+ArrayCount(AEM),"AIN="+ArrayCount(AIN))

//      B U S C A   -   F I N D
gsBloqueP = ""  // Asegura
gapA[1] = "" // respuesta (registro empleado/sku)
SWITCH gsPCata
  CASE "CLIE"
    Info(gsPCata+" ...Proceso BUSCA en construccion ..."); RETURN
  CASE "EMPL"
    IF ArrayCount(AEM) > 0 THEN
      FOR nCpa1 = 1 TO ArrayCount(AEM)
        gsBloqueP = gsBloqueP + ";"+gsPCata+";"+AEM[nCpa1]:codigo+";"+AEM[nCpa1]:descripcion+";"+...
        AEM[nCpa1]:val1+";"+AEM[nCpa1]:val2+";"+AEM[nCpa1]:flag+";"+...
        gapA[3]+";"+AEM[nCpa1]:nota+";"+AEM[nCpa1]:b+";"+AEM[nCpa1]:c+";"+...
        AEM[nCpa1]:d+";"+AEM[nCpa1]:f+";"+AEM[nCpa1]:g+";"+AEM[nCpa1]:m+";"+...
        AEM[nCpa1]:n+";"+AEM[nCpa1]:fecha+";"+AEM[nCpa1]:hora + CR
      END
    END
  CASE "INVE"
    IF ArrayCount(AIN) > 0 THEN
    FOR nCpa1 = 1 TO ArrayCount(AIN)
  			gsBloqueP = gsBloqueP + ";"+gsPCata+";"+AIN[nCpa1]:codigo+";"+AIN[nCpa1]:descripcion+";"+...
  			AIN[nCpa1]:val1+";"+AIN[nCpa1]:val2+";"+AIN[nCpa1]:flag+";"+...
  			AIN[nCpa1]:Flagc20+";"+AIN[nCpa1]:nota+";"+AIN[nCpa1]:b+";"+AIN[nCpa1]:c+";"+...
  			AIN[nCpa1]:d+";"+AIN[nCpa1]:f+";"+AIN[nCpa1]:g+";"+AIN[nCpa1]:m+";"+...
  			AIN[nCpa1]:n+";"+AIN[nCpa1]:fecha+";"+AIN[nCpa1]:hora //+Cr
  		END
  	END
  CASE "PROV"
    Info(gsPCata+" ...Proceso BUSCA en construccion ..."); RETURN
  OTHER CASE
    IF Upper(Left(gsPCata,2)) = "VN" THEN
      Info(gsPCata+" ...Proceso BUSCA en construccion ..."); RETURN
      // Fechas ...

      //Ejecuta("E",";VNXER") // prEsenta
    ELSE
      Ejecuta("E",";"+gsPCata) // prEsenta
    END
END
IF nDebug = Today() THEN Info("(superArreglo)FIND...",gsBloqueP)
IF gsBloqueP = "" THEN
  IF nDebug = Today() THEN Info("Lee archivo... cat�logo: "+gsBloqueP)
  // Lee cat�logo(tabla fisica) ... Vector AEM no esta actualizado
  ggbFlash_n = True; Ejecuta("E",";"+gsPCata) // prEsenta
END
IF nDebug = Today() THEN Info("(catalogo)FIND...",gsBloqueP)
IF gsBloqueP <> "" THEN Ejecuta("FORM","TB"); RETURN
Info("EMPL vacio ?","",ggsLog)


// gapA[1] regresa en variable enviada por BBBB
