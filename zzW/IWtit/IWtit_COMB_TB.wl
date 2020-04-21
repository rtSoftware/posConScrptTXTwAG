//EXTERN ".\zzW\IWxxx\IWxxx_COMB.wl" // windows


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
{gestoyEn,indWindow}..Plane = gnCapa   // Asegura si no entra por ABRE
sCpa1 = "COMBO_TB"; bCpa1 = False  // Limpia control despues de seleccion
IF gnCapa = 2 THEN sCpa1 = "COMBO_HC"
// -------------------------------------------------------------------------
nN is int

// F O R M A
IF NOT ListCount({sCpa1,indControl}) THEN
  IF nDebug = Today() THEN Info(sCpa1+"="+ListCount({sCpa1,indControl}))
  IF nDebug = Today() THEN
    Info("FORMA...","(num de param)gapA="+ArrayCount(gapA))
  END
  FOR nN = 1 _TO_ ArrayCount(gapA)
    IF Left(Upper(gapA[nN]),3) IN ("CBO","COM") THEN CONTINUE
    IF Left(gapA[nN],1) = "*" THEN gapA[nN] = Right(gapA[nN],Length(gapA[nN])-1)
    IF Contains(gapA[nN],"~") THEN CONTINUE // param CONCLUYE
    ListAdd({sCpa1,indControl},gapA[nN])
  END

  ////////////////////////////////////////////////////////////////////////
  // Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
  //                        Ejecuta("CBOS")
  ////////////////////////////////////////////////////////////////////////
  ListAdd({sCpa1,indControl},"Catalogo...")
  ListAdd({sCpa1,indControl},"")
  ListAdd({sCpa1,indControl},"Clientes")
  ListAdd({sCpa1,indControl},"Empleados")
  ListAdd({sCpa1,indControl},"Inventarios")
  ListAdd({sCpa1,indControl},"Proveedores")
  ListAdd({sCpa1,indControl},"")
  ListAdd({sCpa1,indControl},"Ventas")
  ListAdd({sCpa1,indControl},"")
  ListAdd({sCpa1,indControl},"MovClientes")
  ListAdd({sCpa1,indControl},"MovEmpleados")
  ListAdd({sCpa1,indControl},"MovInventarios")
  ListAdd({sCpa1,indControl},"MovProveedores")
  ListAdd({sCpa1,indControl},"")
  IF gnCapa = 1 THEN
    ListAdd({sCpa1,indControl},"Hoja de Calculo")
  ELSE
    ListAdd({sCpa1,indControl},"Modo Tabla")
  END
  ListAdd({sCpa1,indControl},"Edita Titulos")
  ListAdd({sCpa1,indControl},"Titula")

  ListAdd({sCpa1,indControl},"Salir")
  ListAdd({sCpa1,indControl},"TEST")


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
// Ejecuta("COMB")
////////////////////////////////////////////////////////
// Respuesta ...
IF nDebug = Today() THEN Info("SELECCIONA...","num de seleccion="+{sCpa1,indControl})
ggsA = {sCpa1,indControl}[{sCpa1,indControl}]; ToClipboard(ggsA); gapA[1] = ggsA

// Deja limpio el control para ser usado nuevamente...
IF bCpa1 THEN ListDeleteAll({sCpa1,indControl})  // Limpia contenido del control

// Funcionalidad extendida (solo codigo, imposible en modo parametros)
SWITCH ggsA
	CASE "","nada": RETURN

////////////////////////////////////////////////////////////////////////
// Escriba aqui CODIGO para formar Lista si no invoca con PARAMETROS...
//                        Ejecuta("CBOS")
////////////////////////////////////////////////////////////////////////
  CASE "Catalogo..."
    gsPCata = ""; Ejecuta("FIND"); RETURN // --> FIND --> FORN
  CASE "Clientes": Ejecuta("FIND","CLIE"); RETURN
  CASE "Empleados": Ejecuta("FIND","EMPL"); RETURN
  CASE "Inventarios": Ejecuta("FIND","INVE"); RETURN
  CASE "Proveedores": Ejecuta("FIND","PROVE"); RETURN

  CASE "MovClientes": Ejecuta("FIND","VNXC"); RETURN
  CASE "MovEmpleados": Ejecuta("FIND","VNXE"); RETURN
  CASE "MovInventarios": Ejecuta("FIND","VNXI"); RETURN
  CASE "MovProveedores": Ejecuta("FIND","VNXP"); RETURN

  CASE "Ventas": Ejecuta("FIND","VE"); RETURN

  CASE "Edita Titulos": Ejecuta("ABRE","ET"); RETURN

  CASE "Modo Tabla": gnCapa = 1; Ejecuta("ABRE","TB"); RETURN
  CASE "Hoja de Calculo": gnCapa = 2; Ejecuta("ABRE","HC"); RETURN
  CASE "Salir": RETURN
  CASE "TEST"
    Info("TEST:   Ejecuta(ABRE , HC_VNXI)")
    Ejecuta("ABRE","HC_VNXI")

	OTHER CASE: Error("X no definida ggsAcion "+ggsA); RETURN
END
////EXTERN ".\zzW\Z\Ejecuta_CONCLUYE.wl"
