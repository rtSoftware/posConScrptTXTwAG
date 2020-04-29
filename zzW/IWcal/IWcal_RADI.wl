//EXTERN ".\zzW\IWcal\IWcal_RADI.wl" // windows


//Ejecuta("RADI","Op_1;Op_2;Op_3;TEST~[param1]")  // [opcional]
//Ejecuta("RADI;Op_1;Op_2;Op_3")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//  Procedimiento es llamado al INICALIZAR el control (F O R M A)
//  como al SELECCIONAR algun elemento (S E L E C C I O N)
//  son 2 eventos diferentes dados en momentos del tiempo distintos
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

gnCapa = 6
{gestoyEn,indWindow}..Plane = gnCapa
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
  {sCpa1,indControl} = 0  // permite pulsar _nada
ELSE
  // S E L E C C I O N
  // Respuesta ...
  ggsRespuesta = {sCpa1,indControl}[{sCpa1,indControl}]..Caption
  ToClipboard(ggsRespuesta)

  Ejecuta("ZALI","CONCLUYE_SELECCION")  //424
END
