//EXTERN ".\zzW\Z\param_COMB.wl" // windows



{gestoyEn,indWindow}..Plane = gnCapa
sCpa1 = "COMBO_5"

// F O R M A
IF NOT ListCount({sCpa1,indControl}) THEN
  IF nDebug = Today() THEN Info("FORMA...","(num de param)gapA="+ArrayCount(gapA))
  nCBO is int
  FOR nCBO = 1 _TO_ ArrayCount(gapA)
    IF Left(Upper(gapA[nCBO]),3) IN ("CBO","COM") THEN CONTINUE
    IF Left(gapA[nCBO],1) = "*" THEN gapA[nCBO] = Right(gapA[nCBO],Length(gapA[nCBO])-1)
    IF Contains(gapA[nCBO],"~") THEN CONTINUE // param CONCLUYE
    ListAdd({sCpa1,indControl},gapA[nCBO])
  END
  // Distingue si la lista fue formada con PARAMETROS vs CODIGO
  IF ListCount({sCpa1,indControl}) > 1 THEN ListInsert(COMBO_5,"_nada",1)


  // Cuidado !
  //ListDisplay({sCpa1,indControl})  // Nunca porque es elaborada en el aire
  RETURN // >>>>>>>>>>>>>>>>>>>>>>>
END


// Asegura
IF ListCount({sCpa1,indControl}) < 1 THEN RETURN
IF {sCpa1,indControl} < 1 THEN RETURN



// S E L E C C I O N
////////////////////////////////////////////////////////
// 		en Selecting a row of COMBO_x
//IF fFileExist(".\zzW\IWcal\IWcal_COMB.wl" ) THEN
//	Ejecuta("COMB")	// parametros
//ELSE
//  Ejecuta("ABRE","COMB")	// codigo wl
//END
////////////////////////////////////////////////////////
// Respuesta ...
IF nDebug = Today() THEN Info("SELECCIONA...","num de seleccion="+{sCpa1,indControl})
ggsA = {sCpa1,indControl}[{sCpa1,indControl}]; ToClipboard(ggsA); gapA[1] = ggsA
// Deja limpio el control para ser usado nuevamente...
ListDeleteAll({sCpa1,indControl})  // Limpia contenido del control
//EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
