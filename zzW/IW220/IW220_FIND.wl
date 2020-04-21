//EXTERN ".\zzW\IW220\IW220_FIND.wl"

// Ejecuta("XXX_EDT")  // sin prefijo   "XXX_xxxx"    es codigo base
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

ggsRespuesta = ""

// Valida ...
IF Upper(gapA[1]) NOT IN("LOGIN","SKU")  THEN gapA[1] = ""
IF gapA[1] = "" THEN
  Error("X parametro CAPA aucente/erroneo en "+sCompilaTXT)
  SWITCH {gestoyEn}..Plane
    CASE gnCapaLogin: gapA[1] = "LOGIN"
    CASE gnCapaSku: gapA[1] = "SKU"
    //CASE gnCapaPago: gapA[1] = "PAGO"   ????????????????????
    OTHER CASE: Error("X no definida Tarea en "+sCompilaTXT); EndProgram()
  END
END

IF gapA[2] = "" THEN Error("X parametro aucente en "+sCompilaTXT)

IF Upper(gapA[1]) = "SKU" THEN
	// Sku
	ggnCant = Val(gapA[3]); IF ggnCant = 0 THEN ggnCant = 1
	gapA[3] = "" // Higiene

	gapA[2] = Right("000000000000"+gapA[2],13)
	IF nDebug = Today() THEN Info(gapE[1]+"...","Sku="+gapA[2],"AIN="+ArrayCount(AIN))

	// Cantidad inplicita en captura
	nCpa3 = Position(gapA[2],"."); ggnCant = 1 // no implicita entonces 1 = default
	IF nCpa3 > 0 THEN gapA[2] = Left(gapA[2],nCpa3-1); ggnCant = Middle(gapA[2],nCpa3+1,5); nCpa3 = 0

	IF ArrayCount(AIN) > 0 THEN
		nCpa1 = ArraySeek(ggarrINVEc,asLinear,Right("000000000000"+gapA[2],13))
		IF nCpa1 > 0 THEN
			ggsRespuesta = ";"+AIN[nCpa1]:cata+";"+AIN[nCpa1]:codigo+";"+AIN[nCpa1]:descripcion+";"+...
			AIN[nCpa1]:val1+";"+AIN[nCpa1]:val2+";"+AIN[nCpa1]:flag+";"+...
			AIN[nCpa1]:Flagc20+";"+AIN[nCpa1]:nota+";"+AIN[nCpa1]:b+";"+AIN[nCpa1]:c+";"+...
			AIN[nCpa1]:d+";"+AIN[nCpa1]:f+";"+AIN[nCpa1]:g+";"+AIN[nCpa1]:m+";"+...
			AIN[nCpa1]:n+";"+AIN[nCpa1]:fecha+";"+AIN[nCpa1]:hora //+Cr

			IF AIN[nCpa1]:fecha = "20000101" THEN Info("Producto desactivo ...") ;RETURN
			IF AIN[nCpa1]:val1 = 0 THEN AIN[nCpa1]:val1 = "1000"
		END
	END

	IF ggsRespuesta = "" THEN
		// Lee catï¿½logo(tabla fisica) ...
		// Vector AIN no esta actualizado ...
		Ejecuta("E",";INVE;"+gapA[2]) // prEsenta
		IF gsBloqueP <> "" THEN
				fd is array of ANSI string
				StringToArray(gsBloqueP,fd,";")

				IF Right("000000000000"+fd[3],13) = gapA[2] THEN
					ggsRespuesta = gsBloqueP
					IF fd[17] = "20000101" THEN Info("Producto desactivo ...") ;RETURN
					IF fd[5] <= 0 THEN fd[5] = 1000

					HReset(Recibo)
					Recibo.mesa = 999 ;Recibo.codigo = gapA[2] ;Recibo.descripcion = fd[4]
					Recibo.uni = ggnCant ;Recibo.descuento = 0 ;Recibo.tax1 = 0 ;Recibo.tax2 = 0
					Recibo.precio = fd[5] ;Recibo.extendido = Recibo.precio*ggnCant
					Recibo.costo = fd[6] ;Recibo.caducidad = fd[13] ;Recibo.cagoria = fd[11]
					Recibo.imagen = fCurrentDir()+[fSep]+"IMAGENES"+[fSep]+gapA[2]+".jpg"
					IF NOT HAdd(Recibo) THEN ggsLog = "XA Recibo(escann_SKU)"+ErrorInfo() ELSE ggsLog = "OK escann_SKU"

	      ELSE
	        Error(gapA[2]+" CODIGO INEXISTENTE...")
				END
		ELSE
			Error(gapA[2]+" CODIGO INEXISTENTE !")
		END
	ELSE
		HReset(Recibo)
		Recibo.mesa = 999 ;Recibo.codigo = AIN[nCpa1]:codigo ;Recibo.descripcion = AIN[nCpa1]:descripcion
		Recibo.uni = ggnCant ;Recibo.descuento = 0 ;Recibo.tax1 = 0 ;Recibo.tax2 = 0
		Recibo.precio = AIN[nCpa1]:val1 ;Recibo.extendido = Recibo.precio*ggnCant
		Recibo.costo = AIN[nCpa1]:val2 ;Recibo.caducidad = AIN[nCpa1]:f ;Recibo.cagoria = AIN[nCpa1]:c
		Recibo.imagen = fCurrentDir()+[fSep]+"IMAGENES"+[fSep]+AIN[nCpa1]:codigo+".jpg"
		IF Recibo.precio <= 0 THEN Recibo.precio = "1000"
		IF NOT HAdd(Recibo) THEN ggsLog = "XA Recibo(AIN escan_SKU)"+ErrorInfo() ELSE ggsLog = "OK AIN escan_SKU"
	END
	IF Upper(Left(ggsLog,1)) = "X" THEN Error(ggsLog) //0201
	IF nDebug = Today() THEN
		IF gapA[1] <> "" THEN Info("encontro "+gapA[2],"",gapA[1]) ELSE Info("Inexistente "+gapA[2])
	END

	sCpa1 = "TOTAL $ "+NumToString(gcyImporte,"8.2f")
	Ejecuta("MJES" , "SKU"+";;;"+sCpa1)  //SKU/login

ELSE IF Upper(gapA[1]) = "LOGIN"
	// login

	IF nDebug = Today() THEN Info(gapE[1]+"...","U="+gapA[2],"P="+gapA[3],"Teclado="+bCpa1,"","AEM="+ArrayCount(AEM))

	IF ArrayCount(AEM) > 0 THEN
		// Lee catálogo(super arreglo) ...
		FOR nCpa1 = 1 TO ArrayCount(AEM)
      //IF nDebug = Today() THEN Info(AEM[nCpa1]:codigo , gapA[2])
			IF AEM[nCpa1]:codigo = gapA[2] THEN
				// AEM[nCpa1]:Flagc20 <-- gapA[3]  listo para actualizar pass si hay que hacerlo
				ggsRespuesta = ";EMPL;"+AEM[nCpa1]:codigo+";"+AEM[nCpa1]:descripcion+";"+...
				AEM[nCpa1]:val1+";"+AEM[nCpa1]:val2+";"+AEM[nCpa1]:flag+";"+...
				gapA[3]+";"+AEM[nCpa1]:nota+";"+AEM[nCpa1]:b+";"+AEM[nCpa1]:c+";"+...
				AEM[nCpa1]:d+";"+AEM[nCpa1]:f+";"+AEM[nCpa1]:g+";"+AEM[nCpa1]:m+";"+...
				AEM[nCpa1]:n+";"+AEM[nCpa1]:fecha+";"+AEM[nCpa1]:hora //+Cr

				IF gapA[3] <> "" THEN
					IF nDebug = Today() THEN Info("CLAVE="+AEM[nCpa1]:Flagc20)
					IF AEM[nCpa1]:Flagc20 = "" THEN
						IF nDebug = Today() THEN Info("Actualiza nuevo pass...","",ggsRespuesta)
						ggbFlash_n = True; Ejecuta("A",gsCas+ggsRespuesta+gsCas)
					ELSE
						IF AEM[nCpa1]:Flagc20 <> gapA[3] THEN ggsRespuesta = "X"; bCpa1= True	// password ERRONEO
					END
				END

				BREAK
			END
		END
	END

	IF ggsRespuesta = "" THEN
		IF nDebug = Today() THEN Info("Lee archivo... catï¿½logo: EMPL")
		// Lee catï¿½logo(tabla fisica) ...
		// Vector AEM no esta actualizado ...
		Ejecuta("E",";EMPL;"+gapA[2]) // prEsenta
    IF nDebug = Today() THEN Info("gapA[1]="+gapA[1],"gapA[2]="+gapA[2],"gapA[3]="+gapA[3])
    IF nDebug = Today() THEN Info(";EMPL;"+gapA[2]+" ...",gsBloqueP)
		IF gsBloqueP <> "" THEN
			FOR EACH STRING sL OF gsBloqueP SEPARATED BY CR
				IF sL = "" THEN CONTINUE
				fd1 is array of ANSI string
				StringToArray(sL,fd1,";")

				IF fd1[3] = gapA[2] THEN
					ggsRespuesta = sL
					IF gapA[3] <> "" THEN
						IF fd1[11] = "" THEN
							IF nDebug = Today() THEN Info("Actualiza nuevo pass...","",ggsRespuesta)
							ggbFlash_n = True; Ejecuta("A",gsCas+ggsRespuesta+gsCas)
						ELSE
							IF fd1[11] <> gapA[3] THEN ggsRespuesta = "X"; bCpa1= True	// password ERRONEO
						END
					END
					BREAK
				END
			END
		ELSE
			IF nDebug = Today() THEN Info("EMPL vacio ?","",ggsLog)
		END
	END

	//IF bCpa1 THEN Error("Pass erroneo...")
	IF nDebug = Today() THEN
		IF ggsRespuesta <> "" THEN Info("enocntro "+gapA[2],"",ggsRespuesta) ELSE Info("Inexistente "+gapA[2])
	END
ELSE
	  Error(gapA[1]+" es una capa inexistente en "+sCompilaTXT); Close()
END
