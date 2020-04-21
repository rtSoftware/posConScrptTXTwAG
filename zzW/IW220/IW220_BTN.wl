//EXTERN ".\zzW\IW220\IW220_BTN.wl"

//Ejecuta("BTN")
//sTarea is string  = MySelf..Name; Ejecuta("BTN",MySelf..Name)
//sTarea is string  = MySelf..Name; Ejecuta("BTN",MySelf..Caption)
//Ejecuta("BTN","tarea")
/////////////////////////////////////////////////////////////////////////
// Flujo:   BTN_<0..1> --> EDT_Captura / EDT_Usuario (ciclo)
//            BTN_E --> ENTER --> FIND --> FORM (INI)     // login
//            BTN_E --> ENTER --> FIND --> FORM (Recibo)  // sku
//            BTN_P --> ENTER --> FIND --> FORM (kata)    // pago
//            BTN_C --> ABRE  (cancela)
//          MJES --> IWxxx_ZALI   (muy variado)
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

sCTL = MySelf..Name; IF gapA[1] = "" THEN gapA[1] = sCTL
sCpa1 = MySelf..Caption
//nDebug = 20200317
IF nDebug = Today() THEN Info("sCTL="+sCTL,"gapA[1]="+gapA[1],"","Caption="+sCpa1,"Caption="+{sCTL}..Caption)
/////////////// Imagenes ///////////////
IF Left(sCTL,4) = "IMG_" THEN
  SWITCH sCTL
    CASE ~~"IMG_reciboX"
      //IMG_reciboX
      IF HNbRec(Recibo) = 1 THEN
      	Info("Pulse bot�n [X]")
      ELSE
      	IF HNbRec(Recibo) > 0 THEN
      		HDelete(Recibo,hRecNumCurrent)
      		Ejecuta("CALC","SKU")
      	END
      END
    CASE ~~"IMG_menos"
      // IMG_menos
      IF Recibo.uni THEN
      	IF Recibo.uni > 1 THEN
      		Recibo.uni-- ;HModify(Recibo,hRecNumCurrent)
      		Ejecuta("CALC","SKU")
      		SetFocus(EDT_Captura)
      	END
      END
    CASE ~~"IMG_mas"
      Recibo.uni++ ;HModify(Recibo,hRecNumCurrent)
      Ejecuta("CALC","SKU")
      SetFocus(EDT_Captura)
    OTHER CASE: Error("X no definidaa Imagen: "+sCTL+" en(200220544) "+sCompilaTXT)
  END
  RETURN
END



/////////////// Botones ///////////////
gbTeclado = True  // teclado no escaneado
IF nDebug = Today() THEN Info("sCTL="+sCTL)

// EDT_Captura/2   <-- BTN_xxxx#
IF Val(Right(sCTL,1)) > 0 OR Right(sCTL,1) = "0" THEN
  IF {gestoyEn,indWindow}..Plane = gnCapaSku THEN
  	EDT_Captura = EDT_Captura + Val(Right(sCTL,1))
    ReturnToCapture(EDT_Captura)
  ELSE IF {gestoyEn,indWindow}..Plane = gnCapaLogin
  	EDT_Usuario = EDT_Usuario + Val(Right(sCTL,1))
    ReturnToCapture(EDT_Usuario)
  END
ELSE
  // *** Pueden o no existir ***//
  IF Upper(sCTL) = "BTN_PAGAR_CANCELA" THEN
      IF HNbRec(Recibo) > 0 THEN
        IF YesNo("Suspende ?") THEN
          sBque is string
          // Puede usar con script TXT
          HReadFirst(Recibo)
          WHILE HOut(Recibo) = False
            sBque = Recibo.mesa+";"+...
            Recibo.codigo+";"+...
            Recibo.descripcion+";"+...
            Recibo.uni+";"+...
            Recibo.descuento+";"+...
            Recibo.tax1+";"+...
            Recibo.tax2+";"+...
            Recibo.precio+";"+...
            Recibo.extendido+";"+...
            Recibo.promo+";"+...
            Recibo.flag+";"+...
            Recibo.costo+";"+...
            Recibo.cagoria+";"+...
            Recibo.presentacion+";"+...
            Recibo.caducidad+";"+...
            Recibo.imagen+CR

            HReadNext(Recibo)
          END
          fSaveText(ggsSAVE+[fSep]+Right(Now(),5)+"rbo.txt",sBque)
        END

        HDeleteAll(Recibo)
      END // (Recibo) > 0
      Ejecuta("LOOPER_RECIBO") // vacio en Ejecuta(gapE[1],sCTL,pN) cuando no aplica
      Ejecuta("ABRE","LOGIN") //Ejecuta("ABRE","SKU")
      RETURN  // sobrea por el ReturnToCapture(EDT_Captura)
  END

  IF Upper(sCTL) = "BTN_PAGAR" THEN
    IF HNbRec(Recibo) > 0 THEN Ejecuta("ABRE","PAGO") //419
    RETURN
  END
  // *** Pueden o no existir por eso uso EXTERN... ***//

  SWITCH Right(sCTL,1)
    CASE "B"
      // Backspace
      IF {gestoyEn,indWindow}..Plane = gnCapaSku THEN
        ggni = Length(EDT_Captura)
        IF ggni > 0 THEN EDT_Captura = Left(EDT_Captura,ggni-1)
      ELSE IF {gestoyEn,indWindow}..Plane = gnCapaLogin
        ggni = Length(EDT_Usuario)
        IF ggni > 0 THEN EDT_Usuario = Left(EDT_Usuario,ggni-1)
      END

    CASE "E"
      // Enter
      IF {gestoyEn,indWindow}..Plane = gnCapaSku THEN
        // Tarea , SKU;7501234561234;2
    		Ejecuta("ENTER","SKU;"+Replace(MySelf..Value,".",";"))	//producto.cantidad
      ELSE IF {gestoyEn,indWindow}..Plane = gnCapaLogin
        //0219
        IF Contains(EDT_Usuario,".") AND NOT gbPin THEN
    			// Tarea , LOGIN;1001;1234
    			Ejecuta("ENTER","LOGIN;"+Replace(MySelf..Value,".",";"))	//usuario.clave
    		ELSE
    			IF EDT_Pin = "" THEN ReturnToCapture(EDT_Pin)
    			Ejecuta("ENTER","LOGIN;"+EDT_Usuario+";"+EDT_Pin)	//usuario.clave
    		END
      END

    CASE "O","A"
      // puntO  pagO pagA
      IF {gestoyEn,indWindow}..Plane = gnCapaSku THEN
        //0219
        IF Contains(sCTL,"PAG",IgnoreCase) THEN
          Ejecuta("ABRE","PAGO")
        ELSE
          EDT_Captura = EDT_Captura + "."
        END
      ELSE IF {gestoyEn,indWindow}..Plane = gnCapaLogin
        EDT_Usuario = EDT_Usuario + "."
      END
    CASE "X"
      // Elimina
      IF {gestoyEn,indWindow}..Plane = gnCapaSku THEN EDT_Captura = "" ELSE EDT_Usuario = ""
    OTHER CASE: Error("X no definidao boton: >>>"+sCTL+"<<< en(2002191734) "+sCompilaTXT)
  END
END
