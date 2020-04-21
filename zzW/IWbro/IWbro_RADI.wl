//EXTERN ".\zzW\IWbro\IWbro_RADI.wl" // windows



//Ejecuta("RADI") // definicion OPCIONES --> IWcal_CBOS.wl
//Ejecuta("RADI","Op_1;Op_2;Op_3")
//Ejecuta("ABRE","RADI;Op_1;Op_2;Op_3")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//  Procedimiento es llamado en   Ejecuta("ABRIR";"CHEC")   (F O R M A)
//  luego al SELECCIONAR alguno de sus elemento (S E L E C C I O N)
//  son 2 eventos diferentes dados en momentos del tiempo distintos
//
//  1er elemento debera ser "nada" o "_nada"... este ultimo indica
//  que la lista fue formada por PARAMETROS y al termino de SELECCIONAR
//  ABRE plano 1 (Calendario)
//
/////////////////////////////////////////////////////////////////////////
//Ejecuta("RADI")     Ejecuta("RADI",RADIO_1[RADIO_1]..Caption)
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"


{gestoyEn,indWindow}..Plane = 6
sCpa1 = "RADIO_1"

// F O R M A
IF {sCpa1,indControl}[1]..Caption = "Option 1" THEN
  //      Elimina Radio Botones actuales
  // (control RADIO debe tener minimo 1 elemento)
  nN is int
  FOR nN = RadioButtonCount({sCpa1,indControl}) _TO_ 2 STEP -1
    RadioButtonDelete({sCpa1,indControl},nN)
  END

  IF ArrayCount(gapA) > 0 THEN
    // Forma 1er elemento
    {sCpa1,indControl}[1]..Caption = "_nada"
    nNR is int
    FOR nNR = 1 _TO_ ArrayCount(gapA)
      IF Left(Upper(gapA[nNR]),3) = "RAD" THEN CONTINUE
      IF Left(gapA[nNR],1) = "*" THEN gapA[nNR] = Right(gapA[nNR],Length(gapA[nNR])-1)
      IF Contains(gapA[nNR],"~") THEN CONTINUE // param CONCLUYE
      RadioButtonAdd({sCpa1,indControl},gapA[nNR])
    END
  ELSE
    ////////////////////////////////////////////////////////////////////////
    // Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
    //                        Ejecuta("CBOS")
    ////////////////////////////////////////////////////////////////////////
    {sCpa1,indControl}[1]..Caption = "nada"  // 1er elemento
    //RadioButtonAdd({sCpa1,indControl},"Opcion 1")
    //RadioButtonAdd({sCpa1,indControl},"Opcion 2")

    //RadioButtonAdd({sCpa1,indControl},"Opcion n")
  END
  {sCpa1,indControl} = 1 // cursor en el primer elemento (nada)
  RETURN
END



// S E L E C C I O N
////////////////////////////////////////////////////////
//IF fFileExist(".\zzW\IWcal\IWcal_RADI.wl" ) THEN
//	Ejecuta("RADI")	// codigo wl
//ELSE
//	Ejecuta("ABRE","RADI")
//END
////////////////////////////////////////////////////////
// Respuesta ...
ggsA = {sCpa1,indControl}[{sCpa1,indControl}]..Caption; ToClipboard(ggsA); gapA[1] = ggsA
// Deja limpio el control para ser usado nuevamente...
{sCpa1,indControl}[1]..Caption = "Option 1" // Importante

// Funcionalidad extendida (solo codigo, imposible en modo parametros)
SWITCH ggsA
	CASE "","nada": RETURN

////////////////////////////////////////////////////////////////////////
// Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
//                        Ejecuta("CBOS")
////////////////////////////////////////////////////////////////////////
  //CASE "Opcion 1"
  //CASE "Opcion 2"


	//OTHER CASE: Error("X no definida ggsAcion "+ggsA); RETURN
END
//EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
