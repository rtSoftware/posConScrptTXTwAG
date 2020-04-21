//EXTERN ".\zzW\Z\RTF_SALVA.wl   " // windows



IF ENT_RTF <> "" THEN
  IF SC_FilePicker1.EDT_FILE = "" THEN
    ggsA = ""; Input("Nombre Archivo...",ggsA)
    IF Upper(Right(ggsA,4)) <> ".RTF" THEN ggsA = ggsA + ".RTF"
  ELSE
    ggsA = SC_FilePicker1 //.EDT_FILE
  END
  IF ggsA = "" THEN ggsA = ggsSAVE+[fSep]+Right(Today(),4)+".RTF"
  //fSaveText(ggsA,EDT_TXT)

  ggnE = fOpen(ggsA, foCreateIfNotExist + foAdd + foReadWrite)
  IF ggnE = -1 THEN
    Error("X imposible abrir "+ggsA,"",ErrorInfo())
  ELSE
    fWrite(ggnE, ENT_RTF); fClose(ggnE); ENT_RTF = ""
    Info("Guardado correctamente.",ggsA)
  END

ELSE
	Error("Nada que guardar ...")
END
