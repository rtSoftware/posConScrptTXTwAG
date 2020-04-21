//EXTERN ".\zzW\IWbro\IWbro_BTN.wl" // windows

//Ejecuta("BTN")
//sTarea is string  = MySelf..Name; Ejecuta("BTN",MySelf..Name)
//sTarea is string  = MySelf..Name; Ejecuta("BTN",MySelf..Caption)
//Ejecuta("BTN","tarea")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
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
    CASE "BTN_f1"
      Info("Hola "+gapA[1])


    OTHER CASE: Error("X no definidao boton: "+gapA[1]+" en(2002291832) "+sCompilaTXT)
  END
//END
