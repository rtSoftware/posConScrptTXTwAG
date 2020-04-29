//EXTERN ".\zzW\IWcal\IWcal_CHEC.wl" // windows


//Ejecuta("CHEC;Op_1;Op_2;Op_3;TEST~")
//Ejecuta("CHEC","Op_1;Op_2;Op_3")
//Ejecuta("CHEC") <-- BTN_OK
/////////////////////////////////////////////////////////////////////////
// Flujo:
//  Procedimiento llamado   Ejecuta("ABRIR","CHEC;a:b:c")
//      ...Parametros  (F O R M A)  Codigo...  Ejecuta("CHEC")
//
//  luego al SELECCIONAR los elementos (S E L E C C I O N)
//  son 2 eventos diferentes dados en momentos del tiempo distintos
//
//  Respuesta se guarda en ggsA , clipboard y en gapA[1] no hay manera de saber
//  si la lista fue formada por PARAMETROS y o por CODIGO en este WL
//  Esto sucede al pulsar [OK] ABRE plano 1 (Calendario) si no fue
//  definida CONCLUYE Ejecuta("ABRIR","CHEC;a;b;c;ABRE~CALENDARIO")
//
/////////////////////////////////////////////////////////////////////////
//Ejecuta("CHEC")
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"


{gestoyEn,indWindow}..Plane = 7
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
