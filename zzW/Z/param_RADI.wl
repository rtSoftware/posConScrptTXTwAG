//EXTERN ".\zzW\Z\param_RADI.wl" // windows



//Ejecuta("ABRE","RADI;Op_1;Op_2;Op_3")

{gestoyEn,indWindow}..Plane = gnCapa
sCpa1 = "RADIO_1"

// F O R M A
IF {sCpa1,indControl}[1]..Caption = "Option 1" AND ArrayCount(gapA) > 0 THEN
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
    RadioButtonAdd({sCpa1,indControl},gapA[nRAD])
  END
ELSE
  IF {sCpa1,indControl}[1]..Caption = "Option 1" THEN Error("X CHECK (2003041635) parametros aucentes..."); RETURN

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
  //EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
END
