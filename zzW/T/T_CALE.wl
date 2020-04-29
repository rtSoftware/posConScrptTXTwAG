//EXTERN ".\zzW\T\T_CALE.wl" // windows



//Ejecuta("CAL_M"[,"param"])
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

SWITCH gapE[1]
  CASE "CALE_A"
    MySelf..Plane = 1

  CASE "CALE_M",""
    MySelf..Plane = 3
    WIN_T..Width = 505; WIN_T..Height = 315

  CASE "CALE_R"
    MySelf..Plane = 2
    WIN_T..Width = 740; WIN_T..Height = 315

  CASE "TRAC","TRAK"
    MySelf..Plane = 4

  CASE "TODO_M","TODO_S","TODO_D" ,"TODO_W"
    MySelf..Plane = 5
    IF gapE[1] = "TODO_D" THEN OrganizerChangeMode(ORG_5, orgzDay)
    IF gapE[1] = "TODO_W" OR gapE[1] = "TODO_S" THEN OrganizerChangeMode(ORG_5, orgzWeek)
    IF gapE[1] = "TODO_M" THEN OrganizerChangeMode(ORG_5, orgzMonth)

  CASE "PLAN"
    MySelf..Plane = 6

  CASE "GANT"
    MySelf..Plane = 7

  CASE "GANTT"
    MySelf..Plane = 8

  CASE "VIDE"
    MySelf..Plane = 9

  CASE "COMB"
    MySelf..Plane = 10
    WIN_T..Width = 305; WIN_T..Height = 235

    sCpa1 = "COMBO_1"

    IF nDebug = Today() THEN Info("FORMA/SELECCIONA...","(num de param)gapA="+ArrayCount(gapA),"Lista="+ListCount({sCpa1,indControl}),"gapA[2]="+gapA[2])

    // F O R M A  // Ejecuta("COMB","Op1;Op2;OpN")	// con parametros

    // Lista en un TXT...
    IF gapA[1] <> "" AND gapA[2] = "" AND fFileExist(gapA[1]) THEN
      StringToArray(fLoadText(gapA[1]),gapA)
    END

    // Mas de un parametro FORMA, uno Selecciona
    IF gapA[2] <> "" THEN
      ListDeleteAll({sCpa1,indControl})  // Limpia contenido del control
      nCBO is int
      FOR nCBO = 1 _TO_ ArrayCount(gapA)
        IF Left(Upper(gapA[nCBO]),3) IN ("CBO","COM") THEN CONTINUE
        IF Left(gapA[nCBO],1) = "*" THEN gapA[nCBO] = Right(gapA[nCBO],Length(gapA[nCBO])-1)
        IF Contains(gapA[nCBO],"~") THEN CONTINUE // param CONCLUYE
        IF gapA[nCBO] <> "" THEN ListAdd({sCpa1,indControl},gapA[nCBO])
      END
      //IF ListCount({sCpa1,indControl}) > 1 THEN ListInsert({sCpa1,indControl},"_nada",1)
      //ListDisplay({sCpa1,indControl})  // Nunca! es elaborada en el aire
      RETURN // >>>>>>>>>>>>>>>>>>>>>>>
    END


    // Asegura
    IF ListCount({sCpa1,indControl}) < 1 THEN Error("Nada que seleccionar..."); Close()
    IF {sCpa1,indControl} < 1 THEN RETURN   // sobra ?



    // S E L E C C I O N //	  Ejecuta("COMB")	// sin parametros
    // Respuesta ...
    IF nDebug = Today() THEN Info("SELECCIONA...","num de seleccion="+{sCpa1,indControl})
    ggsA = {sCpa1,indControl}[{sCpa1,indControl}]; ToClipboard(ggsA); gapA[1] = ggsA
    ggsRespuesta = ggsA
    IF nDebug = Today() THEN Info("Respuesta="+ggsRespuesta,"Tambien en Clipboard y en ggsA")

    CLOSE() //Ejecuta("ZALI","CONCLUYE_SELECCION")  //424
  CASE "CHEC","CHEK"
    MySelf..Plane = 12
    WIN_T..Width = 270; WIN_T..Height = 560

    sCpa1 = "CBOX_1"

    IF nDebug = Today() THEN Info("FORMA/SELECCIONA...","(num de param)gapA="+ArrayCount(gapA),"gapA[2]="+gapA[2])

    // F O R M A
    // Mas de un parametro FORMA, uno Selecciona
    IF gapA[2] <> "" THEN
      //      Elimina Checks actuales
      WHILE CheckBoxCount({sCpa1,indControl}) > 1
        CheckBoxDelete({sCpa1,indControl},CheckBoxCount({sCpa1,indControl}))
      END
      IF CheckBoxCount({sCpa1,indControl}) = 0 THEN CheckBoxAdd({sCpa1,indControl},"") // sobra ?

      // P A R A M E T R O S    Ejecuta("CHEC","a;e;i")   Ejecuta("ABRE","CHEC","CHEC;a;e;i")
      // Forma 1er elemento
      {sCpa1,indControl}[1]..Caption = gapA[1]
      nCHE is int
      FOR nCHE = 2 _TO_ ArrayCount(gapA)
        IF nDebug = Today() THEN Info(nCHE , gapA[nCHE] ,"", gapA[2],CheckBoxCount({sCpa1,indControl}) )
        IF Left(Upper(gapA[nCHE]),3) = "CHE" THEN CONTINUE
        IF Left(gapA[nCHE],1) = "*" THEN gapA[nCHE] = Right(gapA[nCHE],Length(gapA[nCHE])-1)
        IF Contains(gapA[nCHE],"~") THEN CONTINUE // param CONCLUYE
        IF gapA[nCHE] <> "" CheckBoxAdd({sCpa1,indControl},gapA[nCHE])
      END

      {sCpa1,indControl} = 1 // cursor en el primer elemento
      RETURN
    ELSE
      // S E L E C C I O N //	Ejecuta("CHEC")	// codigo wl
      Info(CheckBoxCount({sCpa1,indControl}),sCpa1,CheckBoxCount(CBOX_1))

      ggsRespuesta = ""
      nCHE1 is int
      FOR nCHE1 = 1 _TO_ CheckBoxCount({sCpa1,indControl})
        IF nDebug = Today() THEN Info(sCpa1,"",{sCpa1,indControl}[nCHE1],{sCpa1,indControl}[nCHE1]..Caption)
        IF {sCpa1,indControl}[nCHE1] THEN
          ggsRespuesta = ggsRespuesta + {sCpa1,indControl}[nCHE1]..Caption + ";"
        END

        IF nDebug = Today() THEN Info({sCpa1,indControl}[nCHE1]..Caption,{sCpa1,indControl}[nCHE1],{sCpa1,indControl}[nCHE1]..Value,ggsA)
      END
      IF ggsRespuesta <> "" THEN ggsRespuesta = Left(ggsRespuesta,Length(ggsRespuesta)-1)
      ToClipboard(ggsRespuesta)

      Ejecuta("ZALI","CONCLUYE_SELECCION")  //424
    END
  CASE "RADI"
    MySelf..Plane = 11
    WIN_T..Width = 270; WIN_T..Height = 560

    sCpa1 = "RADIO_1"

    IF nDebug = Today() THEN Info("FORMA/SELECCIONA...","(num de param)gapA="+ArrayCount(gapA),"gapA[2]="+gapA[2])

    IF gapA[2] <> "" THEN
      // F O R M A
      // Mas de un parametro FORMA, uno Selecciona

      //      Elimina Radio Botones actuales
      // (control RADIO debe tener minimo 1 elemento)
      nRAD is int
      FOR nRAD = RadioButtonCount({sCpa1,indControl}) _TO_ 2 STEP -1
        RadioButtonDelete({sCpa1,indControl},nRAD)
      END

      // Forma 1er elemento
      {sCpa1,indControl}[1]..Caption = "_nada"
      FOR nRAD = 1 _TO_ ArrayCount(gapA)
        IF Left(Upper(gapA[nRAD]),3) = "RAD" THEN CONTINUE
        IF Left(gapA[nRAD],1) = "*" THEN gapA[nRAD] = Right(gapA[nRAD],Length(gapA[nRAD])-1)
        IF Contains(gapA[nRAD],"~") THEN CONTINUE // param CONCLUYE
        IF gapA[nRAD] <> "" THEN RadioButtonAdd({sCpa1,indControl},gapA[nRAD])
      END
    ELSE
      // S E L E C C I O N
      // Respuesta ...
      ggsRespuesta = {sCpa1,indControl}[{sCpa1,indControl}]..Caption
      ToClipboard(ggsRespuesta)

      CLOSE() //EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
    END
  CASE "AVISO","AVIS"
    MySelf..Plane = 13
    WIN_T..Width = 430; WIN_T..Height = 470
    EDT_AVISO = gapA[1]; EDT_AvisoContesta = ""
  CASE "WORD"
    MySelf..Plane = 14

  CASE "HOCA","HOJA"
    MySelf..Plane = 15

  CASE "ARBO","ARBOL","TREE"
    MySelf..Plane = 16
    WIN_T..Width = 550

  CASE "TABL","TABLA","TABLA_Q"
    MySelf..Plane = 17

    // Nombre Tabla...
    sNombre,sCamino,sSentencia is string
    IF gapA[1] <> ""
      IF gapA[1] = "?" THEN
        gapA[1] = fSelect("","", "Selecciona Archivo...", ...
        "Archivo FIC" + TAB + "*.FIC" + CR + "TODOS (*.*)" + TAB + "*.*","FIC")

        IF gapA[1] = "" THEN CLOSE()

        // Separar nombre de path...
        sNombre = fExtractPath(gapA[1], fFileName)
        sCamino = fExtractPath(gapA[1], fDirectory)
        //sDrive = fExtractPath(gapA[1], fDrive)
      ELSE
        sNombre = gapA[1]
      END // selecciona archivo...

      VWE is Data Source
      // lWe    ahora se va a llamar:    gapA[1]
      // VWE hereda estructura lWe
      HAlias(lWe,VWE); HChangeName(VWE,sNombre)
      IF sCamino <> "" THEN HChangeDir(VWE,sCamino)
    ELSE
        Error("No definidad nombre de la tabla FIC a desplegar (use: TABLA ?)..."); CLOSE()
    END // Nombre Tabla

    // Sentencia SQL...
    IF gapA[2] <> "" THEN
      // Ejecuta("TABLA_Q" , "?")
      IF gapA[2] = "?" THEN
        ggsA = "SELECT * FROM VWE WHERE "
        Input("Sentencia SQL... " , ggsA)
        IF ggsA <> "" THEN gapA[2] = ggsA
      END
      // Ejecuta("TABLA_Q" , "SELECT * FROM VWE","SELECT * FROM VWE WHERE codigo='1001'")
      HExecuteSQLQuery(QRY_lWe,hQueryDefault,gapA[2])
    ELSE
      // Presenta todo la tabla ...     gapA[2] = VACIA
      HExecuteSQLQuery(QRY_lWe,hQueryDefault,"SELECT * FROM VWE")
    END
    TableDisplay(TABLE_QRY_lWe)
  CASE "LIST","LISTA"
    MySelf..Plane = 18
    WIN_T..Width = 310; WIN_T..Height = 310
    sCpa1 = "LIST_1"

    IF nDebug = Today() THEN Info("FORMA/SELECCIONA...","(num de param)gapA="+ArrayCount(gapA),"Lista="+ListCount({sCpa1,indControl}),"gapA[2]="+gapA[2])

    // F O R M A  // Ejecuta("COMB","Op1;Op2;OpN")	// con parametros

    // Lista en un TXT...
    IF gapA[1] <> "" AND gapA[2] = "" AND fFileExist(gapA[1]) THEN
      StringToArray(fLoadText(gapA[1]),gapA)
    END

    // Mas de un parametro FORMA, uno Selecciona
    IF gapA[2] <> "" THEN
      ListDeleteAll({sCpa1,indControl})  // Limpia contenido del control
      ListAdd({sCpa1,indControl},"Selecionar:")
      nCBO is int
      FOR nCBO = 1 _TO_ ArrayCount(gapA)
        IF Left(Upper(gapA[nCBO]),3) IN ("CBO","COM","LIS") THEN CONTINUE
        IF Left(gapA[nCBO],1) = "*" THEN gapA[nCBO] = Right(gapA[nCBO],Length(gapA[nCBO])-1)
        IF Contains(gapA[nCBO],"~") THEN CONTINUE // param CONCLUYE
        IF gapA[nCBO] <> "" THEN ListAdd({sCpa1,indControl},gapA[nCBO])
      END
      //IF ListCount({sCpa1,indControl}) > 1 THEN ListInsert({sCpa1,indControl},"Selecionar:",1)
      //ListDisplay({sCpa1,indControl})  // Nunca ! es elaborada en el aire
      RETURN // >>>>>>>>>>>>>>>>>>>>>>>
    END


    // Asegura
    IF ListCount({sCpa1,indControl}) < 1 THEN Error("Nada que seleccionar..."); Close()
    IF {sCpa1,indControl} < 1 THEN RETURN   // sobra ?



    // S E L E C C I O N //	  Ejecuta("COMB")	// sin parametros
    // Respuesta ...
    IF nDebug = Today() THEN Info("SELECCIONA...","num de seleccion="+{sCpa1,indControl})
    ggsA = {sCpa1,indControl}[{sCpa1,indControl}]; ToClipboard(ggsA); gapA[1] = ggsA
    ggsRespuesta = ggsA
    IF nDebug = Today() THEN Info("Respuesta="+ggsRespuesta,"Tambien en Clipboard y en ggsA")

    CLOSE() //Ejecuta("ZALI","CONCLUYE_SELECCION")  //424
  CASE "FOTO"
    MySelf..Plane = 19

    IF gapA[1] = "?" THEN
      gapA[1] =  fSelectDir("", "Seleccione una carpeta con imagenes", ...
                    "Carpeta a desplegar")
      IF gapA[1] = "" THEN CLOSE() ELSE gapA[1] = gapA[1] + [fsep] + "*.*"
    ELSE
      gapA[1] = "./IMAGENES/*.*"
    END // selecciona archivo...

    gsBloqueP = fListFile(gapA[1])
    FOR EACH STRING AFile OF gsBloqueP SEPARATED BY CR
      ggnX++ //
      ListAdd(LSV_1,fExtractPath(AFile,fFileName),AFile)
    END


  CASE "XXXX"
    MySelf..Plane = 18
    WIN_T..Width = 270; WIN_T..Height = 560
	OTHER CASE: Error(gapE[1]+" No definido ("+gestoyEn+" - 324 8923)"); CLOSE()
END
