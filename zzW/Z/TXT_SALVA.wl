//EXTERN ".\zzW\Z\TXT_SALVA.wl" // windows



IF EDT_TXT <> "" THEN
	IF SC_FilePicker2.EDT_FILE = "" THEN
		ggsA = ""; Input("Nombre Archivo...",ggsA)
	ELSE
		ggsA = SC_FilePicker2 //.EDT_FILE
	END
	IF ggsA = "" THEN ggsA = ggsSAVE+[fSep]+Right(Today(),4)+".TXT"
	fSaveText(ggsA,EDT_TXT);  EDT_TXT = ""
	Info("Guardado correctamente.",ggsA)
ELSE
    Error("Nada que guardar ...")
END
