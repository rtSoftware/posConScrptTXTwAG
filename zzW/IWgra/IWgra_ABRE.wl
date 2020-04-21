//EXTERN ".\zzW\IWgra_ABRE.wl

//ArrayDeleteAll(garrTit1); ArrayDeleteAll(garrVal11)
//ArrayAdd(garrTit1,"uno"); ArrayAdd(garrTit1,"dos"); ArrayAdd(garrTit1,"tres")
//ArrayAdd(garrVal11,15); ArrayAdd(garrVal11,35); ArrayAdd(garrVal11,50)
//IW_grafica.Ejecuta("GRA_ABRE","C1;VENTAS")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// FOR nCpa1 = 1 TO DashCount(WIN_MAIN.DASH_1,toTotal)
// 	IF WIN_MAIN.DASH_1[nCpa1]..Name = "IW_grafica" THEN
//
// 		// Muevo a otra posicion en DASH ...
// 		DashMoveWidget(WIN_MAIN.DASH_1,nCpa1,2,4,dashNoReorganization)
// 		DashResizeWidget(WIN_MAIN.DASH_1,4 ,4,1)
//
// 		// Genero serie en forma aleatoria ...
// 		garrTit2 = ["L","M","M","J","V","S","D"] 	// Titulo series
// 		garrVal21 = [Random(5,20),Random(10,30),Random(20,40),Random(30,70),Random(40,80),Random(50,60),Random(50,60)]
// 		garrVal22 = [Random(10,40),Random(20,40),Random(30,60),Random(40,70),Random(50,60),Random(60,70),Random(50,80)]
// 		IW_grafica.Ejecuta("GRA_ABRE" ,"C2;Ventas Dia")
//
// 		BREAK
// 	END
// END // for
//...DashAddWidget(DASH_Main,IW_grafica,"grafica","GRA_ABRE;S1;Camisa Blanca")


IF Contains(gapA[2],".TXT",IgnoreCase) THEN
	Info("funcionalidad en construccion ..."); RETURN
END

////////////////////////////////////////////////////
//     pEw = PIE 1  		    pAw = Items (titulo)
// gapA[1] = COLUMNA 2 	gapA[2] = VENTAS
//
//
// Ejecuta(IWgra_ABRE ,"D1;Titulo")
////////////////////////////////////////////////////

// Autocorrige ...  A2  C1  D4  L4  P3
IF Val(Right(gapA[1],1)) NOT IN (1,2,3,4) THEN gapA[1] = gapA[1]+"1"
IF Upper(Left(gapA[1],1)) NOT IN ("A","C","D","L","P","S") THEN gapA[1] = "D"+Right(gapA[1],1)

sCpa1 = "CHART_"+Right(gapA[1],1)	// {indireccion} grafica CAPA
SWITCH Left(Upper(gapA[1]),1)
	CASE "A"
		grType({sCpa1,indControl},grArea)

	CASE "C"
		grType({sCpa1,indControl},grColumn)
	CASE "D"
		grType({sCpa1,indControl},grDonut)
	CASE "L"
		grType({sCpa1,indControl},gr3DSLine)
	CASE "P"
		grType({sCpa1,indControl},grPie)
	CASE "S"
		grType({sCpa1,indControl},grSemiCircular)
	OTHER CASE: Error(gapA[1]+" es una capa inexistente en "+sCompilaTXT); RETURN
END
//https://doc.windev.com/?3042062&lang=en-US&productversion=01A220073h&3042062&lang=en-US&productversion=01A220073h

//////////////////////////////////////////////////////////////////////////////////
// Contenido Grafica:  garrTit1 y garrVal11
//										 garrTit2 y  garrVal21, garrVal22
// 										 garrTit3 y garrVal31, garrVal32, garrVal33
// 										 garrTit4 y garrVal41, garrVal42, garrVal43, garrVal44
//////////////////////////////////////////////////////////////////////////////////
SWITCH Right(gapA[1],1)
	CASE "1"
		IF nDebug = Today() THEN Info("Modo: "+Left(gapA[1],1),"Dimención: "+Right(gapA[1],1))
		IF NOT ArrayCount(garrVal11) THEN
			gapA[2] = "auto-generada" // Titulo
			ArrayAdd(garrTit1,"uno"); ArrayAdd(garrTit1,"dos"); ArrayAdd(garrTit1,"tres")
			ArrayAdd(garrVal11,15); ArrayAdd(garrVal11,35); ArrayAdd(garrVal11,50)
		END
		grDraw(CHART_1)
		CHART_1..Title = gapA[2]

	CASE "2"
		IF nDebug = Today() THEN Info("Modo: "+Left(gapA[1],1),"Dimención: "+Right(gapA[1],1))
		IF NOT ArrayCount(garrVal21) AND NOT ArrayCount(garrVal22) THEN
			gapA[2] = "auto-generada" // Titulo
			ArrayAdd(garrTit2,"uno"); ArrayAdd(garrTit2,"dos"); ArrayAdd(garrTit2,"tres")
			ArrayAdd(garrVal21,15); ArrayAdd(garrVal21,35); ArrayAdd(garrVal21,50)
			ArrayAdd(garrVal22,10); ArrayAdd(garrVal22,45); ArrayAdd(garrVal22,60)
		END
		grDraw(CHART_2)
		CHART_2..Title = gapA[2]

	CASE "3"
		IF nDebug = Today() THEN Info("Modo: "+Left(gapA[1],1),"Dimención: "+Right(gapA[1],1))
		IF NOT ArrayCount(garrVal31) AND NOT ArrayCount(garrVal32) AND NOT ArrayCount(garrVal33) THEN
			gapA[2] = "auto-generada" // Titulo
			ArrayAdd(garrTit3,"uno"); ArrayAdd(garrTit3,"dos"); ArrayAdd(garrTit3,"tres")
			ArrayAdd(garrVal31,15); ArrayAdd(garrVal31,35); ArrayAdd(garrVal31,50)
			ArrayAdd(garrVal32,10); ArrayAdd(garrVal32,45); ArrayAdd(garrVal32,60)
			ArrayAdd(garrVal33,10); ArrayAdd(garrVal33,45); ArrayAdd(garrVal33,60)
		END
		grDraw(CHART_3)
		CHART_3..Title = gapA[2]

	CASE "4"
		IF nDebug = Today() THEN Info("Modo: "+Left(gapA[1],1),"Dimención: "+Right(gapA[1],1))
		IF NOT ArrayCount(garrVal41) AND NOT ArrayCount(garrVal42) AND NOT ArrayCount(garrVal43) THEN
			gapA[2] = "auto-generada" 				// Titulo grafica
			garrTit4 = ["uno","dos","tres"] 	// Titulo series
			garrVal41 = [15,35,50]; garrVal42 = [10,45,60]; garrVal43 = [12,5,25]; garrVal44 = [9,15,5]
		END
		grDraw(CHART_4)
		CHART_4..Title = gapA[2]

END
IW_grafica..Plane = Val(Right(gapA[1],1))




// Formulas:
// GR_x..Visible = True
// IW_x..Plane = 2
// ReturnToCapture(EDT_1)

// Ejecuta("F","TEST")
// Ejecuta("CAP_MJES",gapA[1]+";"+gapA[2]+";"+gapA[3])"

// //Witget:
// bCpa1 = False // Asegura
// FOR nCpa1 = 1 TO DashCount(WIN_MAIN.DASH_1,toTotal)
// 	IF WIN_MAIN.DASH_1[nCpa1]..Name = "IW_recibo" THEN
// 		IW_recibo.Ejecuta("RBO_FORM","RECIBO"+sCpa1)"
// 		IW_recibo.EDT_1..Visible = False
// 		bCpa1 = True
// 		BREAK
// 	END // if
// END // for

// nCpa1 = ArraySeek(ggarrINVEd,asLinear,gapA[2])

// IF gsBloqueP <> "" THEN
// 	xxx is array of ANSI string
// 	S2A(gsBloqueP,xxx)

// END


// // * = salta
// IF Left(gapA[2],1) <> "*" THEN STC_1 = gapA[2]
