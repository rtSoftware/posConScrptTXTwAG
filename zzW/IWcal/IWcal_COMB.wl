//EXTERN ".\zzW\IWcal\IWcal_COMB.wl" // windows


//Ejecuta("COMB") // definicion OPCIONES --> IWcal_CBOS.wl
//Ejecuta("COMB","Op_1;Op_2;Op_3")
//Ejecuta("ABRE","COMB;Op_1;Op_2;Op_3")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//  Procedimiento es llamado al INICALIZAR el control (F O R M A)
//  como al SELECCIONAR algun elemento (S E L E C C I O N)
//  son 2 eventos diferentes dados en momentos del tiempo distintos
//
//  1er elemento debera ser "nada" o "_nada"... este ultimo indica
//  que la lista fue formada por PARAMETROS y al termino de SELECCIONAR
//  ABRE plano 1 (Calendario)
//
/////////////////////////////////////////////////////////////////////////
//Ejecuta("COMB",COMBO_1[COMBO_1])
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

{gestoyEn,indWindow}..Plane = 5 // Asegura si no entra por ABRE
sCpa1 = "COMBO_5"

// F O R M A
IF NOT ListCount({sCpa1,indControl}) THEN
  nN is int
  FOR nN = 1 _TO_ ArrayCount(gapA)
    IF Left(Upper(gapA[nN]),3) IN ("CBO","COM") THEN CONTINUE
    IF Left(gapA[nN],1) = "*" THEN gapA[nN] = Right(gapA[nN],Length(gapA[nN])-1)
    IF Contains(gapA[nN],"~") THEN CONTINUE // param CONCLUYE
    ListAdd({sCpa1,indControl},gapA[nN])
  END
  // Distingue si la lista fue formada con PARAMETROS vs CODIGO
  IF ListCount({sCpa1,indControl}) > 1 THEN ListInsert(COMBO_5,"_nada",1)

  ////////////////////////////////////////////////////////////////////////
  // Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
  //                        Ejecuta("CBOS")
  ////////////////////////////////////////////////////////////////////////
  //ListAdd({sCpa1,indControl},"Opcion 1")
  //ListAdd({sCpa1,indControl},"Opcion 2")

  //ListAdd({sCpa1,indControl},"Opcion n")


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
ggsA = {sCpa1,indControl}[{sCpa1,indControl}]; ToClipboard(ggsA); gapA[1] = ggsA
// Deja limpio el control para ser usado nuevamente...
ListDeleteAll({sCpa1,indControl})  // Limpia contenido del control

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
