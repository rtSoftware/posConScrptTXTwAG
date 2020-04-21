//EXTERN ".\zzW\correoExitosos.wl" // android Windows



arcorreo is array of ANSI string

IF pTarea = "" THEN ggsLog = "X"
IF sP1L = "" THEN
	//LOG("A","X parametros inexistentes",2600)
	Ejecuta("F","LOG;"+"X parametros inexistentes")
ELSE
	// Prepara desglosa
	IF sP2L <> "" THEN
		ArrayAdd(arcorreo,sP1L)
		IF sP2L <> "" THEN ArrayAdd(arcorreo,sP2L)  // Asunto
		IF sP3L <> "" THEN ArrayAdd(arcorreo,sP3L)  // Mensaje
	ELSE
		//S2A(sP1L,arcorreo)  //destino;asunto;mensaje
		StringToArray(sP1L,arcorreo,";")
	END


	//  Valida
	////////////////
	IF ArrayCount(arcorreo) > 2 THEN
		IF Upper(Right(arcorreo[3],4)) = ".TXT" THEN
			sTexto is string = fLoadText(arcorreo[3])
			IF sTexto = "" THEN
				arcorreo[3] = "contenido " + arcorreo[3]
			ELSE
				arcorreo[3] = sTexto
			END
		END
/////////////////////////////////////////////////////////////////////////////////////////






/////////////////////////////////////// ENVIAR CORREO DESDE HONESTY SHOP BROXEL ////////////////////////////

		// wBx.ini --> [cfg]     190923
		ggsA1 = INIRead("CORREO","servidorcorreo","nulo",ggsIni)
		IF ggsA1 = "nulo" THEN
			ggsA1 = "mail.exitosos-compulsivos.com"
			INIWrite("CORREO","servidorcorreo",ggsA1,ggsIni)
		END
		ggsA1 = INIRead("CORREO","usuario","nulo",ggsIni)
		IF ggsA1 = "nulo" THEN
			ggsA1 = "tapiara@exitosos-compulsivos.com"
			INIWrite("CORREO","usuario",ggsA1,ggsIni)
		END
		ggsA1 = INIRead("CORREO","password","nulo",ggsIni)
		IF ggsA1 = "nulo" THEN
			ggsA1 = "jmrcficqavmnvpfl" //"Tar12190357"
			INIWrite("CORREO","password",ggsA1,ggsIni)
		END
		ggsA1 = INIRead("CORREO","puerto","nulo",ggsIni)
		IF ggsA1 = "nulo" THEN
			ggsA1 = "465"
			INIWrite("CORREO","puerto",ggsA1,ggsIni)
		END


		MyMessage is Email
		sMyHTMLText is string = fLoadText(fCurrentDir+[fSep]+"recibo.html")
		EmailImportHTML(MyMessage, sMyHTMLText, fCurrentDir)

		MyMessage..Sender = "honestyshop@broxel.com"
		Add(MyMessage..Recipient, arcorreo[1])	//"tapiara@yahoo.com")
		MyMessage..Subject = arcorreo[2]		//"asunto"
		MyMessage..Message =  arcorreo [3] 		// mensasje en correo


		SessionSMTP is EmailSMTPSession
//		IF Contains(fCurrentDir(),"Simula",IgnoreCase) OR...
//			Contains(fCurrentDir(),"YandexDisk",IgnoreCase) THEN

			MyMessage..Sender = "tapiara@yahoo.com"

			SessionSMTP..ServerAddress = "mail.exitosos-compulsivos.com"
			SessionSMTP..Name="tapiara@exitosos-compulsivos.com"
			SessionSMTP..Password="Tar12190357"
//		ELSE
//			SessionSMTP..ServerAddress = INIRead("CORREO","servidorcorreo","smtp.gmail.com",ggsIni)
//			SessionSMTP..Name = INIRead("CORREO","usuario","honestyshop@broxel.com",ggsIni)
//			SessionSMTP..Password = INIRead("CORREO","password","jmrcficqavmnvpfl",ggsIni)
//			SessionSMTP..Port = Val(INIRead("CORREO","puerto","465",ggsIni))
//			SessionSMTP..Option = 	optionSSL
//		END



		IF EmailStartSession(SessionSMTP) = True THEN
			IF EmailSendMessage(SessionSMTP,MyMessage)= True THEN
				//LOG("A","OK correo "+arcorreo[1]+" ..."+arcorreo[2])
				Ejecuta("F","LOG;"+"OK correo "+arcorreo[1]+" ..."+arcorreo[2])
				//fAddText("CORREO.TXT",now()+" "+ggsref+" "+ggsLog+CR)
				fAddText(ggsSAVE+[fSep]+Right(Today(),5)+"CORREO.txt",Now()+" "+ggsRef+" "+ggsLog+CR)

			ELSE
				//LOG("A","Correo no pudo ser enviado..."+arcorreo[1]+" "+ErrorInfo())
				Ejecuta("F","LOG;"+"Correo no pudo ser enviado..."+arcorreo[1]+" "+ErrorInfo())
				fAddText(ggsSAVE+[fSep]+Right(Today(),5)+"CORREO_X.txt",Now()+" "+ggsRef+" "+ggsLog+CR)
			END
			EmailCloseSession(SessionSMTP)
		ELSE
			//LOG("A","Imposible establecer conexion con "+SessionSMTP..ServerAddress +arcorreo[1]+" "+ ErrorInfo(errMessage))
			Ejecuta("F","LOG;"+"Imposible establecer conexion con "+SessionSMTP..ServerAddress +arcorreo[1]+" "+ ErrorInfo(errMessage))
			fAddText("CORREO_X.TXT",Now()+" "+ggsRef+" FALLO SERVIDOR CORREO "+arcorreo[1]+" ..."+arcorreo[2]+CR)
		END
		////////////////////////////Envi� correo y ahora llena el LOG/////////////////////////

	ELSE
		//LOG("A","X parametros incompletos solo "+ArrayCount(arcorreo))
		Ejecuta("F","LOG;"+"X parametros incompletos solo "+ArrayCount(arcorreo))
		fAddText("CORREO_X.TXT",Now()+" "+ggsRef+" s Incompletos "+arcorreo[1]+" ..."+arcorreo[2]+CR)
	END
END
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
