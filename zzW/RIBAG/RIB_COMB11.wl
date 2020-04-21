//EXTERN ".\zzW\RIBAG\RIB_COMB11.wl" // windows


//Ejecuta("COMB")                       // definicion OPCIONES --> IWxxx_COMB.wl
//Ejecuta("COMB","Op_1;Op_2;Op_3")      // definicion OPCIONES en parametros
//Ejecuta("ABRE","COMB;Op_1;Op_2;Op_3") // definicion OPCIONES en parametros
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
//{gestoyEn,indWindow}..Plane = 1     // Asegura si no entra por ABRE
sCpa1 = "COMBO_11"; bCpa1 = True   // Limpia control despues de seleccion
// -------------------------------------------------------------------------

// F O R M A
IF NOT ListCount({sCpa1,indControl}) THEN
  IF nDebug = Today() THEN Info("FORMA...","(num de param)gapA="+ArrayCount(gapA))
  c11 is int
  FOR c11 = 1 _TO_ ArrayCount(gapA)
    IF Left(Upper(gapA[c11]),3) IN ("CBO","COM") THEN CONTINUE
    IF Left(gapA[c11],1) = "*" THEN gapA[c11] = Right(gapA[c11],Length(gapA[c11])-1)
    IF Contains(gapA[c11],"~") THEN CONTINUE // param CONCLUYE
    ListAdd({sCpa1,indControl},gapA[c11])
  END
  // Distingue si la lista fue formada con PARAMETROS vs CODIGO
  IF ListCount({sCpa1,indControl}) > 1 THEN ListInsert({sCpa1,indControl},"_nada",1)

  ////////////////////////////////////////////////////////////////////////
  // Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
  //                        Ejecuta("CBOS")
  ////////////////////////////////////////////////////////////////////////
  ListAdd({sCpa1,indControl},"+ Calendario")
  ListAdd({sCpa1,indControl},"- Calendario")

  ListAdd({sCpa1,indControl},"+ Cfg")
  ListAdd({sCpa1,indControl},"- Cfg")

  ListAdd({sCpa1,indControl},"+ Grafica")
  ListAdd({sCpa1,indControl},"- Grafica")

  ListAdd({sCpa1,indControl},"+ Internet")
  ListAdd({sCpa1,indControl},"- Internet")

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
//	Ejecuta("COMB")	        // parametros
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
sCpa2 = gestoyEn+"."+INIRead("cfg","DASH","",ggsIni)
IF sCpa2 = "" THEN
  // Widget (INI: [cfg]DASH=WIN_MAIN.DASH1)
  sCpa2 = ""; Input("Nombre del VENTANA.DASH ?",sCpa2)
  IF sCpa2 = "" THEN Error("Imposible continuar sin nombre Ventana.Dash"); RETURN

  INIWrite("cfg","DASH",sCpa2,ggsIni)
END
sCpa3 = ""  // Asegura
// -------------------- particular --------------------

// Funcionalidad extendida (solo codigo, imposible en modo parametros)
SWITCH ggsA
	CASE "","nada": RETURN

////////////////////////////////////////////////////////////////////////
// Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
//                        Ejecuta("CBOS")
////////////////////////////////////////////////////////////////////////
  CASE "+ Calendario": nCpa1 = DashAddWidget({sCpa2},IW_calendario,"IW_calendario")
  CASE "- Calendario": sCpa3 = "IW_calendario"

  CASE "+ Cfg": nCpa1 = DashAddWidget({sCpa2},IW_cfg,"IW_cfg")
  CASE "- Cfg": sCpa3 = "IW_cfg"

  CASE "+ Grafica": nCpa1 = DashAddWidget({sCpa2},IW_grafica,"IW_grafica")
  CASE "- Grafica": sCpa3 = "IW_grafica"

  CASE "+ Internet": nCpa1 = DashAddWidget({sCpa2},IW_browser,"IW_browser")
  CASE "- Internet": sCpa3 = "IW_browser"

  CASE "+ Recibo": nCpa1 = DashAddWidget({sCpa2},IW_recibo,"IW_recibo","RBO_ABRE","LOGIN")
  CASE "- Recibo": sCpa3 = "IW_recibo"

  CASE "+ Titula": nCpa1 = DashAddWidget({sCpa2},IW_titulosEdita,"IW_titulosEdita")
  CASE "- Titula": sCpa3 = "IW_titulosEdita"

	OTHER CASE: Error("X no definida ggsAcion "+ggsA); RETURN
END

// -------------------- particular --------------------
IF Left(ggsA,1) = "-" THEN
  // Quita ..
  IF sCpa3 = "" THEN Error("Algo anda mal en la vadilaci�n de opciones "+sCompilaTXT+" (3131147)")
  FOR nCpa1 = 1 TO DashCount({sCpa2},toTotal)
    IF {sCpa2}[nCpa1]..Name = sCpa3 THEN DashDelete({sCpa2},nCpa1); BREAK
  END
ELSE
  // Pon ...
  {sCpa2}[nCpa1]..Visible = True
END
// -------------------- particular --------------------

//EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
