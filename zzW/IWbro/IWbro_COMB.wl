//EXTERN ".\zzW\IWbro\IWbro_COMB.wl" // windows


//Ejecuta("COMB","Op_1;Op_2;Op_3;TEST~")    // FORMA
//Ejecuta("COMB;Op_1;Op_2;Op_3")
//Ejecuta("COMB")                     // SELECCIONA
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

gnCapa = 5
{gestoyEn,indWindow}..Plane = gnCapa
sCpa1 = "COMBO_5"

IF nDebug = Today() THEN Info("FORMA/SELECCIONA...","(num de param)gapA="+ArrayCount(gapA),"Lista="+ListCount({sCpa1,indControl}),"gapA[2]="+gapA[2])

// F O R M A  // Ejecuta("COMB","Op1;Op2;OpN")	// con parametros
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
  //IF ListCount({sCpa1,indControl}) > 1 THEN ListInsert(COMBO_5,"_nada",1)

  // Cuidado !
  //ListDisplay({sCpa1,indControl})  // Nunca porque es elaborada en el aire
  RETURN // >>>>>>>>>>>>>>>>>>>>>>>
END


// Asegura
IF ListCount({sCpa1,indControl}) < 1 THEN RETURN
IF {sCpa1,indControl} < 1 THEN RETURN   // sobra ?



// S E L E C C I O N //	  Ejecuta("COMB")	// sin parametros
// Respuesta ...
IF nDebug = Today() THEN Info("SELECCIONA...","num de seleccion="+{sCpa1,indControl})
ggsA = {sCpa1,indControl}[{sCpa1,indControl}]; ToClipboard(ggsA); gapA[1] = ggsA
ggsRespuesta = ggsA
IF nDebug = Today() THEN Info("Respuesta="+ggsRespuesta,"Tambien en Clipboard y en ggsA")

// Deja limpio el control para ser usado nuevamente...
//ListDeleteAll({sCpa1,indControl})  // Limpia contenido del control  (sobra)

Ejecuta("ZALI","CONCLUYE_SELECCION")  //424
