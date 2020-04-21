//EXTERN ".\zzW\IW220\IW220_ABRE.wl"

//Ejecuta("XXX_ABRE")
// Ejecuta("ABRE")  // sin prefijo   "XXX_xxxx"    es codigo base
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

//IF gapA[1] = "" <-- correcto... ggsSoy controla el flujo

// Asegura //0219
IF gapA[1] = "" THEN gapA[1] = "LOGIN"; {gestoyEn,indWindow}..Plane = gnCapaLogin
IF ggsSoy = "" THEN gapA[1] = "LOGIN"; {gestoyEn,indWindow}..Plane = gnCapaLogin

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

// ggsSoy <-- USUARIO
IF Upper(gapA[1]) = "LOGIN" THEN  /////////////////////////////////////////////
  // LogIn

  // Limpia ...
  ggbAdmin = False
  EDT_Usuario = ""; EDT_Pin = "" //; EDT_Pin..Visible = False

  HDeleteAll(Recibo)
  Ejecuta("LOOPER_RECIBO") // vacio en Ejecuta(gapE[1],gapA[1],pN) cuando no aplica

  INIWrite("EMPL","Usuario",ggsSoy,ggsIni)
  INIWrite("EMPL","Nombre","",ggsIni)
  INIWrite("EMPL","Codigo","",ggsIni)
  INIWrite ("EMPL","Celular","",ggsIni)
  ggsSoy = "" // Asegura

  // Forma super arreglo AEM <-- EMPL (empleados)
  IF NOT ArrayCount(AEM) THEN Ejecuta("F","AXX_AEM") //;CIA:BX,DB:HIF,DB4:K2"")
  IF nDebug = Today() THEN Info("AEM="+ArrayCount(AEM))
  IF ArrayCount(AEM) = 0 THEN Error("Imposible continuar sin AEM (IW220_ABRE)") //; Close()

  Ejecuta("MJES","LOGIN")

  // Cursor
  SHA_1..BrushColor = LightGray
  GR_teclado..Visible = True
  ReturnToCapture(EDT_Usuario)

ELSE IF Upper(gapA[1]) = "PAGO" /////////////////////////////////////////////
  //0219
  IF gnCapaPago > 0 THEN
    {gestoyEn,indWindow}..Plane = gnCapaPago
    Ejecuta("CALC")
    Ejecuta("MJES_PAGO")
  ELSE
    //Ejecuta("ABRE_PAGO_EXTERNO")  // ventana hermana
    // Asigna TOTAL e Efectivo...
    Ejecuta("ZALI","PAGO") // Aplica el pago ...
  END
ELSE IF Upper(gapA[1]) = "SKU"  /////////////////////////////////////////////

  // Sku

  // Limpia ...
  ggbAdmin = False
  EDT_Captura = ""

  // Verifica en configuracion ... 0221
  IF INIRead("cfg","Tableta_YN","N",ggsIni) <> "N" THEN bCpa1 = True
  IF bCpa1 THEN COMBO_productos..Visible = True

  // Forma super arreglo AIN <-- INVE (productos)
  IF NOT ArrayCount(AIN) THEN Ejecuta("F","AXX_AIN") //;CIA:BX,DB:HIF,DB4:K2"")
  IF nDebug = Today() THEN Info("AIN="+ArrayCount(AIN))
  IF ArrayCount(AIN) = 0 THEN Error("Imposible continuar sin AIN"); Close()

  // Forma complemento (solo si inventario no es muy grande)
  ArrayDeleteAll(garCi); ArrayDeleteAll(garDi)
  ArrayDeleteAll(garV1i); ArrayDeleteAll(garV2i)
  ArrayDeleteAll(garcci); ArrayDeleteAll(garffi)
  FOR nCpa1 = 1 TO ArrayCount(AIN)
    IF AIN[nCpa1]:descripcion = "" THEN CONTINUE //0201

    // Code,Descripcion,Precio,Costo ...
    ArrayAdd(garCi,Right("000000000000" + AIN[nCpa1]:codigo,13))
    ArrayAdd(garDi,AIN[nCpa1]:descripcion)
    ArrayAdd(garV1i,AIN[nCpa1]:val1); ArrayAdd(garV2i,AIN[nCpa1]:val2)
    ArrayAdd(garcci,AIN[nCpa1]:c) 	// categoria
    ArrayAdd(garffi,AIN[nCpa1]:f)	// caducidad

    IF bCpa1 THEN ListAdd(COMBO_productos,AIN[nCpa1]:descripcion) // forma 0221
  END
  IF nDebug = Today() THEN Info(ArrayCount(AIN))

  Ejecuta("MJES","SKU;Escan Sku")

  // Cursor
  SHA_1..BrushColor = LightBlue
  GR_teclado..Visible = False
  ReturnToCapture(EDT_Captura)
END
