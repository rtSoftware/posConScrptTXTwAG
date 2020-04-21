//EXTERN ".\zzW\IWtit\IWtit_ABRE.wl" // windows



// Ejecuta("ABRE")
// Ejecuta("ABRE","tarea;param1,2,3 ... n")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// Valida ...
IF gapA[1] = "" THEN gapA[1] = "HC"
// provisional ? (fase desarrollo)
//IF Upper(gapA[1]) NOT IN("BTN"  ,"ET","HC","TB",   "EDITA","RADI","SALVA","ZALI") THEN
//	Error(gapA[1]+"<-- tarea no definida filtro inicial en "+sCompilaTXT,"Sera asignada la tarea por defecto...")
//	//gapA[1] = ""
//END


{gestoyEn,indWindow}..Plane = gnCapa // capa
SWITCH gapA[1]
	CASE ~~"ET"
		///////////////////////// EDITA_TITULOS /////////////////////////
		IF NOT gnCapa THEN gnCapa = 5
    gsPCata = gapA[2]
    IF gsPCata = "" THEN
    	// Seleccion cat�logo
    	GR_btn1..Visible = False
    	{gestoyEn,indWindow}..Plane =  5
    ELSE
    	// Edicion ...
    	{gestoyEn,indWindow}..Plane =  4
    	Ejecuta("ABRE","EDITA")
    END
	CASE ~~"TB","TABLA"
		///////////////////////// TABLA MEMORIA /////////////////////////
		IF NOT gnCapa THEN gnCapa = 1
		{gestoyEn,indWindow}..Plane =  1
		ListDeleteAll(COMBO_TB)	// Asegura cambio de HC
		TableDeleteAll(TABLE_memoria)

	CASE ~~"HC","HOJA_CALCULO"
		///////////////////////// HOJA CALCULO /////////////////////////
		IF NOT gnCapa THEN gnCapa = 2
		{gestoyEn,indWindow}..Plane =  2
		ListDeleteAll(COMBO_HC)	// Asegura cambio de TB
		SpreadsheetDeleteAll(PSHEET_HC)
	CASE "HC_CREA"
		IF nDebug = Today() THEN Info("gapE[1]="+gapE[1],"gapA[1]="+gapA[1],gapA[1],"HC Nombre="+gapA[2])
		gbHojaNueva = False
		// Verica si ya esta hecha ...
		IF NOT gnHojaNum THEN
			PSHEET_HC..WorksheetName = gapA[2]
			gnHojaNum = 1
		ELSE
			SpreadsheetSelectWorksheet(PSHEET_HC,gapA[2])
			IF ErrorOccurred = False THEN gnHojaNum = PSHEET_HC..CurrentWorksheet; RETURN
			gnHojaNum = SpreadsheetAddWorksheet(PSHEET_HC,gapA[2])
			PSHEET_HC..CurrentWorksheet = gnHojaNum
		END
		gbHojaNueva = True
		IF nDebug = Today() THEN Info("CREA "+gapA[2],"","nUM: "+gnHojaNum,PSHEET_HC..WorksheetName)
	CASE "HC_HL"
		sa is array of ANSI string
		//S2A(gapA[2],sa)
		StringToArray(gapA[2],sa,";")
		IF ArrayCount(sa) < 2 THEN RETURN
		IF sa[1] = "" OR sa[2] = "" THEN RETURN
		IF sa[2] <> "" THEN
			SpreadsheetSelectPlus(PSHEET_HC,sa[1], sa[2])
		ELSE
			SpreadsheetSelectPlus(PSHEET_HC,sa[1])
		END


		//Retrieve the background and text colors in order to restore them after the highlighting
		nBrushColor is int = SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor)
		nTextColor is int = SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor)

		//Highlighting => yellow highlight and black text so that it remains readable
		SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor, LightYellow)
		SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, Black)

		Multitask(-100)

		SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor, nBrushColor)
		SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, nTextColor)

		SpreadsheetSelectMinus(PSHEET_HC)

		Multitask(-100)
	CASE "HC_OPEN"
		sFile is string

		// Opens the file picker
		sFile = fSelect("", "", "Seleccione un archivo...", "XLSX file (*.xlsx)" + TAB + "*.XLSX", "*.XLSX")

		IF sFile <> "" THEN
			SpreadsheetDeleteAll(PSHEET_HC)
			SpreadsheetLoad(PSHEET_HC, sFile)
			SpreadsheetClose(PSHEET_HC)	// ?
		END
	CASE "HC_TITULA"
		// Selecciona celda gapA[2], puede ser un rango de celdas...
		//		PSHEET_HC = gapA[2]
		//		// Define style ...
		//		SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentH, haCenter )
		//		SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentV, vaMiddle)
		//		SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor, LightBlue)
		//		SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, White)


		//Retrieves the font used in the selected cell
		//ToastDisplay("The font used in the D8 cell is " + SpreadsheetStyleSelection(PSHEET_HC, psheetFontName),toastLong,vaMiddle)


		// Celda/rango de celdas
		PSHEET_HC = gapA[2]
		//Defines a border for the selected cell
		ABorder.Color = LightRed
		ABorder.Thickness = 2
		ABorder.Line = LineSolid
		ABorder.Edges = BorderAll
		SpreadsheetBorderSelection(PSHEET_HC,ABorder)

		//SpreadsheetSelectMinus(PSHEET_HC)


		//Borders will be added around the new cells, therefore define the requested border
		//ABorder is a Border
		ABorder.Line = LineSolid
		ABorder.Color = Black
		ABorder.Edges = BorderRight + BorderLeft

		//Define the style and format of the cells for product captions
		SpreadsheetSelectPlus(PSHEET_HC,"B"+gnFirstLineForOrderLine, "B"+gnLastLineForOrderLine)
		SpreadsheetStyleSelection(PSHEET_HC,psheetBold, True)
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontSize, 12)
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontName, "Arial Narrow")
		SpreadsheetBorderSelection(PSHEET_HC,ABorder)
		SpreadsheetSelectMinus(PSHEET_HC)

		//Makes blink in highlighted yellow to see what was modified
		Ejecuta("HL","B"+gnFirstLineForOrderLine+";"+"B"+gnLastLineForOrderLine)

		//Define the style and format of the cells for quantities
		SpreadsheetSelectPlus(PSHEET_HC,"C"+gnFirstLineForOrderLine, "C"+gnLastLineForOrderLine)
		SpreadsheetStyleSelection(PSHEET_HC,psheetBold, True)
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontSize, 16)
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontName, "Arial Narrow")
		SpreadsheetBorderSelection(PSHEET_HC,ABorder)
		SpreadsheetSelectMinus(PSHEET_HC)

		//Makes blink in highlighted yellow to see what was modified
		//Highlight("C"+gnFirstLineForOrderLine, "C"+gnLastLineForOrderLine)
		Ejecuta("HL","C"+gnFirstLineForOrderLine+";"+"C"+gnLastLineForOrderLine)

		//Define the style and format of the cells for prices
		SpreadsheetSelectPlus(PSHEET_HC,"D"+gnFirstLineForOrderLine, "D"+gnLastLineForOrderLine)
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontSize, 16)
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontName, "Arial Narrow")
		SpreadsheetStyleSelection(PSHEET_HC,psheetBold, True)
		SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, DarkGray)
		SpreadsheetTypeAndMaskSelection(PSHEET_HC, typInputCurrency, "$ 999 999.99")
		SpreadsheetBorderSelection(PSHEET_HC,ABorder)
		SpreadsheetSelectMinus(PSHEET_HC)

		//Makes blink in highlighted yellow to see what was modified
		//Highlight("D"+gnFirstLineForOrderLine, "D"+gnLastLineForOrderLine)
		Ejecuta("HL","D"+gnFirstLineForOrderLine+";"+"D"+gnLastLineForOrderLine)


		//Write the total of each order line in bold

		SpreadsheetSelectPlus(PSHEET_HC,"E" + gnFirstLineForOrderLine, "E"+gnLastLineForOrderLine)
		//Define the style and format of the cells
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontSize, 16)
		SpreadsheetStyleSelection(PSHEET_HC,psheetFontName, "Arial Narrow")
		SpreadsheetStyleSelection(PSHEET_HC,psheetBold, True)
		SpreadsheetTypeAndMaskSelection(PSHEET_HC, typInputCurrency, "$ 999 999.99")
		SpreadsheetBorderSelection(PSHEET_HC,ABorder)
		SpreadsheetSelectMinus(PSHEET_HC)
	CASE "HC_SALVA","HC_CIERRA"
		sFile is string

		// Opens the file picker
		sFile = fSelect(fExeDir(), "", "Seleccione un Archivo...", "Excel / OpenOffice (*.xlsx)" + TAB + "*.xlsx", "*.xlsx",fselCreate)

		IF sFile <> "" THEN
			//The WLanguage SpreadsheetSave function is used to save the spreadsheet in an Excel or OpenOffice Calc file
			SpreadsheetSave(PSHEET_HC, sFile, psheetOverwriteAllowed)
		END
	CASE "HC_VNXE","HC_VNXI3"
		IF gsPCata = "VNXE" THEN ggsA = "EMPL" ELSE ggsA = "PROD"
		Ejecuta("ABRE","HC_CREA;"+ggsA+"(Uni)")
		IF NOT gbHojaNueva THEN RETURN
		gnHojaNum1 = gnHojaNum
		IF gsPCata = "VNXE" THEN ggsA = "EMPL" ELSE ggsA = "PROD"
		Ejecuta("ABRE","HC_CREA;"+ggsA+"($)")
		gnHojaNum2 = gnHojaNum
		PSHEET_HC..CurrentWorksheet = gnHojaNum1
		//Info("gnHojaNum1 ...",PSHEET_HC..WorksheetName,PSHEET_HC..CurrentWorksheet)
		PSHEET_HC..CurrentWorksheet = gnHojaNum2
		//Info("gnHojaNum2 ...",PSHEET_HC..WorksheetName,PSHEET_HC..CurrentWorksheet)


		sFecha = ""; nRow = 3 // Tituloa 1 a 2

		// T I T U L O
		PSHEET_HC..CurrentWorksheet = gnHojaNum1 	// EMPL(uni)
		PSHEET_HC["B"][1] = "Venta Unidades"
		PSHEET_HC..CurrentWorksheet = gnHojaNum2	// EMPL($)
		PSHEET_HC["B"][1] = "Venta Importes"

		nAsci=66; sLetra = "B"
		gsPCata = gapA[2]; Right(gapE[1],4)
		//if yesno("Presenta por ESTACION ?") THEN gsPCata = gsPCata+"S"  //0122


		// Rango
		sRango1,sRango2 is string
		nDia1,nDia2 is int

		sRango1 = CalendarPicker(Today(),"Fecha Inicial")
		IF sRango1 = "" THEN sRango2 = ""; RETURN
		sRango2 = CalendarPicker(Today(),"Fecha Final")
		IF sRango2 = "" THEN sRango2 = sRango1
		nDia1=DateToInteger(sRango1); nDia2=DateToInteger(sRango2)
		IF NOT YesNo("Procesa "+NumToString((nDia2-nDia1)+1)+" d�as ?") THEN RETURN

		nCol = 2; nRow = 3  // columna, renglon inicial
		ArrayDeleteAll(garrHC) // sku atravez RANGO
		FOR i = nDia1 TO nDia2
			ggsFECHA1 = IntegerToDate(i)
			Ejecuta("CALCULA",gsPCata)
			nCol++
			//info(ArrayCount(garrSku),nCol,ggsFECHA1)


			//;VNXER;91229_1493__107__1;GUA... ;9   ;8.67 ;1; Jumex     ;;3;_107;1493;;7501013174038;0;0;20191229  ... 23 Dic (S2)
			gsBloqueP = ""; gsPCata = "VNXE"

			// F O R M A
			FOR x = 1 _TO_ ArrayCount(garrSku)
				IF Length(gsPCata) = 4 THEN
					// Windows ... (diferente a Android)
					gsBloqueP = gsBloqueP+";"+gsPCata+";"+ggArrE3[x]+";"+garrLetra[x]+";"+...

					garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+...
					";;;;;"+garrRe[x]+";"+garrReU[x]+";"+ggsFECHA1+";"+Now()+CR
				ELSE IF Length(gsPCata) = 5
					// Windows ... (diferente a Android)
					gsBloqueP = gsBloqueP+";"+gsPCata+";"+ggArrE3[x]+";"+garrLetra[x]+";"+...

					garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+Left(garrSku[x],1)+...
					";;"+Left(garrSku[x],1)+";;;"+garrRe[x]+";"+garrReU[x]+";"+ggsFECHA1+";"+Now()+CR
				END
			END // for acumulado  ArrayCount(garrSku)

			// P R E S E N T A
			PSHEET_HC..CurrentWorksheet = gnHojaNum1	// EMPL(Uni)
			PSHEET_HC[2,nCol] = DateToString(ggsFECHA1)
			PSHEET_HC..CurrentWorksheet = gnHojaNum2	// EMPL(Uni)
			PSHEET_HC[2,nCol] = DateToString(ggsFECHA1)
			FOR EACH STRING sL OF gsBloqueP SEPARATED BY CR
				IF sL = "" THEN CONTINUE
				sa is array of ANSI string
				//S2A(sL,sa)
				StringToArray(sL,sa,";")
				IF ArrayCount(sa) < 17 THEN CONTINUE

				ggnT = ArraySeek(garrHC,asLinear,sa[3]) // num Empleado
				IF ggnT <= 0 THEN
					// N U E V O ...
					ArrayAdd(garrHC,sa[3]) ;ggnT = ArrayCount(garrHC)
					nRow += 1; ArrayAdd(arrRen,nRow)


					PSHEET_HC..CurrentWorksheet = gnHojaNum1	// EMPL(Uni)
					PSHEET_HC[nRow,1] = sa[4]	// num Empleado
					PSHEET_HC[nRow,2] = sa[3]	// Nombre Empleado
					PSHEET_HC[nRow,nCol] += Val(sa[7])

					PSHEET_HC..CurrentWorksheet = gnHojaNum2	// EMPL(Uni)
					PSHEET_HC[nRow,1] = sa[4]	// num Empleado
					PSHEET_HC[nRow,2] = sa[3]	// Nombre Empleado
					PSHEET_HC[nRow,nCol] += Val(sa[5])
				ELSE
					PSHEET_HC..CurrentWorksheet = gnHojaNum1	// EMPL(Uni)
					PSHEET_HC[arrRen[ggnT],nCol] += Val(sa[7])
					PSHEET_HC..CurrentWorksheet = gnHojaNum2	// EMPL(Uni)
					PSHEET_HC[arrRen[ggnT],nCol] += Val(sa[5])
				END
			END

		END


		IF ArrayCount(garrLetra) >= 0 THEN
			PSHEET_HC..CurrentWorksheet = gnHojaNum1	// EMPL(Uni)
			SpreadsheetSelectMinus(PSHEET_HC)			// Asegura
			SpreadsheetSelectPlus(PSHEET_HC,"B1")  		// Suma...
			SpreadsheetSelectPlus(PSHEET_HC,"A2","AA2")
			// Define estilo ...
			SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentH, haCenter )
			SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentV, vaMiddle)
			SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor, DarkPurple)
			SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, White)

			PSHEET_HC..CurrentWorksheet = gnHojaNum2	// EMPL($)
			SpreadsheetSelectMinus(PSHEET_HC)			// Asegura
			SpreadsheetSelectPlus(PSHEET_HC,"B1")  		// Suma...
			SpreadsheetSelectPlus(PSHEET_HC,"A2","AA2")
			// Define estilo ...
			SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentH, haCenter )
			SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentV, vaMiddle)
			SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor, DarkBrown)
			SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, White)
		END
		HourGlass(False)
		//19 MyWindow..Plane = 6  // necesario
	CASE "HC_VNXI"	//	HC_VNXI,V = ProductoVendido
		IF gapA[3] = "V" THEN Ejecuta("ABRE","HC_CREA;PROD Vendidos") ELSE Ejecuta("ABRE","HC_CREA;PROD Rechazados")
		IF NOT gbHojaNueva THEN Error("X crea hoja de calculo (ABRE:321545)"); RETURN	// se prende y apaga en HC_CREA

		sFecha = ""; nRow = 3 // Titulo 1 a 2

		// T I T U L O
		SpreadsheetSelectMinus(PSHEET_HC)		// Asegura -----------------------------
		SpreadsheetSelectPlus(PSHEET_HC,"B1")  //,"D1") rango
		// Define estilo ...
		SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentH, haCenter )
		SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentV, vaMiddle)
		SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor, DarkGreen)
		SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, White)
		SpreadsheetStyleSelection(PSHEET_HC, psheetBold, True)
		//SpreadsheetStyleSelection(PSHEET_HC, psheetFontSize, 12)
		SpreadsheetSelectMinus(PSHEET_HC)		// Limpia ------------------------------
		IF gapA[3] = "V" THEN PSHEET_HC[1][2] = "Venta Productos" ELSE PSHEET_HC[1][2] = "Ventas Rechazadas"

		// Rango
		sRango1,sRango2 is string
		nDia1,nDia2 is int

		sRango1 = CalendarPicker(Today(),"Fecha Inicial")
		IF sRango1 = "" THEN sRango2 = ""; RETURN
		sRango2 = CalendarPicker(Today(),"Fecha Final")
		IF sRango2 = "" THEN sRango2 = sRango1
		nDia1=DateToInteger(sRango1); nDia2=DateToInteger(sRango2)
		IF NOT YesNo("Procesa "+NumToString((nDia2-nDia1)+1)+" d�as ?") THEN RETURN

		gsPCata = "VNXI"
		nCol = 2; nRow = 3  // columna, renglon inicial
		ArrayDeleteAll(garrHC) // sku atravez RANGO
		FOR i = nDia1 TO nDia2
			ggsFECHA1 = IntegerToDate(i)
			Ejecuta("CALCULA",gsPCata)
			nCol++
			//info(ArrayCount(garrSku),nCol,ggsFECHA1)


			//;VNXER;91229_1493__107__1;GUA... ;9   ;8.67 ;1; Jumex     ;;3;_107;1493;;7501013174038;0;0;20191229  ... 23 Dic (S2)
			gsBloqueP = ""; gsPCata = "VNXE"

			// F O R M A
			FOR x = 1 _TO_ ArrayCount(garrSku)
				IF Length(gsPCata) = 4 THEN
					// Windows ... (diferente a Android)
					gsBloqueP = gsBloqueP+";"+gsPCata+";"+ggArrE3[x]+";"+garrLetra[x]+";"+...

					garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+...
					";;;;;"+garrRe[x]+";"+garrReU[x]+";"+ggsFECHA1+";"+Now()+CR
				ELSE IF Length(gsPCata) = 5
					// Windows ... (diferente a Android)
					gsBloqueP = gsBloqueP+";"+gsPCata+";"+ggArrE3[x]+";"+garrLetra[x]+";"+...

					garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+Left(garrSku[x],1)+...
					";;"+Left(garrSku[x],1)+";;;"+garrRe[x]+";"+garrReU[x]+";"+ggsFECHA1+";"+Now()+CR
				END
			END // for acumulado  ArrayCount(garrSku)

			// P R E S E N T A
			PSHEET_HC[2,nCol] = DateToString(ggsFECHA1)
			FOR EACH STRING sL OF gsBloqueP SEPARATED BY CR
				IF sL = "" THEN CONTINUE
				sa is array of ANSI string
				//S2A(sL,sa)
				StringToArray(sL,sa,";")
				IF ArrayCount(sa) > 17 THEN
					IF gapA[3] = "V" AND sa[7] = 0 THEN CONTINUE
					IF gapA[3] = "R" AND sa[16] = 0 THEN CONTINUE
					IF sa[2] <> "VNXI" THEN CONTINUE

					sSKU = Right("0000000000000"+sa[3],13)
					ggnT = ArraySeek(garrHC,asLinear,sa[3])
					IF NOT ggnT > 0 THEN
						// (Nuevo) garrSku <-- 0 750 123 456 789
						ArrayAdd(garrHC,sSKU) ;ggnT = ArrayCount(garrHC)
						ArrayAdd(arrRen,ggnT+nRow); nRow += 3

						PSHEET_HC[arrRen[ggnT],2] = sSKU	// sku
						PSHEET_HC[arrRen[ggnT]+1,2] = sa[4]	// descripcion
						PSHEET_HC[arrRen[ggnT]+2,2] = ""  	// libre
					END

					// Precio, Costo, Unidades ...
					IF gapA[3] = "V" THEN
						PSHEET_HC[arrRen[ggnT],nCol] += Val(sa[5])
						PSHEET_HC[arrRen[ggnT]+1,nCol] += Val(sa[6])
						PSHEET_HC[arrRen[ggnT]+2,nCol] += Val(sa[7])
					ELSE
						PSHEET_HC[arrRen[ggnT],nCol] += Val(sa[15])
						PSHEET_HC[arrRen[ggnT]+2,nCol] += Val(sa[16])
					END
				END
			END

		END // Rango



		SpreadsheetSelectMinus(PSHEET_HC)		// Asegura
		SpreadsheetSelectPlus(PSHEET_HC,"B1")  // Suma...
		SpreadsheetSelectPlus(PSHEET_HC,"A2","AA2")
		// Define estilo ...
		SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentH, haCenter )
		SpreadsheetStyleSelection(PSHEET_HC,psheetAlignmentV, vaMiddle)
		SpreadsheetStyleSelection(PSHEET_HC,psheetBackgroundColor, DarkGreen)
		SpreadsheetStyleSelection(PSHEET_HC,psheetTextColor, White)

		HourGlass(False)
		//19 MyWindow..Plane = 6	// necesario

	CASE "VNXER2ARR": Error("Proceso en des uso ... traspasado a ws Francia")
	CASE "VNXER2VNXI": Error("Proceso en des uso ... traspasado a ws Francia")

	CASE "BXMUESTRA"
		// Purga ...
		IF Now() < 1000000 AND NOT ggbSimula THEN
			gsBloqueP = ""
			ggbFlash_m = True; Ejecuta("H","DELETE FROM lWe WHERE fecha<"+IntegerToDate(DateToInteger(Today())-45))
			IF gbProduccion THEN Info(ggsLog,Left(gsBloqueP,399),"",IntegerToDate(DateToInteger(Today())-45))
		END


		sFcha1,sFcha2 is string
		// Provisonal...
		IF gbProduccion THEN
			IF YesNo("Actualizo con DATA en S2 ?") THEN
				sFcha1 = IntegerToDate(DateToInteger(Today())-1) //; info(sFcha1)
                gsBloqueP = ""
				ggsDBtemp = "HIF"; ggsDB4Temp = "S2"
				ggbFlash_m = False; ggbFlash_n = False
				Ejecuta("H","SELECT * FROM kWe WHERE fecha>20200107")
				Info(ggsLog,Left(gsBloqueP,399))
				IF gsBloqueP <> "" THEN
					sActualiza is string = gsBloqueP
					IF YesNo("Actualizo nube K2 ?","",Left(sActualiza,499)) THEN
						ggsDBtemp = "HIF"; ggsDB4Temp = "K2"
						ggbFlash_m = True; Ejecuta("A",sActualiza)
						ggsDBtemp = "HIF"; ggsDB4Temp = "K2"
						Ejecuta("A",sActualiza)
					END
					IF YesNo("Actualizo Intranet ?","",Left(sActualiza,499)) THEN
						ggsDBtemp = "FIC"; ggsDB4Temp = "X"
						ggbFlash_m = True; Ejecuta("A",sActualiza)
						ggbFlash_m = False; Ejecuta("A",sActualiza)
						Info(ggsLog,HNbRec(ggalM),HNbRec(lWe))
					END
				ELSE
					Error("no hay data que actualizar ...")
				END
			END
		END

		IF ggsFECHA1 = "" THEN
			sFcha1 = CalendarPicker(Today(),"Fecha Inicial")
			IF sFcha1 = "" THEN RETURN
			sFcha2 = sFcha1  //sFcha2 = CalendarPicker(Today(),"Fecha Final")
		ELSE
			sFcha1 = ggsFECHA1; sFcha2 = sFcha1
		END

		IF gsPCata IN ("VNXI","VNXE","VNXIS","VNXES", "VNP","VNQ","VN","VNS") THEN
			IF gsPCata IN ("VNXIS","VNXES","VNS") THEN gsPCata = Left(Length(gsCatalogo5)-1)
			IF YesNo("Presentar por estaci�n ?") THEN gsPCata = gsPCata+"S"
		END

		gsBloqueP = ""
		//? HExecuteQuery(QRY_KWE,hQueryDefault,"xyz")

		IF gsPCata IN ("EMPL","INVE","PROV") THEN
			ggbFlash_n = True; Ejecuta("E",";"+gapA[2]); ggbFlash_n = False
			IF gsBloqueP = "" THEN
				ggsLog = "Error interno 1912241045(Reportes.Muestra)"
			ELSE
				Ejecuta("FORMA_QRY","")  // Actualiza
			END
		ELSE
			// VNXE  VNXI
			// Tickets ...
			//;VNXER;90926__553_3      ;LUIS...;9.5 ;9.16 ;1;           ;;4;1475;75026967     ;;Victoria;0.34;0;20190926 ...  (K1)
			//;VNXER;91001__895_2      ;GAB... ;17.5;17.25;1;           ;;4;1287;7501030420835;;Sandwich;0.25;0;20191001
			//;VNXER;91130_1426__081__1;KAREN  ;9   ;8.67 ;1; Jumex ... ;;2;_081;1426         ;;        ;0   ;0;20191130
			//
			//;VNXER;91201_1303__965__1;GUA... ;8.5 ;8.33 ;1; Agua Ciel ;;2;_965;1303;;             ;0;0;20191201
			//;VNXER;91220_1319__679__1;GUS... ;6   ;5.83 ;1; Agua Ciel ;;2;_679;1319;;7501055307906;0;0;20191220
			//;VNXER;91229_1493__107__1;GUA... ;9   ;8.67 ;1; Jumex     ;;3;_107;1493;;7501013174038;0;0;20191229  ... 23 Dic (S2)
			///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


			IF gsPCata NOT IN ("VN","VNS") THEN
				//info(ggsFECHA1,"","gsPCata="+gsPCata)
				ggsFECHA1 = sFcha1
				Ejecuta("CALCULA",gsPCata)
				IF ArrayCount(garrSku) = 0 THEN Error(sFcha1+" sin DATA en calcula..."); RETURN
			END



			//		D E S C A R G A		//
			gsBloqueP = ""
			IF gsPCata = "VN" OR gsPCata = "VNS" THEN
				IF ggsFECHA2 = "" THEN ggsFECHA1 = ggsFECHA2
				nDia1,nDia2 is int
				nDia1=DateToInteger(ggsFECHA1); nDia2=DateToInteger(ggsFECHA2)
				IF NOT YesNo("Procesa "+NumToString((nDia2-nDia1)+1)+" d�as ?") THEN RETURN

				//ToastDisplay("Proceso puede tardar...",toastLong,vaMiddle,haCenter,LightCyan)
				HourGlass(True)
				ggsVN = ""
				FOR i = nDia1 TO nDia2
					ggsFECHA1 = IntegerToDate(i)
					Ejecuta("CALCULA",gsPCata)
					IF ArrayCount(garrSku) = 0 THEN
						IF NOT YesNo(ggsFECHA1+" sin DATA en calcula...","","Continuo ?") THEN RETURN
					END
					// genera bloque a presentar ...
					FOR x = 1 _TO_ ArrayCount(garrSku)
						ggsVN = ggsVN+";"+gsPCata+";"+Right(ggsFECHA1,5)+"_"+garrEsta[x]+...
						";Venta dia.."+ggsFECHA1+";"+...

						garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+garrEsta[x]+...
						";;;;;"+garrRe[x]+";"+garrReU[x]+";"+ggsFECHA1+";"+Now()+CR
					END
				END
				HourGlass(False)
				gsBloqueP = ggsVN; ggsVN = ""
				//info(left(gsBloqueP,499))

				//	//;VNS;91203_1;VENTA DIARIA E;98;94.96;10;;;1;;;;;7;0;20191203;1413
				//	gsBloqueP = gsBloqueP+";VN;"+Right(sFcha1,5)+"_VN;VENTA DIARIA;"+...
				//	NumToString(gpr)+";"+NumToString(gco)+";"+NumToString(gud)+";;;" +...
				//	";;;;;"+NumToString(gPrr)+";"+NumToString(gudr)+";"+sFcha1+";"+Now()+CR
			ELSE
				//;ALESS;Bubu l0074323544;Bubu lubu;-54;-52.53;-11;;;4;;0000007432354;;;;;20191010
				//;VNXE;DIEGO 1001;4;3.93;1;;;;600;1772;;;0;0;20191010     NumToString(e)
				//;VNXIS;91010_0000074323541;Bubu lubu;54;52;1;;;4;;0000007432354;;;0;0;20191010
				FOR x = 1 _TO_ ArrayCount(garrSku)
					IF Length(gsPCata) = 4 THEN
						// Windows ... (diferente a Android)
						IF garrUnid[x] <> 0 THEN //0122
							gsBloqueP = gsBloqueP+";"+gsPCata+";"+ggArrE3[x]+";"+garrLetra[x]+";"+...

							garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+...
							";;;;;"+garrRe[x]+";"+garrReU[x]+";"+sFcha1+";"+Now()+CR
						END
					ELSE IF Length(gsPCata) = 5
						// Windows ... (diferente a Android)
						IF garrUnid[x] <> 0 THEN //0122
							gsBloqueP = gsBloqueP+";"+gsPCata+";"+ggArrE3[x]+";"+garrLetra[x]+";"+...

							garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+Left(garrSku[x],1)+...
							";;"+Left(garrSku[x],1)+";;;"+garrRe[x]+";"+garrReU[x]+";"+sFcha1+";"+Now()+CR
						END
					ELSE
						//;VNS;91203_1;VENTA DIARIA E;98;94.96;10;;;1;;;;;7;0;20191203;1413
						gsBloqueP = gsBloqueP+";VNS;"+Right(sFcha1,5)+"_VN_"+Left(garrSku[x],1)+";VENTA DIARIA ESTACION;"+...
						garrPrec[x]+";"+garrCost[x]+";"+garrUnid[x]+";;;"+Left(garrSku[x],1)+...
						";;"+garrSku[x]+";;;"+garrRe[x]+";"+garrReU[x]+";"+sFcha1+";"+Now()+CR
					END
				END // for acumulado  ArrayCount(garrSku)
			END




			//? IF Upper(Left(ggsLog,1)) = "X" THEN Error(ggsLog); RETURN
			IF gsBloqueP = "" THEN Ejecuta("F","LOG;"+"X DATA vacia"); RETURN
			Ejecuta("FORMA_QRY","")  // Actualiza
		END
		// Titula Tabla ...

	CASE ~~"CALCULA"
		// ***  gsBloqueP = VNXER de un solo d�a  ***
		// Regresa:  	garrLetra con descripcion
		//				ggArrE3 con codigo
		//				AXX[i]:val1  AXX[i]:val2  AXX[i]:flag   AXX[i]:m  AXX[i]:n
		//				pr			 co 		  gPrr 			ud 		  gudr

		IF ggsFECHA1 = "" OR DateValid(ggsFECHA1) = False THEN
			Error("Imposible continuar proceso CALCULA con fecha invalida ..."); RETURN
		END
		IF gsPCata NOT IN ("VN","VNX","VNXE","VNXES","VNXI","VNXIS", "VNXER") THEN
			Error("Imposible continuar proceso CALCULA con cat�logo invalido ... "+gsPCata); RETURN
		END

		//info("ggbFlash_M="+ggbFlash_m)
		sfiltro = "SELECT * FROM lWe WHERE cata='VNXER' AND fecha="+ggsFECHA1
		IF ggbFlash_m THEN sfiltro = Replace(sfiltro,"lWe","mWe")
		IF ggbFlash_n THEN sfiltro = Replace(sfiltro,"lWe","nWe")
		IF ggbFlash_c THEN sfiltro = Replace(sfiltro,"lWe","cWe")
		IF ggbFlash_a THEN sfiltro = Replace(sfiltro,"lWe","aWe")
		//IF NOT YesNo("(WIN_Q) Continuo ?","",ggsCiaTemp,ggsDBtemp,ggsDB4Temp,sfiltro,"",gsCalcPARAM) THEN Close()
		Open(WIN_K,"KH",sfiltro)
		IF Upper(Left(gsBloqueP,1)) = "X" THEN Error("no hay DATA en "+ggsFECHA1); Ejecuta("HS_PARAM","CIERRA"); RETURN ELSE ggsLog = ""

		IF gsPCata = "VNXER" THEN RETURN

		// Prepara
		ggsB = ""; ggni = 0
		ggcyPrecio = 0; ggcyCosto = 0; ggcyTax1T = 0
		ggcyPrecioT = 0; ggcyDescT = 0	// Rechazados
		gpr = 0; gco = 0; gPrr = 0; gud = 0; gudr = 0

		ArrayDeleteAll(garrSku); ArrayDeleteAll(garrLetra); ArrayDeleteAll(ggArrE3)
		ArrayDeleteAll(garrEsta)  //0109
		sLlave is string
		ArrayDeleteAll(garrPrec); ArrayDeleteAll(garrCost); ArrayDeleteAll(garrUnid)
		ArrayDeleteAll(garrRe); ArrayDeleteAll(garrReU)

		// forma SUPER-ARREGLO global AXX
		ArrayDeleteAll(AXX)
		StringToArray(Replace(gsBloqueP,";",TAB),AXX,CR)
		//info("Calcula...","AXX="+ArrayCount(AXX),"",left(gsBloqueP,399),"gsPCata="+gsPCata)

		FOR i = 1 _TO_ ArrayCount(AXX)
			IF AXX[i]:d = "" OR AXX[i]:g = "" THEN CONTINUE	// Asegura
			//if AXX[i]:g <> "7501000133031" THEN CONTINUE

			//;VNXER;91229_1493__107__1;GUA... ;9   ;8.67 ;1; Jumex     ;;3;_107;1493;;7501013174038;0;0;20191229
			SWITCH gsPCata
				CASE "VNS": sLlave = AXX[i]:b				// estacion
				CASE "VNXE": sLlave = AXX[i]:d 				// #EMPL
				CASE "VNXI","ALES": sLlave = AXX[i]:g 				// SKU
				CASE "VNXES": sLlave = AXX[i]:b+AXX[i]:d	// estacion + #EMPL
				CASE "VNXIS","ALESS": sLlave = AXX[i]:b+AXX[i]:g	// estacion + SKU
			END
			ggnT = ArraySeek(garrSku,asLinearFirst,sLlave)
			IF ggnT <=0 THEN
				ArrayAdd(garrSku,sLlave); ggnT = ArrayCount(garrSku) //
				IF gsPCata IN ("VNXE","VNXES") THEN
					ArrayAdd(garrLetra,AXX[i]:descripcion); ArrayAdd(ggArrE3,AXX[i]:d)
					ArrayAdd(garrEsta,AXX[i]:b)	// 0109 estacion
				ELSE
					ArrayAdd(garrLetra,AXX[i]:Flagc20); ArrayAdd(ggArrE3,AXX[i]:g)
					ArrayAdd(garrEsta,AXX[i]:b) // 0109 estacion
				END
				// Inicializa suma ...
				IF gsPCata = "ALES" THEN
					AXX[i]:val1 = AXX[i]:val1 * -1; AXX[i]:val2 = AXX[i]:val2 * -1; AXX[i]:flag = AXX[i]:flag * -1
					AXX[i]:m = AXX[i]:m * -1; AXX[i]:n = AXX[i]:n * -1
				END
				ArrayAdd(garrPrec,AXX[i]:val1); ArrayAdd(garrCost,AXX[i]:val2); ArrayAdd(garrUnid,AXX[i]:flag)
				ArrayAdd(garrRe,AXX[i]:m); ArrayAdd(garrReU,AXX[i]:n)
			ELSE
				// Acumula si hay otro igual
				garrPrec[ggnT] += AXX[i]:val1; garrCost[ggnT] += AXX[i]:val2; garrUnid[ggnT] += AXX[i]:flag
				garrRe[ggnT] += AXX[i]:m; garrReU[ggnT] += AXX[i]:n
			END

			// Acumulados VN
			gpr += AXX[i]:val1; gco += AXX[i]:val2; gud += AXX[i]:flag
			gPrr += AXX[i]:m; gudr += AXX[i]:n	// Rechazados

		END	// fin Acumula x Estacion
		IF gsPCata = "ALES" THEN
			// Entradas ...

		END
		//Info(ArrayCount(AXX),ArrayCount(garrSku),"",Left(gsBloqueP,399),"gsPCata="+gsPCata)



	CASE ~~"EDITA"	// * * *   D E    INI   * * *
		IF gsPCata = "" THEN Info("Cat�logo aucente..."); RETURN

    {gestoyEn,indWindow}..Plane = 4

		ggnX = 0 ; gsPCata = gapA[2]
		sCpo = "Codigo"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[1].EDT_campo..Caption = sCpo

		sCpo = "Descripcion"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[2].EDT_campo..Caption = sCpo

		sCpo = "Precio"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[3].EDT_campo..Caption = sCpo

		sCpo = "Costo"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[4].EDT_campo..Caption = sCpo

		sCpo = "Unidades"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[5].EDT_campo..Caption = sCpo

		sCpo = "f20"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[6].EDT_campo..Caption = sCpo

		sCpo = "nota"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[7].EDT_campo..Caption = sCpo

		sCpo = "b"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[8].EDT_campo..Caption = sCpo

		sCpo = "c"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[9].EDT_campo..Caption = sCpo

		sCpo = "d"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[10].EDT_campo..Caption = sCpo

		sCpo = "f"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[11].EDT_campo..Caption = sCpo

		sCpo = "g"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[12].EDT_campo..Caption = sCpo

		sCpo = "Importe"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[13].EDT_campo..Caption = sCpo

		sCpo = "Uni"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[14].EDT_campo..Caption = sCpo

		sCpo = "FECHA"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[15].EDT_campo..Caption = sCpo

		sCpo = "HORA"; ggnX++
		EXTERN ".\zzW\Z\titula_carga.wl"
		LOOP_titula[16].EDT_campo..Caption = sCpo


		//MyWindow..Caption = "Edita "+gapA[2]

	CASE ~~"SALVA"
		// * * *   H A C I A    INI   * * *

		IF gsPCata = "" THEN Info("No fue guardada ninguna data..."); RETURN

		sCpo = "Codigo"; sTitulo = ATT_campo[1]; sMascara = RADIO_masc[ATT_mascara[1]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "Descripcion"; sTitulo = ATT_campo[2]; sMascara = RADIO_masc[ATT_mascara[2]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "Precio"; sTitulo = ATT_campo[3]; sMascara = RADIO_masc[ATT_mascara[3]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "Costo"; sTitulo = ATT_campo[4]; sMascara = RADIO_masc[ATT_mascara[4]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "Unidades"; sTitulo = ATT_campo[5]; sMascara = RADIO_masc[ATT_mascara[5]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "f20"; sTitulo = ATT_campo[6]; sMascara = RADIO_masc[ATT_mascara[6]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "Nota"; sTitulo = ATT_campo[7]; sMascara = RADIO_masc[ATT_mascara[7]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "b"; sTitulo = ATT_campo[8]; sMascara = RADIO_masc[ATT_mascara[8]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "c"; sTitulo = ATT_campo[9]; sMascara = RADIO_masc[ATT_mascara[9]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "d"; sTitulo = ATT_campo[10]; sMascara = RADIO_masc[ATT_mascara[10]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "f"; sTitulo = ATT_campo[11]; sMascara = RADIO_masc[ATT_mascara[11]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "g"; sTitulo = ATT_campo[12]; sMascara = RADIO_masc[ATT_mascara[12]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "Importe"; sTitulo = ATT_campo[13]; sMascara = RADIO_masc[ATT_mascara[13]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "Uni"; sTitulo = ATT_campo[14]; sMascara = RADIO_masc[ATT_mascara[14]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "FECHA"; sTitulo = ATT_campo[15]; sMascara = RADIO_masc[ATT_mascara[15]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		sCpo = "HORA"; sTitulo = ATT_campo[16]; sMascara = RADIO_masc[ATT_mascara[16]]..Caption
		EXTERN ".\zzW\Z\titula_descarga.wl"

		Info("Cambios guardados satisfactoramente ...")

	CASE ~~"RADI"
		//gnCapa = 2; Ejecuta(gapA[1])  //EXTERN ".\zzW\Z\param_RADI.wl"
    // *** Cambio configuracion original... Lanzar esta funcion ***
    //  RADIO_kata[1]..Caption = "Option 1"
    //  Ejecuta("RADI","EMPL;INVE;VN;VNXI")
    // *** ---------------------------------------------------- ***

    {gestoyEn,indWindow}..Plane = 5 //gnCapa
    sCpa1 = "RADIO_kata"
		nN is int

    // F O R M A
    IF {sCpa1,indControl}[1]..Caption = "Option 1" AND ArrayCount(gapA) > 0 THEN
      //      Elimina Radio Botones actuales
      // (control RADIO debe tener minimo 1 elemento)
      FOR nN = RadioButtonCount({sCpa1,indControl}) _TO_ 2 STEP -1
        RadioButtonDelete({sCpa1,indControl},nN)
      END

      // Forma 1er elemento
      {sCpa1,indControl}[1]..Caption = "_nada"
      FOR nN = 1 _TO_ ArrayCount(gapA)
        IF Left(Upper(gapA[nN]),3) = "RAD" THEN CONTINUE
        IF Left(gapA[nN],1) = "*" THEN gapA[nN] = Right(gapA[nN],Length(gapA[nN])-1)
        IF Contains(gapA[nN],"~") THEN CONTINUE // param CONCLUYE
        RadioButtonAdd({sCpa1,indControl},gapA[nN])
      END
    ELSE
      IF {sCpa1,indControl}[1]..Caption = "Option 1" THEN Error("X CHECK (2003041635) parametros aucentes..."); RETURN

      // S E L E C C I O N
      ////////////////////////////////////////////////////////
      //Ejecuta("ABRE","RADI")
      ////////////////////////////////////////////////////////
      // Asigna a  gsPCata...
      IF Left({sCpa1,indControl}[{sCpa1,indControl}]..Caption,1) = "+" THEN
      	IF gsPCata = "" THEN
      		Error("cat�logo BASE aucente ...")
      	ELSE
      		SWITCH	gsPCata
      			CASE "CLIE","EMPL","INVE","PROVE"
      				IF Right({sCpa1,indControl}[{sCpa1,indControl}]..Caption,1) = "S" THEN
      					gsPCata = "VNX"+Left(gsPCata,2)+"S"
      				ELSE
      					gsPCata = "VNX"+Left(gsPCata,2)
      				END
      			CASE "VN"
      				IF Right({sCpa1,indControl}[{sCpa1,indControl}]..Caption,1) = "S" THEN gsPCata = "VNS"
      			OTHER CASE
      		END
      	END
      ELSE
      	gsPCata = {sCpa1,indControl}[{sCpa1,indControl}]..Caption
      	IF Left(gsPCata,1) = "+" THEN
      		Error("cat�logo BASE aucente ...")
      		gsPCata = ""
      	END
      END
      EDT_catalogo = gsPCata
    END

	CASE ~~"TABLA_PRESENTA"
		{gestoyEn,indWindow}..Plane = 1 // capa

		IF TableCount(TABLE_memoria) THEN
			IF YesNo("Actualmente con DATOS, los elimino ?") THEN TableDeleteAll(TABLE_memoria)
		END

		Ejecuta("FORM",sCpa1)
		IF nDebug = Today() THEN TableCount(TABLE_memoria)
		IF NOT TableCount(TABLE_memoria) THEN Error("Nada que presentar ...  (IWmem_ABRE)")

	OTHER CASE: Error(gapA[1]+" tarea (2003191045) no definida en "+sCompilaTXT); RETURN
END
