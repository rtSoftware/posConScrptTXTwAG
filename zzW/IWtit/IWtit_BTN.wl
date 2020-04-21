//EXTERN ".\zzW\IWtit\IWtit_BTN.wl" // windows



//Ejecuta("BTN")
//sTarea is string  = MySelf..Name; Ejecuta("BTN",MySelf..Name)
//sTarea is string  = MySelf..Name; Ejecuta("BTN",MySelf..Caption)
//Ejecuta("BTN","tarea")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
 //nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

sCTL = MySelf..Name; IF gapA[1] = "" THEN gapA[1] = sCTL
sCpa1 = MySelf..Caption
IF nDebug = Today() THEN Info("sCTL="+sCTL,"gapA[1]="+gapA[1],"","Caption="+sCpa1,"Caption="+{sCTL}..Caption)
/////////////// Imagenes ///////////////
IF Left(gapA[1],4) = "IMG_" THEN
  SWITCH gapA[1]
    CASE ~~"IMG_menos"
      // IMG_menos

  END
  RETURN
END



/////////////// Botones ///////////////
//gbTeclado = True  // teclado no escaneado

// EDT_Captura/2   <-- BTN_xxxx#
//IF Val(Right(gapA[1],1)) > 0 OR Right(gapA[1],1) = "0" THEN

//ELSE
  // *** Pueden o no existir ***//
  IF Upper(gapA[1]) = "BTN_PAGAR" THEN

    RETURN
  END
  // *** Pueden o no existir por eso uso EXTERN... ***//

  SWITCH gapA[1]
    CASE ~~"BTN_OK": Close()
    CASE ~~"BTN_X": gbSaltaSALVA = True; Close()
    CASE ~~"BTN_otro": {gestoyEn,indWindow}..Plane = 5

    CASE ~~"BTN_catalogo"
      // Se ha seleccionado un cat�logo para ser editado...
      IF EDT_catalogo <> "" THEN
      	gsPCata = EDT_catalogo; EDT_catalogo = ""
        Info("gsPCata="+gsPCata)
      	Ejecuta("ABRE","EDITA")

      ELSE
      	Error("Imposible continuar sin Cat�logo ...")
      END


    OTHER CASE: Error("X no definidao boton: "+gapA[1]+" en(2002291832) "+sCompilaTXT)
  END
//END
