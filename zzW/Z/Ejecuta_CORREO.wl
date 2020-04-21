//EXTERN ".\zzW\Ejecuta_CORREO.wl" // windows




EXTERN ".\zzW\Z\DebugEjecuta.wl"
//#

    ArrayDeleteAll(ggarrCorreo)
		StringToArray(gapA[1],ggarrCorreo,";")  //destino;asunto;mensaje

		//  Valida
		////////////////
		IF ArrayCount(ggarrCorreo) > 2 THEN
			IF Upper(Right(ggarrCorreo[3],4)) = ".TXT" THEN
				sTexto is string = fLoadText(ggarrCorreo[3])
				IF sTexto = "" THEN
					ggarrCorreo[3] = "contenido " + ggarrCorreo[3]
				ELSE
					ggarrCorreo[3] = sTexto
				END
			END
			/////////////////////////////////////////////////////////////////////////////////////////


			// wBx.ini --> [cfg]     190923
			ggsA1 = INIRead("CORREO","servidorcorreo","nulo",ggsIni)
			IF ggsA1 = "nulo" THEN
				ggsA1 = "smtp.gmail.com" //"mail.exitosos-compulsivos.com"
				INIWrite("CORREO","servidorcorreo",ggsA1,ggsIni)
			END
			ggsA1 = INIRead("CORREO","usuario","nulo",ggsIni)
			IF ggsA1 = "nulo" THEN
				ggsA1 = "honestyshop@broxel.com"
				INIWrite("CORREO","usuario",ggsA1,ggsIni)
			END
			ggsA1 = INIRead("CORREO","password","nulo",ggsIni)
			IF ggsA1 = "nulo" THEN
				ggsA1 = "mrjghygmuvlvvbos" //"jmrcficqavmnvpfl" //"elDiablo"
				INIWrite("CORREO","password",ggsA1,ggsIni)
			END
			ggsA1 = INIRead("CORREO","puerto","nulo",ggsIni)
			IF ggsA1 = "nulo" THEN
				ggsA1 = "465"
				INIWrite("CORREO","puerto",ggsA1,ggsIni)
			END


			/////////////////////////////////////// ENVIAR CORREO DESDE HONESTY SHOP BROXEL ////////////////////////////

			MyMessage is Email
			sMyHTMLText is string = fLoadText(fCurrentDir+[fSep]+"recibo.html")
			EmailImportHTML(MyMessage, sMyHTMLText, fCurrentDir)

			MyMessage..Sender = "honestyshop@broxel.com" //xmg
			Add(MyMessage..Recipient, ggarrCorreo[1])	//"tapiara@yahoo.com")
			MyMessage..Subject = ggarrCorreo[2]	//"asunto"
			MyMessage..Message =  ggarrCorreo [3] // mensasje en correo


			SessionSMTP is EmailSMTPSession
			IF Contains(fCurrentDir(),"Simula",IgnoreCase) OR...
				Contains(fCurrentDir(),"YandexDisk",IgnoreCase) THEN

				SessionSMTP..ServerAddress = "mail.exitosos-compulsivos.com"
				SessionSMTP..Name="tapiara@exitosos-compulsivos.com"
				SessionSMTP..Password="Tar12190357"
			ELSE
				SessionSMTP..ServerAddress = INIRead("CORREO","servidorcorreo","smtp.gmail.com",ggsIni)
				SessionSMTP..Name = INIRead("CORREO","usuario","honestyshop@broxel.com",ggsIni)
				SessionSMTP..Password = INIRead("CORREO","password","jmrcficqavmnvpfl",ggsIni)
				SessionSMTP..Port = Val(INIRead("CORREO","puerto","465",ggsIni))
				SessionSMTP..Option = 	optionSSL
			END



			IF EmailStartSession(SessionSMTP) = True THEN
				IF EmailSendMessage(SessionSMTP,MyMessage)= True THEN
					//20LOG("A","OK correo "+ggarrCorreo[1]+" ..."+ggarrCorreo[2])
					//fAddText("CORREO.TXT",now()+" "+ggsref+" "+ggsLog+CR)
					fAddText(ggsSAVE+[fSep]+Right(Today(),5)+"CORREO.txt",Now()+" "+ggsRef+" "+ggsLog+CR)

				ELSE
					//20LOG("A","Correo no pudo ser enviado..."+ggarrCorreo[1]+" "+ErrorInfo())
					fAddText(ggsSAVE+[fSep]+Right(Today(),5)+"CORREO_X.txt",Now()+" "+ggsRef+" "+ggsLog+CR)
				END
				EmailCloseSession(SessionSMTP)
			ELSE
				//20LOG("A","Imposible establecer conexion con "+SessionSMTP..ServerAddress +ggarrCorreo[1]+" "+ ErrorInfo(errMessage))
				fAddText("CORREO_X.TXT",Now()+" "+ggsRef+" FALLO SERVIDOR CORREO "+ggarrCorreo[1]+" ..."+ggarrCorreo[2]+CR)
			END
			////////////////////////////Envi� correo y ahora llena el LOG/////////////////////////

		ELSE
			//20LOG("A","X parametros incompletos solo "+ArrayCount(ggarrCorreo))
			fAddText("CORREO_X.TXT",Now()+" "+ggsRef+" s Incompletos "+ggarrCorreo[1]+" ..."+ggarrCorreo[2]+CR)
		END
