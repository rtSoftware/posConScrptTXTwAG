//EXTERN ".\zzW\IWcfg\IWcfg_COMB.wl" // windows


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

// -------------------------------------------------------------------------
{gestoyEn,indWindow}..Plane = 5   // Asegura si no entra por ABRE
sCpa1 = "COMBO_1"; bCpa1 = False  // Limpia control despues de seleccion
// -------------------------------------------------------------------------

// F O R M A
IF NOT ListCount({sCpa1,indControl}) THEN
  IF nDebug = Today() THEN Info("FORMA...","(num de param)gapA="+ArrayCount(gapA))
  nN is int
  FOR nN = 1 _TO_ ArrayCount(gapA)
    IF Left(Upper(gapA[nN]),3) IN ("CBO","COM") THEN CONTINUE
    IF Left(gapA[nN],1) = "*" THEN gapA[nN] = Right(gapA[nN],Length(gapA[nN])-1)
    IF Contains(gapA[nN],"~") THEN CONTINUE // param CONCLUYE
    ListAdd({sCpa1,indControl},gapA[nN])
  END
  // Distingue si la lista fue formada con PARAMETROS vs CODIGO
  //IF ListCount({sCpa1,indControl}) > 1 THEN ListInsert({sCpa1,indControl},"_nada",1)

  ////////////////////////////////////////////////////////////////////////
  // Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
  //                        Ejecuta("CBOS")
  ////////////////////////////////////////////////////////////////////////
  ListAdd({sCpa1,indControl},"nada")
  ListAdd({sCpa1,indControl},"+Browser")
  ListAdd({sCpa1,indControl},"-Browser")
  ListAdd({sCpa1,indControl},"+Calendario")
  ListAdd({sCpa1,indControl},"-Calendario")
  ListAdd({sCpa1,indControl},"+Captura")
  ListAdd({sCpa1,indControl},"-Captura")
  ListAdd({sCpa1,indControl},"+Configura")
  ListAdd({sCpa1,indControl},"-Configura")
  ListAdd({sCpa1,indControl},"+Escan")
  ListAdd({sCpa1,indControl},"-Escan")
  ListAdd({sCpa1,indControl},"+Grafica")
  ListAdd({sCpa1,indControl},"-Grafica")
  ListAdd({sCpa1,indControl},"+Internet")
  ListAdd({sCpa1,indControl},"-Internet")
  ListAdd({sCpa1,indControl},"+LogIN")
  ListAdd({sCpa1,indControl},"-LogIN")
  ListAdd({sCpa1,indControl},"+Recibo")
  ListAdd({sCpa1,indControl},"-Recibo")
  ListAdd({sCpa1,indControl},"+Titula")
  ListAdd({sCpa1,indControl},"-Titula")

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
IF bCpa1 THEN ListDeleteAll({sCpa1,indControl})  // Limpia contenido del control

// -------------------- particular --------------------
IF ggsDash_Nombre = "" THEN ggsDash_Nombre = INIRead("cfg","DASH","DASH_1",ggsIni)
// -------------------- particular --------------------

// Funcionalidad extendida (solo codigo, imposible en modo parametros)
SWITCH ggsA
	CASE "","nada": RETURN

////////////////////////////////////////////////////////////////////////
// Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
//                        Ejecuta("CBOS")
////////////////////////////////////////////////////////////////////////
  CASE "+Browser": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_browser,"IW_browser")
  CASE "-Browser": sCpa3 = "IW_browser"

  CASE "+Calendario": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_calendario,"IW_calendario")
  CASE "-Calendario": sCpa3 = "IW_calendario"

  CASE "+Captura": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_captura,"IW_captura")
  CASE "-Captura": sCpa3 = "IW_captura"

  CASE "+Configura": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_cfg,"IW_cfg")
  CASE "-Configura": sCpa3 = "IW_cfg"

  CASE "+Escan": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_escan,"IW_escan","ABRE","LOGIN")
  CASE "-Escan": sCpa3 = "IW_escan"

  CASE "+Grafica": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_grafica,"IW_grafica")
  CASE "-Grafica": sCpa3 = "IW_grafica"

  CASE "+Internet": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_browser,"IW_browser")
  CASE "-Internet": sCpa3 = "IW_browser"

  CASE "+LogIN": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_login,"IW_login")
  CASE "-LogIN": sCpa3 = "IW_login"

  CASE "+Recibo": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_recibo,"IW_recibo","RBO_ABRE","LOGIN")
  CASE "-Recibo": sCpa3 = "IW_recibo"

  CASE "+Titula": nCpa1 = DashAddWidget({ggsDash_Nombre,indControl},IW_titulosEdita,"IW_titulosEdita")
  CASE "-Titula": sCpa3 = "IW_titulosEdita"


	OTHER CASE: Error("X no definida ggsAcion "+ggsA); RETURN
END

// -------------------- particular --------------------
IF Left(ggsA,1) = "-" THEN
  // Quita ..
  IF sCpa3 = "" THEN Error("Algo anda mal en la vadilaci�n de opciones "+sCompilaTXT+" (3131147)")
  FOR nN = 1 TO DashCount({ggsDash_Nombre,indControl},toTotal)
    IF {ggsDash_Nombre,indControl}[nN]..Name = sCpa3 THEN DashDelete({ggsDash_Nombre,indControl},nN); BREAK
  END
ELSE
  // Pon ...
  {ggsDash_Nombre,indControl}[nCpa1]..Visible = True
END
// -------------------- particular --------------------

//EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
