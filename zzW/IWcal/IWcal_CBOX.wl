//EXTERN ".\zzW\IWcal\IWcal_CBOX.wl" // windows

//Ejecuta("CBOX")

// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// F O R M A
IF NOT ListCount(COMBO_1) THEN
  ListAdd(COMBO_1,"nada")
  ListAdd(COMBO_1,"F1F12")  // EXTERN ".\zzW\IWcal\IWcal_BTN.wl"
  ListAdd(COMBO_1,"CLAVE")  // Ejecuta("ABRE","CLAVE;blanco;negro")

  ListAdd(COMBO_1,"COMB") // EXTERN ".\zzW\IWcal\IWcal_CBOS.wl"
  ListAdd(COMBO_1,"CHEC")
  ListAdd(COMBO_1,"IMGE")
  ListAdd(COMBO_1,"RADI")
  ListAdd(COMBO_1,"TREE")

  //ListDisplay(COMBO_1)  // Nunca porque es elaborada en el aire
  RETURN
END


// S E L E C C I O N
ggsA = COMBO_1[COMBO_1]
SWITCH ggsA
	CASE "","nada": RETURN
	CASE ~~"F1F12"
    ToClipboard("Ejecuta("+gsCas+"ABRE"+gsCas+","+gsCas+"FUNCIONES"+gsCas+")")
    ggsA = "El codigo a ejecutar al pulsar F1..F12 esta en IWxxx_BTN. La llamada presentada solo activa teclas de funciones..."
    IF YesNo("Sintaxis:","     Ejecuta(ABRE,FUNCIONES)",ggsA,"","Presenta ?") THEN
      Ejecuta("ABRE","FUNCIONES")
    END
  CASE ~~"Clave"
    ToClipboard("Ejecuta("+gsCas+"ABRE"+gsCas+","+gsCas+"CLAVE;sPalabra;sClave"+gsCas+")")
    ggsA = "Funciona enviando en los parametros dos palabras. La primera se mostrara, la seguenda debera coincidir con lo digitado en casilla de password"
    ggsA = ggsA +CR+ "Alterno... codigo con mas funcionalidad en IWxxx_CLAVE.wl"
    IF YesNo("Sintaxis:","     Ejecuta(ABRE,CLAVE;sPalabra;sClave)",ggsA,"","Presenta ?") THEN
      ggsA1 = ""; Input("Palabra expuesta ?",ggsA1)
      ggsA2 = ""; Input("Clave2 ?",ggsA2)

      //// Solo para efectos DEMO ----------------------------------
      Ejecuta("ABRE","RADI;Modo ABRE;Modo WL;ABRE~CLAVE~"+ggsA1+"~"+ggsA2+";ABRE~TOOLS")
      RETURN
      //// Solo para efectos DEMO ----------------------------------

      // *** Nunca pasa por aqui a menos que este comentada parrafo anterior ***
      // E j e m p l o s ...
      //Ejecuta("CLAVE",ggsA1+";"+ggsA2)   // WL con funcionalidad

      // Codigo simple en ABRE... ~=CONCLUYE
      Ejecuta("ABRE;ABRE~TOOLS" , "CLAVE;"+ggsA1+";"+ggsA2)
      //Ejecuta("ABRE;CLAVE",ggsA1+";"+ggsA2)  // sin conclucion
      //Ejecuta("ABRE","CLAVE;"+ggsA1+";"+ggsA2) // sin conclucion

      // Codigo simple en ABRE con otra sintaxis ...
      //Ejecuta("ABRE;CLAVE;"+ggsA1+";"+ggsA2+";ABRE~TOOLS")
    END
  CASE ~~"COMB"
    ToClipboard("Ejecuta("+gsCas+"COMB"+gsCas+","+gsCas+"Op_1;Op 2;Op_3"+gsCas+")")
    IF YesNo("Sintaxis:","     Ejecuta(COMB;Op_1;Op_2;Op_3 ;FIND~[param1])","     Ejecuta(COMB,Op_1;Op 2;Op_3)","","Presenta ?") THEN
      //Ejecuta("ABRE","COMB;Op_1;Op_2;Op_3") // (compativiliad)
      Ejecuta("COMB","Op_1;Op 2;Op_3")
        //Ejecuta("COMB","Op_1;Op 2;Op_3 ;TEST~") // regresa a TEST en ZALI... Ejecuta(TEST)
        //Ejecuta("COMB","Op_1;Op 2;Op_3 ;TEST~param1") // en ZALI: Ejecuta(TEST,param1)
        //Ejecuta("COMB","Op_1;Op 2;Op_3 ;TEST~param1~param2") // Incorrecto
    END
    // remodelar todos los ABRE.COMB
    // crear todos los ZALI para las IW_xxx
    // remodelar Todos los COMB,CHEC y RADI
    // ajustar MOTOR IW_xxx.wl
  CASE ~~"CHEC"
    ToClipboard("Ejecuta("+gsCas+"CHEC"+gsCas+","+gsCas+"Op_1;Op 2;Op_3"+gsCas+")")
    IF YesNo("Sintaxis:","     Ejecuta(CHEC;Op_1;Op_2;Op_3;TEST~)","     Ejecuta(CHEC,Op_1;Op 2;Op_3)","","Presenta ?") THEN
      //Ejecuta("ABRE","CHEC;Op_1;Op_2;Op_3") // solo con parametros incluidos
      //Ejecuta("CHEC","Op_1;Op 2;Op_3;TEST~")
      //Ejecuta("CHEC;Op_1;Op 2;Op_3;TEST~")
      Ejecuta("CHEC","Op_1;Op 2;Op_3;TEST~")
    END
  CASE ~~"RADI"
    ToClipboard("Ejecuta("+gsCas+"RADI"+gsCas+","+gsCas+"Op_1;Op 2;Op_3"+gsCas+")")
    IF YesNo("Sintaxis:","     Ejecuta(RADI;Op_1;Op_2;Op_3;TEST~[param1]","     Ejecuta(RADI,Op_1;Op 2;Op_3)","","Presenta ?") THEN
      //ggsAccion = "EI"  // prende debug en Ejecuta_INICIO
      //Ejecuta("ABRE","RADI;Op_1;Op_2;Op_3;TEST~") // correcto tambien pero en DES USO
      //Ejecuta("RADI","Op_1;Op 2;Op_3;TEST~")
      Ejecuta("RADI;Op_1;Op 2;Op_3;TEST~paramAlgo")
    END
  CASE ~~"TREE"
    ToClipboard("Ejecuta("+gsCas+"ABRE"+gsCas+","+gsCas+"TREE"+gsCas+")")
    ggsA = "El codigo para formar RAMAS y HOJAS esta en IWxxx_TREE.wl"
    IF YesNo("Sintaxis:","     Ejecuta(ABRE,TREE)",ggsA,"","Presenta ?") THEN
      Ejecuta("ABRE","TREE")
    END

	OTHER CASE: Error("X no definida ggsAcion "+ggsA+" en "+sCompilaTXT); RETURN
END
