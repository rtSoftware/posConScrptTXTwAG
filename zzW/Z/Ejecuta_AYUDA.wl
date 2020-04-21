//EXTERN ".\zzW\Ejecuta_AYUDA.wl" // windows




EXTERN ".\zzW\Z\DebugEjecuta.wl"
//#


		IF gestoyEn = "" THEN Error("X  aucente en "+sCompilaTXT)
		IF fFileExist(gestoyEn+".TXT") THEN
			Info(fLoadText(gestoyEn+".TXT"))
		ELSE
			fSaveText(gestoyEn+".TXT","")
			ExeRun("notepad "+gestoyEn+".TXT")
		END
