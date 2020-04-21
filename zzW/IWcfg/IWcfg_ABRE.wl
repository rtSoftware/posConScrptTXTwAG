//EXTERN ".\zzW\IWbro\IWbro_ABRE.wl" // windows



// Ejecuta("ABRE")
// Ejecuta("ABRE","tarea;param1,2,3 ... n")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

// Valida ...
IF Upper(gapA[1]) NOT IN("CAPA1","CAPA2","CAPA3")  THEN gapA[1] = ""
IF gapA[1] = "" THEN gapA[1] = "CAPA3"

{gestoyEn,indWindow}..Plane = 0 // capa
SWITCH gapA[1]
  CASE ~~"capa1"
    {gestoyEn,indWindow}..Plane = 1 // capa

    // Limpia

    // Forma super arreglo

    // Mensajes ...
    STC_1mje = ""
		BTN_1DB..Caption = ggsCia+" / "+ggsDB+" / "+ggsDB_WS_SP4L

  CASE ~~"capa2"
    {gestoyEn,indWindow}..Plane = 2 // capa

  CASE ~~"capa3"
    {gestoyEn,indWindow}..Plane = 3 // capa

  CASE "DLLS"
    // Retrieve the libraries used
    LibraryList is string = ListDLL()
    // Browse this list
    Library is string
    Library = ExtractString(LibraryList, firstRank, CR)
    WHILE Library <> EOT
      // Retrieve the library
      Trace(ExtractString(Library, 1, TAB))
      // Next library
      Library = ExtractString(LibraryList, nextRank, CR)
    END

  OTHER CASE: Error("X no definida CAPA: "+gapA[1]+" en(200227751) "+sCompilaTXT)
END
