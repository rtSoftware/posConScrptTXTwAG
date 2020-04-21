//EXTERN ".\zzW\IW220\IW220_ENTER.wl"

//Ejecuta("ENTER", SKU;7501234561234;2)
//Ejecuta("ENTER", LOGIN;1001;1234)
//Ejecuta("ENTER", LOGIN;,g)

// Ejecuta("XXX_EDT")  // sin prefijo   "XXX_xxxx"    es codigo base
/////////////////////////////////////////////////////////////////////////
// Flujo:   BTN_<0..1> --> EDT_Captura / EDT_Usuario (ciclo)
//            BTN_E --> ENTER --> FIND --> FORM (INI)     // login
//            BTN_E --> ENTER --> FIND --> FORM (Recibo)  // sku
//            BTN_P --> ENTER --> FIND --> FORM (kata)    // pago
//            BTN_C --> ABRE  (cancela)
//          MJES --> IWxxx_ZALI   (muy variado)
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// Valida ...
IF Upper(gapA[1]) NOT IN("LOGIN","SKU","PAGO")  THEN gapA[1] = ""
IF gapA[1] = "" THEN
  Error("X parametro CAPA aucente/erroneo en "+sCompilaTXT)
  SWITCH {gestoyEn,indWindow}..Plane
    CASE gnCapaLogin: gapA[1] = "LOGIN"
    CASE 5,gnCapaSku: gapA[1] = "SKU"
    CASE gnCapaPago: gapA[1] = "PAGO"
    OTHER CASE: Error("X no definida Tarea en "+sCompilaTXT); EndProgram()
  END
END

sCpa1 = gapA[1]+";"+gapA[2]+";"+gapA[3] // parametros ENVIA <-- respuesta
//Info("(IW220_ENTER)sCpa1="+sCpa1)

IF gapA[1] = "LOGIN" THEN
  // login (capa)

  IF nDebug = Today() THEN Info("(IW220_ENTER)gapA[2]="+gapA[2])
  // Comandos Administrador  >>>>> ,TEST <<<<<<
  IF Left(gapA[2],1) = "," THEN
    sCpa1 = Upper(Right(gapA[2],Length(gapA[2])-1)) // tarea en CALC
    //EXTERN ".\zzW\V\COMANDOS_Ejecuta.wl"
    Ejecuta("COMANDO",sCpa1)
    Ejecuta("ABRE",gapA[1]) // login
    //RETURN // sobra por ReturnToCapture(EDT_1) en XXX_ABRE
  END

  // Busca Usuario digitado... //0219
  IF gapA[2] = "" OR gapA[3] = "" THEN Error("200218731"); RETURN
  IF nDebug = Today() THEN Info("busca...","",sCpa1)
  Ejecuta("FIND",sCpa1) // LOGIN;usuario;clave
  ggsSoy = "" // Asegura

  IF nDebug = Today() THEN Info("empleado...","",ggsRespuesta) // Code,Descricion,Correo
  IF ggsRespuesta <> "" THEN
    // Valida respuesta ...
    IF ggsRespuesta <> "X" THEN Ejecuta("FORM","LOGIN;"+ggsRespuesta)  // --> ggsSoy, INI: nombre, correo...
  END
  IF ggsSoy <> "" THEN
    Ejecuta("ABRE","SKU;Bienvenido "+ggsSoyNombre+";;;")
  ELSE
    // re-Abre la capa 2 de este witget
    Error("Acceso Denegado")
    Ejecuta("ABRE","LOGIN") // ggsSoy <> "" --> nivel TX
  END

ELSE IF gapA[1] = "SKU"
  // sku (capa)
  EDT_Captura = "" // ya viene integrada en sCpa1

  // Busca sku escaneado ... //0219
  IF gapA[2] = "" THEN Error("200218733"); RETURN
  Ejecuta("FIND",sCpa1) // SKU;7501234561234

  IF nDebug = Today() THEN Info("producto...","",ggsRespuesta) // Sku,Descripcion,Precio...
  IF ggsRespuesta <> "" THEN
    // Valida respuesta ... (registro para formar recibo)
    //IF ggsRespuesta <> "X" THEN Error("Codigo inexistente...")
  END

  Ejecuta("ABRE","SKU;Escan SKU...")  //0219
ELSE
  Error(gapA[1]+" es una capa inexistente en "+sCompilaTXT); Close()
END
