//EXTERN ".\zzW\IWcal\IWcal_CHEC.wl" // windows


//Ejecuta("CHEC") // definicion OPCIONES --> IWcal_CHEC.wl
//Ejecuta("CHEC","Op_1;Op_2;Op_3")
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

// F O R M A
IF {sCpa1,indControl}[1]..Caption = "Option 1" THEN
  //      Elimina Checks actuales
  WHILE CheckBoxCount({sCpa1,indControl}) > 1
    CheckBoxDelete({sCpa1,indControl},CheckBoxCount({sCpa1,indControl}))
  END
  IF CheckBoxCount({sCpa1,indControl}) = 0 THEN CheckBoxAdd({sCpa1,indControl},"") // sobra ?

  IF ArrayCount(gapA) > 0 THEN
    // P A R A M E T R O S    Ejecuta("CHEC","a;e;i")   Ejecuta("ABRE","CHEC","CHEC;a;e;i")
    // Forma 1er elemento
    {sCpa1,indControl}[1]..Caption = gapA[1]
    nN is int
    FOR nN = 2 _TO_ ArrayCount(gapA)
      IF Left(Upper(gapA[nN]),3) = "CHE" THEN CONTINUE
      IF Left(gapA[nN],1) = "*" THEN gapA[nN] = Right(gapA[nN],Length(gapA[nN])-1)
      IF Contains(gapA[nN],"~") THEN CONTINUE // param CONCLUYE
      CheckBoxAdd({sCpa1,indControl},gapA[nN])
    END
  ELSE
    // C O D I G O      Ejecuta("CHEC")
    ////////////////////////////////////////////////////////////////////////
    // Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
    //                        Ejecuta("CBOS")
    ////////////////////////////////////////////////////////////////////////
    {sCpa1,indControl}[1]..Caption = "nada"  // 1er elemento
    //CheckBoxAdd({sCpa1,indControl},"Opcion_1")
    //CheckBoxAdd({sCpa1,indControl},"Opcion_2")

    //CheckBoxAdd({sCpa1,indControl},"Opcion_n")
  END


  {sCpa1,indControl} = 1 // cursor en el primer elemento
  RETURN
END



// S E L E C C I O N
////////////////////////////////////////////////////////
// 		en BTN_xxx
//IF fFileExist(".\zzW\IWcal\IWcal_CHEC.wl" ) THEN
//	Ejecuta("CHEC")	// codigo wl
//ELSE
//	Ejecuta("ABRE","CHEC")
//END
////////////////////////////////////////////////////////
ggsA = ""
nN is int
FOR nN = 1 _TO_ CheckBoxCount({sCpa1,indControl})
  IF {sCpa1,indControl}[nN] THEN
    ggsA = ggsA + {sCpa1,indControl}[nN]..Caption + ";"
  END

  //Info({sCpa1,indControl}[nN]..Caption,{sCpa1,indControl}[nN],{sCpa1,indControl}[nN]..Value,ggsA)
END
IF ggsA <> "" THEN ggsA = Left(ggsA,Length(ggsA)-1)

// Respuesta
ToClipboard(ggsA); gapA[1] = ggsA
// Deja limpio el control para ser usado nuevamente...
{sCpa1,indControl}[1]..Caption = "Option 1"
//EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
