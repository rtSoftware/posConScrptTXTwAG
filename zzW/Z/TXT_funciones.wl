//.\zzW\TXT_funciones.wl"
sExterno is string = "zzOw_TXT"



//200110 Dias diferencia vs hoy
//191110 "rango"
//190920 "<" ... prepara IMPORTA
//190819 TXT(">KATA") --> RESULT("KATA") en vez de RESULT("")


nDebugTXT is int
ggsLog = "" // Asegura

IF pArchivo = "" THEN ggsLog = "parametro vacio ArchivoValida" ;RESULT("")

IF pArchivo = "?" THEN
	Info("*c:/algo.TXT valida existencia... regresa c:/algo.TXT si existe vacio si no existe",...
	"c:/algo.TXT valida existencia... regresa   algo.TXT   si existe vacio si no existe",...
	"",...
	"?.TXT SELECCIONA regresa nombre no contenido... si el archivo esta en el directorio del ejecutable regresa solo el nombre",...
	"",...
	"algo.TXT vacio si no existe, camino + nombre archivo si no esta en directorio del ejecutable.",...
	">algo.TXT regresa contenido",...
	"",...
	"Seleccion:  ?.DIR(directorio)  ?.JPG  ?.(todos)  ?.DOC  ?.RTF  ?.TXT  ?.XML",...
	"Todas las opciones generan ggsLog")
	RESULT("")
END



//          F E C H A S          //
// Dias diferencia vs hoy  20200110
IF DateValid(pArchivo) THEN
  RESULT(Val(Left(DateTimeDifference(pArchivo,Today()),8)))
END


//191110
IF Upper(Left(pArchivo,4)) = "MES-" THEN
  pArchivo = Middle(pArchivo,5,8)
  //Info("Inicio:",pArchivo)
  SWITCH IntegerToDate(DateToInteger(pArchivo),"M")
    CASE "01": pArchivo = IntegerToDate(DateToInteger(pArchivo)-31)
    CASE "02": pArchivo[[5 TO 6]] = "01"
    OTHER CASE
      IF Right(LastDayOfMonth(pArchivo),2) = "30" THEN
        pArchivo = IntegerToDate(DateToInteger(pArchivo)-31)
      ELSE
        IF Right(pArchivo,2) = "31" THEN
          pArchivo = IntegerToDate(DateToInteger(pArchivo)-31)
        ELSE
          pArchivo = IntegerToDate(DateToInteger(pArchivo)-30)
        END
      END
  END
  //Info("Fin:",pArchivo)
  RESULT(pArchivo)
END

IF Upper(Left(pArchivo,4)) = "MES+" THEN
  pArchivo = Middle(pArchivo,5,8)
  //Info("Inicio:",pArchivo)
  SWITCH IntegerToDate(DateToInteger(pArchivo),"M")
    CASE "01": pArchivo = IntegerToDate(DateToInteger(pArchivo)+31)
    CASE "02": pArchivo[[5 TO 6]] = "03"
    OTHER CASE
      IF Right(LastDayOfMonth(pArchivo),2) = "30" THEN
        pArchivo = IntegerToDate(DateToInteger(pArchivo)+31)
      ELSE
        IF Right(pArchivo,2) = "31" THEN
          pArchivo = IntegerToDate(DateToInteger(pArchivo)+31)
        ELSE
          pArchivo = IntegerToDate(DateToInteger(pArchivo)+30)
        END
      END
  END
  //Info("Fin:",pArchivo)
  RESULT(pArchivo)
END

IF Upper(Left(pArchivo,4)) = "DIA-" THEN
  pArchivo = Middle(pArchivo,5,8)
  pArchivo = IntegerToDate(DateToInteger(pArchivo)-1)
  RESULT(pArchivo)
END

IF Upper(Left(pArchivo,4)) = "DIA+" THEN
  pArchivo = Middle(pArchivo,5,8)
  pArchivo = IntegerToDate(DateToInteger(pArchivo)+1)
  RESULT(pArchivo)
END




IF Upper(Left(pArchivo,3)) = "SORT" THEN
  pArchivo = Right(pArchivo,Length(pArchivo)-4)


END

// Globales de todo el sistema AV
arrAV is array of string
sArSel,sBE is string  // archivoSeleccion  BorraEnvia (sBE="B")
nArchivoID,nBE is int // archivoID posicion (nBE=4)


IniWrite("AV","Nombre","",ggsINI)
IniWrite("AV","Extencion","",ggsINI)
IniWrite("AV","Directorio","",ggsINI)
IniWrite("AV","Unidad","",ggsINI)
IniWrite("AV","UD","",ggsINI)
IniWrite("AV","CURDIR",fCurrentDir(),ggsINI)


///////////////////// TXTabe /////////////////////
// Globales de todo el sistema AV
sP1L,sP2L,sP3L,sP4L is string     // compatibiliad
//arrABE is array of ANSI string  // Usa globales del sistema AV

IF Upper(Left(pArchivo,5)) IN ("TXT_A","TXT_B","TXT_E","TXT_X","TXT_?") THEN
  // eliminando EXTERN quedan dentro scop
  pTareaAV is string                  // compatibiliad
  sP1LAXXX,sLineaAXXX is string
  nX,nY,nZ,nD,nE is int
  arrWTXT is array of string
  sBqueTXT is String

  pTareaAV = Upper(Middle(pArchivo,5,1))

  IF pTareaAV = "?"
		Info("Ayuda en construccion ...")
		RESULT("")
	END

  sP1L = NoSpace(Right(pArchivo,Length(pArchivo)-5))
  nZ = Position(sP1L,"K=") //,1,WholeWord+IgnoreCase)
  IF nZ > 0 THEN
    sP2L = Upper(Middle(sP1L,nZ+2,99))
    sP1L = Left(sP1L,nZ-1)
  END
  //Info("Tarea="+pTareaAV,"sP1L...",sP1L,"sP2L="+sP2L,"nZ="+nZ) //;RESULT(ggsLog)

  sNombreTXT is string = "t15.txt"
  IF Left(sP2L,1) = "*" THEN
    sP2L = Right(sP2L,Length(sP2L)-1)
    sNombreTXT = sP2L + ".txt"
  END

  // Inspirado...
  //EXTERN "D:\YandexDisk\wd22\SP\WL\ORIGINAL\w\zzOw_TXTabe.wl"
  nZ = 0
  IF pTareaAV = "?"
    Info("Ayuda en construccion ...")
  END

  SWITCH pTareaAV
    CASE "?"
    CASE "A","B","E"
      ggsLog = "OK" ;ArrayDeleteAll(ggarrA)
      sP1LAXXX = TXT(Charact(34)+"-"+sP1L)
      IF nDebugTXT = Today() THEN Info("_"+pTareaAV,"sP1LAXXX(contenido): "+sP1LAXXX,"sP2L(kata): "+sP2L)
      IF pTareaAV = "A" AND sP1LAXXX = "" THEN LOG("A","X TXT_ referencia vacia: "+sP1L) ;RESULT(ggsLog) //*


      IF pTareaAV = "E" THEN
        fSaveText("txtI_e.txt","") ;fSaveText("txt_e.txt","")
      END

      //
      IF ASC(sP1LAXXX) IN(13,4,0) AND sP2L = "" THEN
        IF pTareaAV = "E" THEN
          LOG("A","OK regresa TODOS los catalogos")

          fCopyFile(sNombreTXT,"txt_e.txt")

          // Formato  IMPORTA ...
          sBqueTXT = TXT(">"+"txt_e.txt")
          //           5 6 7              14 15
          // cia,K,C,D,m,n,f,F20,N,c,d,f,g,m,n
          SCamposNum is string = "C5C C6C C7C C14C C15C"
          sNvoTXT is string
          FOR EACH STRING sR OF sBqueTXT SEPARATED BY CR
            IF sR = "" THEN CONTINUE

            // sR --> arrAV[1...17   ;2;"item 2";15 INVE
            S2A(Replace(sR,",",";"),arrAV)
            FOR i = 1 _TO_ ArrayCount(arrAV)
              IF NOT Contains(SCamposNum,"C"+NumToString(i)+"C",WholeWord) THEN
                //arrAV[i] = TXT(Charact(34)+"-"+arrAV[i])
                sNvoTXT = sNvoTXT + Charact(34)+arrAV[i]+Charact(34) + ","
              ELSE
                sNvoTXT = sNvoTXT + arrAV[i] + ","
              END
            END
            sNvoTXT = sNvoTXT + CR
          END // FOR

          fSaveText("txtI_e.txt",sNvoTXT) // para ser usado con IMPORT

        ELSE
          LOG("A","X"+pTareaAV+" parametros vacios")
        END
        RESULT(ggsLog) //*
      END


      // sP1LAXXX vacio no entra al ciclo
      IF ASC(sP1LAXXX) IN(13,4,0) AND sP2L <> "" THEN sP1LAXXX = ";" + CR

      // Delimitador ... | = CR   cuidadoi!
      //IF Contains(sP1LAXXX,"|") AND Contains(sP1LAXXX,CR) THEN
      IF Contains(sP1LAXXX,"|") THEN
        sP1LAXXX = Replace(sP1LAXXX,"|",CR)
      END

      // ++++++++++++
      // CICLO Grande
      // ++++++++++++
      FOR EACH STRING sLineaAXXX OF sP1LAXXX SEPARATED BY CR
        IF sLineaAXXX = "" THEN CONTINUE
        nX++  // local por su importancia de control
        //Info("nX="+nX,sLineaAXXX)

        sLineaAXXX = Replace(sLineaAXXX,",",";") // solo TXT_

        // sLineaAXXX --> arrAV[1...17   ;2;"item 2";15 INVE
        S2A(sLineaAXXX,arrAV)
        FOR i = ArrayCount(arrAV)+1 _TO_ 17
          ArrayAdd(arrAV,"")
        END

        // funde en sLineaAXXX <-- sP2L y autocorrige
        //EXTERN "D:\YandexDisk\wd22\SP\WL\ORIGINAL\w\zzOw_ABE_sP2L.wl"
        IF nDebugTXT = Today() THEN
           Info(sP1L,"","arrAV[1]"+arrAV[1],"arrAV[2]"+arrAV[2],"arrAV[3]"+arrAV[3])
        END

        // KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
        IF Left(arrAV[2],1) = "*" THEN
          IF Length(arrAV[2]) = 1 THEN
            arrAV[2] = ""
          ELSE
            arrAV[2] = Right(arrAV[2],Length(arrAV[2])-1)
          END
        END
        IF Left(sP2L,1) = "*" THEN
          IF Length(sP2L) = 1 THEN
            sP2L = ""
          ELSE
            sP2L = Right(sP2L,Length(sP2L)-1)
          END
        END
        IF ArrayCount(arrAV) = 2 THEN ArrayAdd(arrAV,Right(Now(),5))
        IF arrAV[2] = "" THEN
          IF sP2L <> "" THEN arrAV[2] = sP2L ELSE arrAV[2] = "XXXX"
        ELSE
          IF arrAV[2] <> "" THEN
            IF sP2L <> arrAV[2] THEN
              //ggsLog = "X conflicto en: "+sR ;BREAK
              LOG("A",sP2L+"<--K conflicto con: "+sLineaAXXX)
            END
          END
        END
        IF ggsDB = "TXT" THEN sNombreTXT = arrAV[2] + ".txt"

				// Pregunta nombre del catálogo
        IF arrAV[2] = "?" THEN
          sCatalogoManual is string
          Input("8max  4 letras(recomendado) ... NOMBRE cat�logo ?",sCatalogoManual)
          IF sCatalogoManual = "" THEN
            ggsLog = "X cat�logo no definido ..." ;CONTINUE
          ELSE
            arrAV[2] = sCatalogoManual
          END
        END
        IF nDebugTXT = Today() THEN Info("sP1L:",sP1L,"","sLineaAXXX=",sP1LAXXX,"Kata="+sP2L)
        // KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK

        // SUBE nube ----------------------------------
        Info("suspendido temporalmente...","SubeFORMA",arrAV,sP2L)
        //19 SubeFORMA(arrAV,sP2L)
        // --------------------------------------------


        IF pTareaAV = "A" THEN
          // asigna Codigo=automatico si arrAV[3] = vacio
          IF arrAV[3] = "?" THEN arrAV[3] = "" // Asegura
          IF arrAV[3] = "" THEN arrAV[3] = Right(Now(),5) + NumToString(nX)
          //IF nDebugTXT = Today() THEN Info("CIA="+arrAV[1],"K="+arrAV[2],"C="+arrAV[3],arrAV[4])
          //Info("CIA="+arrAV[1],"K="+arrAV[2],"C="+arrAV[3],arrAV[4])
        END
        // Asegura formato: SKU
        IF Upper(arrAV[2]) = "INVE" THEN
          arrAV[3] = Right("00000000"+arrAV[3],9)
        END

        sLineaAXXX = Replace(sLineaAXXX,";",",") // solo TXT_
        //Info("pTareaAV"+pTareaAV,"nX="+nX,sLineaAXXX,sBqueTXT)

        //////////////////////////// A ////////////////////////////
        IF pTareaAV = "A" THEN
          // Nota ---------------
          IF Upper(Right(arrAV[8],4)) = ".TXT" THEN
            arrAV[8] = TXT(">"+arrAV[8])
          END
          // Nota ---------------

          sBqueTXT = ""
          FOR i = 1 TO ArrayCount(arrAV)
            sBqueTXT = sBqueTXT + arrAV[i] + ","
          END
          sBqueTXT = sBqueTXT + Today() + "," + Now() + "," + ggsCia + CR
          fAddText(sNombreTXT,sBqueTXT) ;nY++
        END

        //////////////////////////// B y E ////////////////////////////
        // cuidado!   sBE ni sBqueTXT   deben usarse arriba  cuidado!
        //nDebugTXT = Today() = 2 ;Info("nX="+nX)
  			sCodigoTXT is string
        IF pTareaAV = "B" OR pTareaAV = "E" THEN
          IF nX = 1 THEN
            sBE = TXT(">"+sNombreTXT)

       //IF Upper(sNombreTXT) = "INVE.TXT" THEN nDebugTXT = Today() = 2
            IF nDebugTXT = Today() THEN Info("Solo en la vuelta num="+nX,"Busca="+sLineaAXXX,"En",sBE)

            IF sBE = "" THEN LOG("A","XAV_TXT_B "+sNombreTXT+" vacio") ;RESULT(ggsLog)
            //SBE = Replace(sBE,",",";")  // Asegura
            StringToArray(sBE,arrWTXT,CR) ;sBE = "" ;ggsLog = "OK" // Asegura
            //INFO("1 nX"+nX,"CODIGO="+arrAV[3],"sBqueTXT:",sBqueTXT)
          END
      //IF nX>1 THEN INFO("1 nX"+nX,"CODIGO="+arrAV[3],"sBqueTXT:",sBqueTXT)
      //nDebugTXT = Today() = 0

          // Busqueda por cada elemento de un arreglo ...
          // donde  arrWTXT <-- (t18.txt) sNombreTXT
          FOR EACH sRenglon OF arrWTXT
            IF sRenglon = "" THEN CONTINUE

            sSubRenglon is string = sRenglon
            nInicia is int = 1 // controla busqueda secundaria
            // (Llave) Definido CODIGO ... KATA ... CIA...
            IF arrAV[3] <> "" THEN
              // ,,123  ,CLIE,123  IP,CLIE,123
              // no importa lo que este despues de arrAV[3]
              sCodigoTXT = arrAV[1]+","+arrAV[2]+","+arrAV[3]+","
              nInicia = 0 // controla busqueda secundaria
            ELSE
              // IP,INVE,,item 1,12  ,INVE  ,INVE,,item 1
              // si importa lo contenido arrAV[4  ...  18]
              nInicia = 4 // controla busqueda secundaria
              IF arrAV[2] <> "" THEN
                sCodigoTXT = arrAV[1]+","+arrAV[2]+","
              ELSE
                // IP,,,item 1,12  IP,
                IF arrAV[1] <> "" THEN sCodigoTXT = arrAV[1]+","
              END
            END
            IF nDebugTXT = Today() THEN Info(sCodigoTXT,"en:",sSubRenglon,"="+Contains(sSubRenglon,sCodigoTXT,IgnoreCase),"",sBqueTXT)


            // Verifica si arrAV[4..n] tiene un valor que comparar...
            IF sCodigoTXT <> "" THEN
              FOR i = 4 TO ArrayCount(arrAV)
                sBE = sBE + NoSpace(arrAV[i])
              END

              // No hay mas campos que comparar que sCodigoTXT
              IF sBE = "" THEN
                IF Contains(sSubRenglon,sCodigoTXT,IgnoreCase) = True THEN
                  // I G U A L
                  IF pTareaAV = "B" THEN
                    nD++ // para BORRA, no es parte de nuevoTXT
                  ELSE
                    // para PRESENTA, si es parte
                    sBqueTXT = sBqueTXT + sSubRenglon + CR
                  END
                ELSE
                  // D E S I G U A L   ...inverso
                  IF pTareaAV = "B" THEN
                    sBqueTXT = sBqueTXT + sSubRenglon + CR
                  ELSE
                    nD++ // igual, no es parte de nuevoTXT
                  END
                END
                CONTINUE
              END // sBE=""

            END
            sBE = ""// Asegura


            IF nDebugTXT = Today() THEN Info(sRenglon,"sCodigoTXT="+sCodigoTXT,"","arrAV[1]"+arrAV[1],"arrAV[2]"+arrAV[2],"arrAV[3]"+arrAV[3])
            IF sCodigoTXT <> "" THEN
              IF Contains(sSubRenglon,sCodigoTXT,IgnoreCase) = True THEN
                IF nInicia = 0 THEN
                  IF pTareaAV = "B" THEN nD++ ;CONTINUE // igual, no es parte de nuevoTXT
                  sBqueTXT = sBqueTXT + sSubRenglon
                END
              ELSE
                // Des igual... continua analisis en     sSubRenglon
                // NO       IF pTareaAV = "B" THEN ...
              END
            END
            //IF nDebugTXT = Today() THEN info("nInicia="+nInicia,"sBqueTXT ...",sBqueTXT)
            IF nInicia = 0 THEN
              // Desigual... si es parte de nuevoTXT
              IF pTareaAV = "B" THEN sBqueTXT = sBqueTXT + sSubRenglon + CR ELSE nD++
              CONTINUE
            END
            //IF nDebugTXT = Today() THEN info("nInicia="+nInicia,"Busca:",arrAV[4]+","+arrAV[5]+","+arrAV[6],"en:",sSubRenglon)
            bComparo is boolean
            FOR i = nInicia TO ArrayCount(arrAV)
              IF arrAV[i] = "" THEN CONTINUE
              bComparo = True // comparo 1 campo por lo menos
              IF Contains(sSubRenglon,arrAV[i],IgnoreCase) = True THEN
                IF pTareaAV = "B" THEN BREAK // coincide, no es parte de nuevoTXT
                sBqueTXT = sBqueTXT + sSubRenglon + CR
                BREAK
              END
            END
            IF NOT bComparo AND nInicia = 4 THEN
              // Vuelve a comparar  pero ahora con sCodigoTXT
              IF Contains(sSubRenglon,sCodigoTXT,IgnoreCase) = True THEN
                IF pTareaAV = "B" THEN nD++ ;CONTINUE // coincide, no es parte de nuevoTXT
                sBqueTXT = sBqueTXT + sSubRenglon + CR ;nY++
              ELSE
                // no coincide, si es parte de nuevoTXT
                IF pTareaAV = "B" THEN sBqueTXT = sBqueTXT + sSubRenglon + CR
              END
            END

          END // for RENGLON
        END // B y E

      END // ciclo FOR sP1L

      IF nX > 0 THEN
        IF pTareaAV = "E" THEN
          ggsLog = "OK E regs: "+nY
          IF sBqueTXT <> "" THEN
            // Asegura formato universal
            sBqueTXT = Replace(sBqueTXT,"," , ";")
            fSaveText("txt_e.txt",sBqueTXT)

            // Formato  IMPORTA ...
            //           5 6 7              14 15
            // cia,K,C,D,m,n,f,F20,N,c,d,f,g,m,n
            SCamposNum is string = "C5C C6C C7C C14C C15C"
            sNvoTXT is string
            FOR EACH STRING sR OF sBqueTXT SEPARATED BY CR
              IF sR = "" THEN CONTINUE

              // sR --> arrAV[1...18   ;2;"item 2";15 INVE
              S2A(Replace(sR,",",";"),arrAV)
              FOR i = 1 _TO_ ArrayCount(arrAV)
                IF NOT Contains(SCamposNum,"C"+NumToString(i)+"C",WholeWord) THEN
                  //arrAV[i] = TXT(Charact(34)+"-"+arrAV[i])
                  sNvoTXT = sNvoTXT + Charact(34)+arrAV[i]+Charact(34) + ","
                ELSE
                  sNvoTXT = sNvoTXT + arrAV[i] + ","
                END
              END
              sNvoTXT = sNvoTXT + CR
            END // FOR

            fSaveText("txtI_e.txt",sNvoTXT) // para ser usado con IMPORT
          END // sBqueTXT <> ""
        END // E
        IF pTareaAV = "B" THEN fSaveText(sNombreTXT,sBqueTXT) ;ggsLog = "OK B regs: "+nD
      ELSE
        ggsLog = "XATXT ningun registro procesado"
      END
      //LOG("A",ggslog)




    CASE "X"
      fDelete(sP1l,frToRecycleBin)


    OTHER CASE: ggsLog = "X "+pTareaAV+" no definido en zzOw_TXT ..."
  END
  RESULT(ggsLog)  // MUY IMPORTANTE PARA QUE NO SE SIGA DE LARGO
END  // if TXT_A,B,E
///////////////////// TXTabe /////////////////////

////////// I m p o r t a     E x p o r t a  //////////
//		TXT("I*CLIE") 	// Importa de "txtI_e.txt"
//		Info(ggsLog)
//		TXT("E*CLIE")	// Exporta a "txt_e.txt"
//		Info(ggsLog)
IF Left(pArchivo,2) = "I*" OR Left(pArchivo,2) = "E*" THEN
  pTareaAV is string = Upper(Left(pArchivo,1))
	pArchivo = Right(pArchivo,Length(pArchivo)-2)	// quita I* E�*

	ggsLog = "OK Importa"
	IF pTareaAV = "I" THEN
		IF fFileExist("avw.fic") THEN
			pArchivo = pArchivo+".FIC"
			HCopyFile("",pArchivo,"","avw.fic",hCopyIndex)	// borra si ya existe
			Destino is Data Source
			IF HDeclareExternal(pArchivo,Destino) THEN
				// NO SENCIBLE a mayusculas y minusculas pero si columnas existentes
				// ORDEN como aparecen en origen... lee solo numero de columnas en destino
				IF NOT HImportText(Destino,"txtI_e.txt","TDA,cata,codigo,descripcion,val1,val2,flag,flagC20,nota",hImpIgnoreInvalidLine) THEN
					LOG("A","XImporta (AV)")
				END
			ELSE
				LOG("A","XI (AV) declaracion externa")
			END
		ELSE
			LOG("A","XI (AV)"+"Ausente avw.fic")
		END
		RESULT(ggsLog)
	END

	ggsLog = "OK Exporta"
	IF pTareaAV = "E" THEN
    pArchivo = pArchivo+".FIC"
    IF fFileExist(pArchivo) THEN
      fSaveText("txt_e.txt","") // Asegura
			ORI is Data Source
			IF HDeclareExternal(pArchivo,ORI) THEN
        FOR EACH ORI
          sBE = sBE + ORI.tda+";"+ORI.cata+";"+ORI.codigo+";"+...
            ORI.descripcion+";"+ORI.val1+";"+ORI.val2+";"+...
            ORI.flag+";"+ORI.flagC20+";"+ORI.nota+";"+...
            ";;;" + CR
        END
			END
			fSaveText("txt_e.txt",sBE)
		ELSE
			LOG("A","XE (AV)"+"Ausente "+pArchivo)
    END // existe
  ELSE
		LOG("A","XE (AV)"+"Ausente "+pArchivo)
	END

	RESULT(ggsLog)
END

IF Left(pArchivo,2) = "L*" OR Left(pArchivo,2) = "S*" THEN
  pTareaAV is string = Upper(Left(pArchivo,1))
	pArchivo = Right(pArchivo,Length(pArchivo)-2)	// quita I* E�*

  IF NOT HOpenAnalysis("wXML.WDD") THEN
    LOG("A","XL(av) imposible abrir WDD")
    RESULT(ggsLog)
  END

	ggsLog = "OK Load(importa)"
	IF pTareaAV = "L" THEN
    HChangeName("twe",pArchivo)
    HCreationIfNotFound("twe")

				IF NOT HImportText("twe","txtI_e.txt","TDA,cata,codigo,descripcion,val1,val2,flag,flagC20,nota",hImpIgnoreInvalidLine) THEN
					LOG("A","XImporta LOAD (AV)")
				END

  END
	RESULT(ggsLog)
END



//  S E L E C C I O N
IF Left(pArchivo,2) = "?." THEN
	SWITCH Upper(Right(pArchivo,4))
    CASE "?."
      // Selecciona todos  ...Creado con el wiser
      //   inicial_En, sugerido,    titulo 2, ayuda dercha
      pArchivo = fSelect("", "", ...
      "Seleccione un archivo ...", ...
      "Texto Enrriquecido" + TAB + "*.RTF" + CR + "Texto" + TAB + "*.TXT" +...
       CR + "word" + TAB + "*.DOCX" + CR + "todos" + TAB + "*.*"+...
       CR + "Imagen" + TAB + "*.jpg" + CR + "XML" + TAB + "*.xml",...
       "*.RTF")


    CASE ".JPG"
			pArchivo = fSelect(fCurrentDir(), "","Seleccione un archivo ...", ...
			"Imagen (*.jpg)" + TAB + "*.jpg" + CR + "todos" + TAB + "*.*", "jpg")
    CASE ".DIR"
      pArchivo = fSelectDir(fExeDir(),"Selccione...","")
      IniWrite("SELECCION","DIR",pArchivo,ggsINI)

		CASE ".DOC","DOCX"
			pArchivo = fSelect(fCurrentDir(), "","Seleccione un archivo ...", ...
			"Word (*.DOCX)" + TAB + "*.docx" + CR + "Word97 (*.DOC)" + TAB +"*.doc" + CR + "todos" + TAB + "*.*", "docx")
		CASE ".RTF"
			pArchivo = fSelect(fCurrentDir(), "","Seleccione un archivo ...", ...
			"Texto enrriquecido (*.RTF)" + TAB + "*.rtf" + CR + "todos" + TAB + "*.*", "rtf")
		CASE ".TXT"
			pArchivo = fSelect(fCurrentDir(), "","Seleccione un archivo ...", ...
			"Text (*.TXT)" + TAB + "*.txt" + CR + "todos" + TAB + "*.*", "txt")
		CASE ".XML"
			pArchivo = fSelect(fCurrentDir(), "","Seleccione un archivo ...", ...
			"XML (*.XML)" + TAB + "*.xml" + CR + "todos" + TAB + "*.*", "xml")
		CASE ".ZIP"
			pArchivo = fSelect(fCurrentDir(), "","Seleccione un archivo ...", ...
			"ZIP (*.ZIP)" + TAB + "*.zip" + CR + "RAR (*.RAR)" + TAB +...
			 ".rar" + CR + "todos" + TAB + "*.*", "zip")
		OTHER CASE
			pArchivo = fSelect(fCurrentDir(), "","Seleccione un archivo ...", ...
			"todos" + TAB + "*.*", "txt")
	END
	IF pArchivo = "" THEN ggsLog = "X nada seleccionado" ;RESULT("")
  IF Upper(Right(pArchivo,4)) <> ".DIR" THEN
    IniWrite("AV","FILE",pArchivo,ggsINI)
  ELSE
    IniWrite("AV","DIR",pArchivo,ggsINI)
  END
  ggsLog = pArchivo // con camino ...

  IniWrite("AV","Nombre",fExtractPath(pArchivo, fFileName),ggsINI)
  IniWrite("AV","Extencion",fExtractPath(pArchivo, fExtension),ggsINI)
  IniWrite("AV","Directorio",fExtractPath(pArchivo, fDirectory),ggsINI)
  IniWrite("AV","Unidad",fExtractPath(pArchivo, fDrive),ggsINI)
  IniWrite("AV","UD",fExtractPath(pArchivo, fDrive+fDirectory),ggsINI)
	IF fExtractPath(pArchivo, fDrive + fDirectory) = fCurrentDir()+[fSep] THEN
		RESULT(fExtractPath(pArchivo, fFileName+fExtension)) // solo archivo
	ELSE
		RESULT(pArchivo)
	END
END


//  C O N T E N I D O
IF Left(pArchivo,1) = ">" THEN
	pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita >

	ggsLog = ""
	//180926
	// Quita ; izquierda y derecha
	pArchivo = TXT(Charact(34)+"-"+pArchivo)
	IF pArchivo = "" THEN ggsLog = "VACIO" ;RESULT(pArchivo)
	ggbExisteOrigenE = False
	IF Contains(pArchivo,";") THEN RESULT(pArchivo)
	IF Contains(pArchivo,",") THEN RESULT(pArchivo)
	//IF Contains(pArchivo,CR) THEN RESULT(pArchivo)

	IF nDebugTXT = Today() THEN Info("(Contenido) pArchivo: "+pArchivo)
	// Sobra ?
	IF Left(pArchivo,2) = "?." THEN
    	   sArSel = TXT(pArchivo)
    	   IF sArSel = "" THEN RESULT("")
    	   pArchivo = sArSel
	END


	ggsLog = "OK contenido"
  sContenido is string
  sDelimitador is string

// Verifica si el archivo existe 190803
IF fDir(pArchivo) = "" THEN
   // Demostracion
   //Info("1="+fDir(pArchivo),"2="+fDir("./"+pArchivo),"3="+fDir(".\"+pArchivo),"4="+fDir(fCurrentDir+[fSep]+"\"+pArchivo),fCurrentDir+[fSep]+pArchivo,fCurrentDir+[fSep]+"/"+pArchivo)
   LOG("A","X Inexistente archivo: "+pArchivo,nDebugTXT)
   RESULT(pArchivo) //190819 ? lo deberia regresar vacio ???????????????
END



  pArchivo = Replace(pArchivo,"/","\")
  IF Right(pArchivo,1) = "\" THEN
      // DIRECTORIO
      IF NOT fDirectoryExist(pArchivo) THEN
        LOG("A","X> inexistente dir: "+pArchivo)
        RESULT("")
      ELSE
        LOG("A","OK> dir: "+pArchivo)
        ggbExisteOrigenE = True
        RESULT(fListDirectory(pArchivo))
      END
  ELSE
      // ARCHIVO / Cadena ...
      sExt is string = fExtractPath(pArchivo, fExtension)
      IF VAL(sExt) > 0 THEN sExt = ""
      IF sExt = "" THEN sExt = "TXT" //180925 txt extencion oculta ...
      IF nDebugTXT = Today() THEN Info("extencion="+sExt)
      IF sExt <> "" THEN
        // Archivo
        IF Left(pArchivo,1) = "*" THEN
          // Valida camino ...
          pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita *

          // Asigna camino si esta en raiz ...
          IF fExtractPath(pArchivo, fDrive + fDirectory) = "" THEN
            pArchivo = fCurrentDir()+[fSep]+pArchivo
          END
          IF NOT fFileExist(pArchivo) THEN
            ggsLog = "X inexistente "+ pArchivo
            pArchivo = ""
          END
        ELSE
          IF NOT fFileExist(pArchivo) THEN
            IF NOT fFileExist(fCurrentDir()+[fSep]+pArchivo) THEN
              ggsLog = "X inexistente "+ fCurrentDir()+[fSep]+pArchivo
              pArchivo = ""
            END
          END
        END

        // Busca
        IF pArchivo <> "" THEN
          // Encuentra
          IF nDebugTXT = Today() THEN Info("existe: "+pArchivo)
          ggbExisteOrigenE = True

          IniWrite("AV","Nombre",fExtractPath(pArchivo, fFileName),ggsINI)
          IniWrite("AV","Extencion",fExtractPath(pArchivo, fExtension),ggsINI)
          IniWrite("AV","Directorio",fExtractPath(pArchivo, fDirectory),ggsINI)
          IniWrite("AV","Unidad",fExtractPath(pArchivo, fDrive),ggsINI)
          IniWrite("AV","UD",fExtractPath(pArchivo, fDrive+fDirectory),ggsINI)

          SWITCH Upper(Right(pArchivo,4))
          CASE ".HTM","HTML"
            Info(Upper(Right(pArchivo,4))+" contenido en construccion ...")
          CASE ".RTF"
            Info(Upper(Right(pArchivo,4))+" contenido en construccion ...")
          CASE ".TXT",".CSV"
            sContenido = fLoadText(pArchivo)
          CASE ".XML"
            info("pr generar contenido XML ...")

          OTHER CASE
            // 180925 TXT con extencion oculta de casualidad ...
            sContenido = fLoadText(pArchivo)
            ggsLog = "X contenido solo de HTML, RTF, CSV/TXT, XML"
          END
        END
        IF nDebugTXT = Today() THEN Info("Contenido de "+pArchivo,"",sContenido)
      ELSE
        // Cambia por retorneos de carro ...
        IF Contains(pArchivo,"|") THEN pArchivo = Replace(pArchivo,"|",CR)
        sContenido = pArchivo
      END



      IF sContenido <> "" THEN
          // Extrae numero de campos ...
          nCampos is int
          FOR EACH STRING sLinea OF sContenido SEPARATED BY CR
            IF sLinea = "" THEN CONTINUE

            arrCampo is array of ANSI string
            S2A(sLinea,arrCampo)
            nCampos = ArrayCount(arrCampo)
            IF nDebugTXT = Today() THEN
              Info(nCampos+...
              "   elementos donde el primero es:  ",arrCampo[1]+...
              "   de la linea:  "+sLinea)
            END
            BREAK
          END

          IniWrite("AV","Campos",NumToString(nCampos),ggsINI)

          IF Contains(sContenido,"|") THEN sDelimitador = "|"

          IF Contains(sContenido,";") AND sDelimitador = "" THEN sDelimitador = ";"
          IF Contains(sContenido,"/") AND sDelimitador = "" THEN sDelimitador = "/"
          IF Contains(sContenido,"\") AND sDelimitador = "" THEN sDelimitador = "\"
          IF Contains(sContenido,",") AND sDelimitador = "" THEN sDelimitador = ","
          IF Contains(sContenido,"�") AND sDelimitador = "" THEN sDelimitador = "�"
          IF Contains(sContenido,"�") AND sDelimitador = "" THEN sDelimitador = "�"
          IF Contains(sContenido,"~") AND sDelimitador = "" THEN sDelimitador = "~"
          IF Contains(sContenido,"_") AND sDelimitador = "" THEN sDelimitador = "_"

          IF Contains(sContenido,CR) AND sDelimitador = "" THEN sDelimitador = CR
          IF Contains(sContenido,TAB) AND sDelimitador = "" THEN sDelimitador = TAB
          INIWrite("AV","Delimitador",sDelimitador,ggsIni)
      END

      RESULT(sContenido)  // contenido

  END
END











// DIR existe ...  CREA
IF Left(pArchivo,1) = "+" THEN
	ggsLog = "OK directorio ya existe"
	While Left(pArchivo,1) = "+"
    pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita + >
	END

  pArchivo = Replace(pArchivo,"/","\")
  IF Left(pArchivo,1) = "\" THEN
    pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita \ >
	END
  pArchivo = Replace(pArchivo,"\\","\")

  // determina si es DIR vs FIL
  IF NOT Right(pArchivo,1) = "\" THEN
    // A R C H I V O
    IF fExtractPath(pArchivo, fDrive + fDirectory) = "" THEN
      pArchivo = fCurrentDir()+[fSep]+pArchivo
    END
    sBE = fExtractPath(pArchivo, fDrive + fDirectory)
    IF NOT fDirectoryExist(sBE) THEN
      IF fMakeDir(sBE) = False THEN
        INIWrite("CONSOLA","ERROR",ErrorInfo(),ggsINI)
        LOG("A","XCrea "+pArchivo)
        LOG("A","X "+ErrorInfo())
        RESULT("")
      END
    END

    IF NOT fFileExist(pArchivo) THEN
      //nArchivoID = fCreate(pArchivo)  // si existe lo sobre escribe vacio
      nArchivoID = fOpen(pArchivo,foCreateIfNotExist+foReadWrite)
      IF nArchivoID = -1 THEN
        INIWrite("CONSOLA","ERROR",ErrorInfo(),ggsINI)
        RESULT("")
      END
    ELSE
      LOG("A","ERROR=Ya existia: "+pArchivo)
    END
    RESULT(pArchivo)
  END


  // D I R E C T O R I O
	IF NOT fDirectoryExist(pArchivo) THEN
    //Info("No existe ...")
    //180830
    //ggsLog = "X directorio inexistente  "+pArchivo
    //INIWrite("S","DIR","",ggsIni)
    //RESULT(pArchivo) // listo para crearlo
    IF fMakeDir(pArchivo) = False THEN
      LOG("A","X "+ErrorInfo())
      LOG("A","XCrea "+pArchivo)
      INIWrite("S","DIR",pArchivo+" ...error en log",ggsIni)
      pArchivo = "" ; RESULT("")
    ELSE
      INIWrite("S","DIR",pArchivo+" ...Creado",ggsIni)
    END
  ELSE
    INIWrite("S","DIR",pArchivo+" ...ya existie",ggsIni)
  END

  IniWrite("AV","Nombre",fExtractPath(pArchivo, fFileName),ggsINI)
  IniWrite("AV","Extencion",fExtractPath(pArchivo, fExtension),ggsINI)
  IniWrite("AV","Directorio",fExtractPath(pArchivo, fDirectory),ggsINI)
  IniWrite("AV","Unidad",fExtractPath(pArchivo, fDrive),ggsINI)
  IniWrite("AV","UD",fExtractPath(pArchivo, fDrive+fDirectory),ggsINI)

  RESULT("") // vacio=ya existe
END // cREA


// DIR existe ...  BORRA
IF Left(pArchivo,1) = "-" THEN
	ggsLog = "OK directorio ya existe"
	While Left(pArchivo,1) = "-"
    pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita + >
	END

  pArchivo = Replace(pArchivo,"/","\")
  IF Left(pArchivo,1) = "\" THEN
    pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita \ >
	END
  pArchivo = Replace(pArchivo,"\\","\")

  // determina si es DIR vs FIL
  IF NOT Right(pArchivo,1) = "\" THEN
    // A R C H I V O
    IF fExtractPath(pArchivo, fDrive + fDirectory) = "" THEN
      pArchivo = fCurrentDir()+[fSep]+pArchivo
    END
    sBE = fExtractPath(pArchivo, fDrive + fDirectory)
    IF fDirectoryExist(sBE) THEN
      IF NOT fDelete(pArchivo) THEN
        INIWrite("CONSOLA","ERROR",ErrorInfo(),ggsINI)
      END
    ELSE
      INIWrite("CONSOLA","ERROR","INEXISTENTE",ggsINI)
    END

    RESULT(pArchivo)
  END

  // DIRECTORIO
	IF fDirectoryExist(pArchivo) THEN
    IF fRemoveDir(pArchivo) = False THEN
      LOG("A","X BORRADO: "+pArchivo)
      LOG("A","X "+ErrorInfo())
      INIWrite("S","DIR",pArchivo+" ...error en log",ggsIni)
      pArchivo = "" ; RESULT("")
    ELSE
      INIWrite("S","DIR",pArchivo+" ...Borrado",ggsIni)
    END
    LOG("A","OK directorio BORRADO: "+pArchivo)
  ELSE
    INIWrite("S","DIR",pArchivo+" ...Inexistente",ggsIni)
    LOG("A","OK directorio inexistente: "+pArchivo)
  END
  RESULT("")
END // Bora


// ZIP...
IF Left(pArchivo,2) = ">>" OR Left(pArchivo,2) = "<<" THEN
	ggsLog = "OK zip"
	// Respalda gapE[1](original) ... sera modificado BASE ZIP
  sTarea is string

  // forma ZIP / extrae ZIP
  sTarea = "A"
  IF Left(pArchivo,2) = "<<" THEN sTarea = "E"

  // Limpia banderas
	While Left(pArchivo,1) = ">>"
    pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita + >
	END
	While Left(pArchivo,1) = "<<"
    pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita + >
	END

  pArchivo = Replace(pArchivo,"/","\")
  pArchivo = Replace(pArchivo,"\\","\")  // autocorrige

  // Uso codigo BASE ZIP_A, ZIP_E ... procedimiento: ZIP_
//18  ZIP_(sTarea ,pArchivo)
  nErrZIP is int
	SWITCH sTarea
		CASE "": RESULT("Xzip parametros vacios")
		CASE "?"
			Info("ZIP_A [contenido nombreZIP;1=none/9=drive;compresion]")
		CASE "A"
			nErrZIP = zipCreate("zip", RIght(Now(),5)+".zip")
			IF nErrZIP = 0 THEN

        // Contenido ... archivos a zipiar
        IF Contains(pArchivo,",") THEN pArchivo = Replace(pArchivo,",",CR)
        IF Contains(pArchivo,";") THEN pArchivo = Replace(pArchivo,";",CR)
        IF Contains(pArchivo,"|") THEN pArchivo = Replace(pArchivo,"|",CR)
        IF Contains(pArchivo,"~") THEN pArchivo = Replace(pArchivo,"~",CR)
        pArchivo = pArchivo + CR

				FOR EACH STRING sArchivo OF pArchivo SEPARATED BY CR
          IF sArchivo = "" THEN CONTINUE
          SWITCH 1 //Val(arrParamAux[2])
          CASE 1: nErrZIP = zipAddFile("zip",sArchivo,zipNone)
          CASE 2: nErrZIP = zipAddFile("zip",sArchivo,zipDrive)
          OTHER CASE: nErrZIP = zipAddFile("zip",sArchivo,zipDirectory) // default
          END
				END
			END
      IF nErrZIP THEN
        LOG("A","Xzip "+zipMsgError(nErrZIP))
      END

		CASE "B"

		CASE "E"
			//nErrZIP = zipOpenRAR("zip", pArchivo)
			nErrZIP = zipOpen("zip", pArchivo)
			IF nErrZIP = 0 THEN
        // Directorio EXE crea carpeta con arbol zip...
        nErrZIP = zipExtractAll("Zip", zipDirectory)
      ELSE
        //ggsLog = "Xzip zipOpenRar "+zipMsgError(nErrZIP)
        LOG("A","Xzip zipOpenRar "+zipMsgError(nErrZIP))
        RESULT(ggsLog)
			END
      IF nErrZIP THEN
        LOG("A","Xzip "+zipMsgError(nErrZIP))
        RESULT(ggsLog)
      END
      info("extraido: "+pArchivo)

		CASE "X"

		OTHER CASE: ErrorWithTimeout(600,sTarea+"<-- comando desconocido zzOw_ZIP") //;RETURN
	END

  //IF ggsLog = "X" THEN ERROR(ggsLog)
  RESULT(ggsLog)
END // zip


/////////////////////////// Doble Comilla ///////////////////////////
IF Left(pArchivo,1) = Charact(34) THEN
  				//Info(pArchivo)
  IF Length(pArchivo) = 1 THEN pArchivo = "" ;RESULT(pArchivo)

  IF Middle(pArchivo,2,1) = "+"
    IF Length(pArchivo) = 2 THEN pArchivo = Charact(34)+Charact(34) ; RESULT(pArchivo)

    pArchivo = Right(pArchivo,Length(pArchivo)-2)	// quita "+

  				//Info(pArchivo)
    WHILE Left(pArchivo,1) = Charact(34)
      pArchivo = Right(pArchivo,Length(pArchivo)-1)
    END
    WHILE Right(pArchivo,1) = Charact(34)
      pArchivo = Left(pArchivo,Length(pArchivo)-1)
    END
//  Info(pArchivo,"",Asc(Right(pArchivo,1)))
    pArchivo = Charact(34)+pArchivo+Charact(34)
//  Info("4",pArchivo)
  END
  IF Middle(pArchivo,2,1) = "-"
    IF Length(pArchivo) = 2 THEN pArchivo = "" ;RESULT(pArchivo)

    pArchivo = Right(pArchivo,Length(pArchivo)-2)	// quita "-

    WHILE Left(pArchivo,1) = Charact(34)
      pArchivo = Right(pArchivo,Length(pArchivo)-1)
    END
    WHILE Right(pArchivo,1) = Charact(34)
      pArchivo = Left(pArchivo,Length(pArchivo)-1)
    END
  END
  RESULT(pArchivo)
END


//  A B S O L U T O
IF Left(pArchivo,1) = "*" THEN
  ggsLog = "OK valida archivo"
	// Valida camino ...
	pArchivo = Right(pArchivo,Length(pArchivo)-1)	// quita *

	// Asigna camino si esta en raiz ...
	IF fExtractPath(pArchivo, fDrive + fDirectory) = "" THEN
		pArchivo = fCurrentDir()+[fSep]+pArchivo
	END
	IF NOT fFileExist(pArchivo) THEN
    ggsLog = "X inexistente "+ pArchivo
    pArchivo = ""
  END
ELSE
	IF NOT fFileExist(pArchivo) THEN
    IF nDebugTXT = Today() THEN Info("NO existe como: "+pArchivo)
		IF NOT fFileExist(fCurrentDir()+[fSep]+pArchivo) THEN
      ggsLog = "X inexistente "+ fCurrentDir()+[fSep]+pArchivo
			pArchivo = ""
		END
	ELSE
    IF nDebugTXT = Today() THEN Info("SI existe como: "+pArchivo)
	END
END

IF nDebugTXT = Today() THEN Info(pArchivo,fExtractPath(pArchivo, fDrive + fDirectory))
IniWrite("S","FILE",pArchivo,ggsINI)

IF pArchivo <> "" THEN
  IniWrite("AV","Nombre",fExtractPath(pArchivo, fFileName),ggsINI)
  IniWrite("AV","Extencion",fExtractPath(pArchivo, fExtension),ggsINI)
  IniWrite("AV","Directorio",fExtractPath(pArchivo, fDirectory),ggsINI)
  IniWrite("AV","Unidad",fExtractPath(pArchivo, fDrive),ggsINI)
  IniWrite("AV","UD",fExtractPath(pArchivo, fDrive+fDirectory),ggsINI)
END

IF fExtractPath(pArchivo, fDrive + fDirectory) = fCurrentDir()+[fSep] THEN
	RESULT(fExtractPath(pArchivo, fFileName+fExtension))
ELSE
	RESULT(pArchivo)
END





  /////////////////////////// Doble Comilla ///////////////////////////
  // "INVE;;Art 1;11.5" <-- nunca pasa por sigiente procedimiento
  // algo.txt
  ///////////////////////////////////////////////////////////////////
  // "INVE;;Art 1;11.5" nulo cb
  // ";;Art 1;11.5|;;Art 2;12.5" INVE CB
  ///////////////////////////////////////////////////////////////////
//INTERNAL PROCEDURE SEPARA(pLinea)


//  IF Left(pLinea,1) = Charact(34) AND Right(pLinea,1) = Charact(34) THEN
//    pLinea = Middle(pLinea,2,Length(pLinea)-2)

//  END





// EJEMPLOS
//TXT("TXT_BK=") // borra todo




///////////////////////////////////
//    Codigo de referencia
///////////////////////////////////

//	// Busqueda en arreglos ...
//	// Debe COINCIDIR EXACTAMENTE contenido elemento del arreglo con BUSQUEDA
//	nDebugTXT = Today() = 2
//	sBE = fLoadText(sArSel)
//	IF sBE = "" THEN CONTINUE
//	StringToArray(sBE,arrAV,CR) //S2A(ggsA,ggArrT)
//	IF nDebugTXT = Today() THEN Info("ARREGLO arrAV="+ArrayCount(arrAV)+"      donde:","[1]="+arrAV[1],"[2]="+arrAV[2],"...","","BUSCA="+arrLinea[1]+","+arrLinea[2])
//	nBE = ArraySeek(arrAV, asLinearFirst, arrLinea[1]+","+arrLinea[2])
//	//nBE = ArraySeek(arrAV, asLinearFirst, "IPINVE,905851,art 3,31,,,,,20180802,21290902,IP")
//	IF nBE > 0 THEN
//		IF nDebugTXT = Today() THEN Info("Existe en:"+nBE,"BUSCA="+arrLinea[1]+","+arrLinea[2],"en:",sBE)
//	ELSE
//		IF nDebugTXT = Today() THEN Info("NO Existe","BUSCA="+arrLinea[1]+","+arrLinea[2],"en:",sBE)
//	END
//	nDebugTXT = Today() = 0

// VS

//	// Busqueda en archivo ...
//	// Si BUSQUEDA exite regresa posicion
//	nArchivoID = fOpen(sArSel,foReadWrite)
//	nBE = fFind(nArchivoID,"IPINVE,909022")  //;Info(nBE)

// vs

//	// Busqueda por cada elemento de un arreglo ...
//	// Si BUSQUEDA exite regresa posicion
//	FOR EACH sCampo OF arrAV
//		IF sCampo = "" THEN CONTINUE
//		Info(sCampo)
//	END
