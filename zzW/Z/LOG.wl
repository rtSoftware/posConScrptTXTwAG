//tarEa_log ,pAram_log is string = "" ,pN_log is int = 0
//EXTERN ".\zzW\LOG.wl" // windows


sNombreArchivo is string
sNombreArchivo = fCurrentDir()+[fSep]+"LOG"+[fSep]+Right(Today(),5)+ggsAplicacion+".LOG"
IF NOT fDirExist(fCurrentDir()+[fSep]+"LOG") THEN fMakeDir(fCurrentDir()+[fSep]+"LOG")
IF NOT fDirExist(fCurrentDir()+[fSep]+"SAVE") THEN fMakeDir(fCurrentDir()+[fSep]+"SAVE")
IF NOT fDirExist(fCurrentDir()+[fSep]+"IMAGENES") THEN fMakeDir(fCurrentDir()+[fSep]+"IMAGENES")

// Compativilidad con otras versiones ,,,
//IF gapA[1] = "" AND pN = 0 THEN gapA[1] = gatarEa_log[1] ; gatarEa_log[1] = "A"
//IF ggnDebug > 0 AND pN_log = 0 THEN pN_log = 1

SWITCH Upper(tarEa_log)
	CASE "": RETURN
	CASE "?"
		ggsLog = "OK"	// control salida gatarEa_log[1]
		InfoWithTimeout(600,"A B E")
	CASE "A"
		//ggsLog = "OK"	// control salida gatarEa_log[1]   NUNCA !
		ggsLog = pAram_log //0130
		IF Length(pAram_log) > 199 THEN ggsLog = Left(pAram_log,199)
		fAddText(sNombreArchivo,Now()+" "+ggsProcedimiento+" "+ggsLog+CR)

		//191206 ---------
		//INIWrite("info","LOG2",INIRead("info","LOG1","",ggsIni),ggsIni)
		//INIWrite("info","LOG1",Now()+" "+ggsProcedimiento+": "+Left(gapA[1],120),ggsIni)
		//191206 ---------

		IF pN_log = Today() THEN pN_log = 0	//0215
		SWITCH pN_log
			CASE 0
			CASE 1: Info(pAram_log)
			CASE 2: Error(pAram_log)
			CASE 1000: ToastDisplay(ggsA,toastShort) //,vaMiddle,haCenter,color ?
			CASE 1100 TO 1900: InfoWithTimeout(pN_log-1000,pAram_log)
			CASE 2100 TO 2900: ErrorWithTimeout(pN_log-2000,pAram_log)
			CASE 3100 TO 3900
				ErrorWithTimeout(pN_log-3000,pAram_log)
				fAddText(sNombreArchivo,Now()+" "+ggsProcedimiento+": ABOTRA!"+CR)
				EndProgram()
			OTHER CASE: ErrorWithTimeout(pN_log,pAram_log)
		END
	CASE "B"
		ggsLog = "OK"	// control salida gatarEa_log[1]
		SWITCH pAram_log
			CASE "ENCERA": fRemoveDir(fCurrentDir()+[fSep]+"LOG")
			CASE "MES_ACTUAL"
				IF pN_log = 0 THEN pAram_log = "1" // dummy
			CASE "MESES_ANTERIORES"
			OTHER CASE: IF NOT fDelete(sNombreArchivo,frToRecycleBin) THEN ggsLog = "X "+ErrorInfo()
		END

	CASE "E"
		ggsLog = "OK"	// control salida gatarEa_log[1]
		pAram_log = fLoadText(sNombreArchivo)
	OTHER CASE: ErrorWithTimeout(600,tarEa_log[1]+"<-- comando desconocido en "+ggsProcedimiento)
END
