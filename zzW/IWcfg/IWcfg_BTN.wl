//EXTERN ".\zzW\IWcfg\IWcfg_BTN_1DB.wl" // windows


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
		CASE ~~"IMG_1"
      // Rueda dentada portada //
			// Admin...
			EXTERN ".\zzW\Z\zzOa_ggbAdmin.wl"

			BTN_MAS..Visible = True
			BTN_MENOS..Visible = True
			BTN_eliminaW..Visible = True
  END
  RETURN
END

/////////////// Botones ///////////////
SWITCH gapA[1]
	CASE ~~"BTN_1DB"
		// Cambio CIA, DB, DB4(conexion)
    // Nombre boton dianamico. CIA/DB/CX
    // Cambia PARAMETROS [DB].INI

		sCpa1 = Upper(ggsCia); Input("Cia ?",sCpa1); sCpa1 = Upper(sCpa1)
		IF sCpa1 <> Upper(ggsCia) THEN INIWrite("cfg","cia",sCpa1,ggsIni); ggsCia = Upper(sCpa1)
		IF Upper(Left(ggsLog,1)) = "X" THEN Error(ggsLog); RETURN ELSE ggsCia = sCpa1
		{sCTL}..Caption = ggsCia+" / "+ggsDB+" / "+ggsDB_WS_SP4L


		// Cambio DIRVE
		sCpa1 = "RADIO;FIC;HIF;MONGO" // Nunca !     Ejecuta("F" , "RADIO"+sCpa1)
    Ejecuta("F" , sCpa1) //Open(WIN_Q,"RADIO",sCpa1)
		IF Upper(Left(ggsLog,1)) = "X" THEN Error(ggsLog); RETURN
    IF sCpa1 <> ggsA THEN Error("Algo anda mal con RADI en F ...")
		ggsDB = Upper(sCpa1); INIWrite("DB","Drive",ggsDB,ggsIni) // <-- modifica INI
		{sCTL}..Caption = ggsCia+" / "+ggsDB+" / "+ggsDB_WS_SP4L

		// Cambio CONEXION
		sCpa1 = ""
		IF ggsDB = "FIC" THEN sCpa1 = "RADIO;D;F;G;H;I" //ggsDB_WS_SP4L+
		IF ggsDB = "HIF" THEN sCpa1 = "RADIO;K1;K2;S1;S2"
		IF ggsDB = "MONGO" THEN sCpa1 = "RADIO;M1;M2"
		Ejecuta("F" , sCpa1) //Open(WIN_Q,"RADIO",sCpa1)
		IF Upper(Left(ggsLog,1)) = "X" THEN Error(ggsLog); RETURN
    IF sCpa1 <> ggsA THEN Error("Algo anda mal con RADI en F ...",ggsA,sCpa1)
		ggsDB_WS_SP4L = Upper(sCpa1); INIWrite("DB","DB_WS_SP4L",ggsDB_WS_SP4L,ggsIni) // <-- modifica INI
		{sCTL}..Caption = ggsCia+" / "+ggsDB+" / "+ggsDB_WS_SP4L

    // Intranet ...
    IF ggsDB_WS_SP4L = "I" THEN
        sIntraNet is string = fSelectDir(fCurrentDir(), "Directorios...", "Seleccione...")
        IF sIntraNet = "" THEN
          Error("Camino inexistente  >>>>"+sIntraNet+"<<<<")
          ggsDB_WS_SP4L = "F"; INIWrite("DB","DB_WS_SP4L",ggsDB_WS_SP4L,ggsIni) // <-- modifica INI
          INIRead("DB","INTRANET","N",ggsIni)
        ELSE
          INIWrite("DB","INTRANET",sIntraNet,ggsIni)
        END
    END

    ggsDBOri = ggsDB; ggsDB4Ori = ggsDB_WS_SP4L // <-- modifica ORIGINAL...
	CASE "BTN_11"
		// +Columnas DASH

		//EXTERN ".\zzW\Z\DASH_Lee.wl"  // DASH --> {ggsA1}
    IF ggsDash_Nombre = "" THEN ggsDash_Nombre = INIRead("cfg","DASH","NULL",ggsIni)
    IF ggsDash_Nombre = "NULL" THEN Error("X no definido nombre DASH"); EndProgram()
		ggnX = {ggsDash_Nombre,indControl}..Height;  ggnY = {ggsDash_Nombre,indControl}..Width
		Info("ggnX="+ggnX,"ggnY="+ggnY,"",{ggsDash_Nombre,indControl}..NumberColumn)
		IF {ggsA1}..NumberColumn > 0 THEN {ggsDash_Nombre,indControl}..NumberColumn++

		////info("columnas="+WIN_Main.DASH_Main..NumberColumn)
		//if yesno("Incremento ?") THEN
		//	IF WIN_Main.DASH_Main..NumberColumn = 3 THEN
		//		WIN_Main.DASH_Main..Height = ggnX + 200
		//		//WIN_Main.DASH_Main..Width = ggny + 640
		//		WIN_Main.DASH_Main..NumberColumn = 4
		//	ELSE IF	WIN_Main.DASH_Main..NumberColumn = 5
		//		WIN_Main.DASH_Main..NumberColumn = 4
		//	END
		//ELSE
		//	WIN_Main.DASH_Main..NumberColumn = 3
		//	WIN_Main.DASH_Main..Height = WIN_Main.DASH_Main..InitialHeight
		//	WIN_Main.DASH_Main..Width = WIN_Main.DASH_Main..InitialWidth
		//END


	CASE "BTN_12"
		// -Columnas DASH

    //EXTERN ".\zzW\Z\DASH_Lee.wl"  // DASH --> {ggsA1}
    IF ggsDash_Nombre = "" THEN ggsDash_Nombre = INIRead("cfg","DASH","NULL",ggsIni)
    IF ggsDash_Nombre = "NULL" THEN Error("X no definido nombre DASH"); EndProgram()
		IF {ggsDash_Nombre,indControl}..NumberColumn > 0 THEN {ggsDash_Nombre,indControl}..NumberColumn--


		//ggsDash_Nombre = WIN_R.DASH_Main
		//ggnX = {ggsDash_Nombre,indControl}..Height;  ggny = {ggsDash_Nombre,indControl}..Width
		//	//Info("columnas="+WIN_Main.DASH_Main..NumberColumn)
		//if yesno("Incremento ?") THEN
		//	IF {ggsDash_Nombre,indControl}..NumberColumn = 3 THEN
		//		{ggsDash_Nombre,indControl}..Height = ggnX + 200
		//		//WIN_Main.DASH_Main..Width = ggny + 640
		//		{ggsDash_Nombre,indControl}..NumberColumn = 5
		//	ELSE if	{ggsDash_Nombre,indControl}..NumberColumn = 4
		//		{ggsDash_Nombre,indControl}..NumberColumn = 5
		//	END
		//ELSE
		//	{ggsDash_Nombre,indControl}..NumberColumn = 3
		//	{ggsDash_Nombre,indControl}..Height = WIN_r.DASH_Main..InitialHeight
		//	{ggsDash_Nombre,indControl}..Width = WIN_r.DASH_Main..InitialWidth
		//
		//END

	CASE "BTN_1Q"
		sQ is string
		Input("comando Q ?",sQ); IF sQ <> "" THEN Ejecuta("F",sQ)
		Info("Responde ...","",sQ)
//		IF sQ = "XFIC" THEN EndProgram()

////////////////////////// TODAS LAS CAPAS /////////////////////////
	CASE ~~"BTN_MAS": IW_cfg..Plane++
	CASE ~~"BTN_MENOS": IF IW_cfg..Plane > 1 THEN IW_cfg..Plane--
	CASE "BTN_eliminaW"
		// auto eliminate
    //EXTERN ".\zzW\Z\DASH_Lee.wl"  // DASH --> {ggsA1}
    IF ggsDash_Nombre = "" THEN ggsDash_Nombre = INIRead("cfg","DASH","NULL",ggsIni)
    IF ggsDash_Nombre = "NULL" THEN Error("X no definido nombre DASH"); EndProgram()
		FOR i = 1 TO DashCount({ggsDash_Nombre,indControl},toTotal)
			IF {ggsDash_Nombre,indControl}[i]..Name = "IW_cfg" THEN DashDelete({ggsDash_Nombre,indControl},i); BREAK
		END


	OTHER CASE: Error("X no definido Boton: >>>"+gapA[1]+"<<< en(200227751) "+sCompilaTXT)
END
