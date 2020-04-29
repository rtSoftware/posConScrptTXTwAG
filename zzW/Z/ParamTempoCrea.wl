//EXTERN ".\zzW\Z\ParamTempoCrea.wl" // windows



IF nDebug = Today() THEN Info("ParamTempoCrea...","","ggsT="+ggsT)

sIntraNet is string
arrPaTe is array <growth=n> of String // PArametros TEmporales
StringToArray(ggsT,arrPaTe,",")
ggnX = 1
WHILE ggnX < 15
	IF arrPaTe[ggnX] = "" THEN BREAK
	IF Contains(arrPaTe[ggnX],"CIA:",IgnoreCase) THEN ggsCiaTemp = Middle(arrPaTe[ggnX],5,5)
	IF Contains(arrPaTe[ggnX],"DB:",IgnoreCase) THEN ggsDBtemp = Middle(arrPaTe[ggnX],4,5)
	IF Contains(arrPaTe[ggnX],"DB4:",IgnoreCase) THEN ggsDB4Temp = Middle(arrPaTe[ggnX],5,2)
	IF Contains(arrPaTe[ggnX],"CX:",IgnoreCase) THEN ggsDB4Temp = Middle(arrPaTe[ggnX],4,2)
	IF Contains(arrPaTe[ggnX],"FLASH:",IgnoreCase) THEN
		ggsFLASH = Middle(arrPaTe[ggnX],7,1)
		ggbFlash_a = False; ggbFlash_c = False; ggbFlash_m = False; ggbFlash_n = False
		SWITCH Upper(ggsFLASH)
			CASE "A": ggbFlash_a = True
			CASE "C": ggbFlash_c = True
			CASE "M": ggbFlash_m = True
			CASE "N": ggbFlash_n = True
		END
	END
	IF Contains(arrPaTe[ggnX],"DASH:",IgnoreCase) THEN ggsDash_Nombre = Middle(arrPaTe[ggnX],6,19)
	IF Contains(arrPaTe[ggnX],"KATA:",IgnoreCase) THEN ggsKataAlias = Middle(arrPaTe[ggnX],6,9)
	IF Contains(arrPaTe[ggnX],"INTRANET:",IgnoreCase) THEN sIntraNet = Middle(arrPaTe[ggnX],10,99)

	IF Contains(arrPaTe[ggnX],"FECHA1:",IgnoreCase) THEN ggsFECHA1 = Middle(arrPaTe[ggnX],8,8)
	IF Contains(arrPaTe[ggnX],"FECHA2:",IgnoreCase) THEN ggsFECHA2 = Middle(arrPaTe[ggnX],8,8)
	IF Contains(arrPaTe[ggnX],"HORA1:",IgnoreCase) THEN ggsHORA1 = Middle(arrPaTe[ggnX],7,8)
	IF Contains(arrPaTe[ggnX],"HORA2:",IgnoreCase) THEN ggsHORA2 = Middle(arrPaTe[ggnX],7,8)

	IF Contains(arrPaTe[ggnX],"CAPA:",IgnoreCase) THEN ggsCAPA = Middle(arrPaTe[ggnX],6,2); BREAK
	ggnX++
END

// Unico espacio donde asigno nombre a DASH...
IF ggsDash_Nombre = "?" THEN
	ggsDash_Nombre = "DASH_1"; Input("Nombre DASH ?",ggsDash_Nombre)
	IF ggsDash_Nombre = "" THEN Error("Imposible continuar sin nombre Dash"); EndProgram()
END
INIWrite("cfg","DASH",ggsDash_Nombre,ggsIni)


// Valida Intranet valido ...
IF sIntraNet <> "" AND sIntraNet <> "N" THEN
	ggsDBtemp = "FIC"; ggsDB4temp = "I" // Asegura
	IF  sIntraNet = "" OR sIntraNet = "?" THEN sIntraNet = fSelectDir(fCurrentDir(), "Directorios...", "Seleccione...")
	IF sIntraNet <> "" THEN
		IF fDirectoryExist(sIntraNet) THEN
			// Ultimo ajuste...
			IF Left(sIntraNet,2) <> "\\" THEN
				IF Length(sIntraNet) > 3 THEN sIntraNet = "\\"+sIntraNet
			END
			Input("Intranet... Unidades mapeadas(P:\)  Direccion IP(\\192.168.0.11)  ?",sIntraNet)
			INIWrite("DB","INTRANET",sIntraNet,ggsIni)
		ELSE
			// Reconfigura sin Intranet...
			Error("Camino inexistente  >>>>"+sIntraNet+"<<<<")
			INIRead("DB","INTRANET","N",ggsIni)
			ggsDBtemp = "FIC"; ggsDB4temp = "F" // Asegura
		END
	END
END

// Autocorrige...
IF ggsDBtemp <> "" AND ggsDB4temp = "" THEN ggsDB4temp = ggsDB_WS_SP4L
SWITCH Upper(ggsDBtemp)
	CASE "HIF": IF NOT Upper(ggsDB4temp) IN ("K1","K2","S1","S2") THEN ggsDB4temp = "K1"
	CASE "FIC": IF NOT Upper(ggsDB4temp) IN ("F","I","G","D","H") THEN ggsDB4temp = "F"
	CASE "MONGO": IF NOT Upper(ggsDB4temp) IN ("M1","M2") THEN ggsDB4temp = "M1"
END

IF nDebug = Today() THEN
	Info("ggsCiaTemp="+ggsCiaTemp , "ggsDBTemp="+ggsDBTemp , "ggsDB4Temp="+ggsDB4Temp ,...
	 	"ggbFlash_m="+ggbFlash_m , "ggsFECHA1="+ggsFECHA1, "ggsFECHA2="+ggsFECHA2,...
		 "ggsHORA1="+ggsHORA1 ,"ggsHORA2="+ggsHORA2, "ggsKataAlias="+ggsKataAlias,...
		 "ggsCAPA="+ggsCAPA)
END
