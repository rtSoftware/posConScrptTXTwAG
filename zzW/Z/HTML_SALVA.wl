//EXTERN ".\zzW\Z\HTML_SALVA.wl" // windows


IF EDT_HTM <> "" THEN
  IF SC_FilePicker3.EDT_FILE = "" THEN
    ggsA = ""; Input("Nombre Archivo...",ggsA)
  ELSE
    ggsA = SC_FilePicker3 //.EDT_FILE
  END
  IF ggsA = "" THEN ggsA = ggsSAVE+[fSep]+Right(Today(),4)+".HTML"
  fSaveText(ggsA,EDT_TXT);  EDT_TXT = ""
  Info("Guardado correctamente.",ggsA)
ELSE
    Error("Nada que guardar ...")
END
