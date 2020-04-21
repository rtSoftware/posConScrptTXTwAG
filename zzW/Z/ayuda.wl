//EXTERN ".\zzW\Z\ayuda.wl" // windows
//IF INIRead("cfg","Debug","NULL",ggsINI) = "Z" THEN Info("Hola") 


		IF fFileExist(gestoyEn+".TXT") THEN
			Info(fLoadText(gestoyEn+".TXT"))
		ELSE
			fSaveText(gestoyEn+".TXT","")
			ExeRun("notepad "+gestoyEn+".TXT")
		END
