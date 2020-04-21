//EXTERN ".\zzW\IW220\IW220_FIND.wl"

// Ejecuta("FORM")
// Ejecuta("FORM","?")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
// * nombre del control muy importante... asignar en fucnion a gnCapa
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

IF gapA[1] = "?"  OR gsBloqueP = "" THEN
  gsPCata = ""; Input("Cat�logo ?",gsPCata)
  IF gsPCata = "" THEN RETURN

  // B U S C A
  gsBloqueP = ""  // Asegurna
  Ejecuta("E",";"+gsPCata) // prEsenta

END

// -------------------------------------------------------------------------
{gestoyEn,indWindow}..Plane = gnCapa   // Asegura
sCpa1 = "TABLE_memoria"; TableDeleteAll({sCpa1,indControl})
IF gnCapa = 2 THEN sCpa1 = "PSHEET_HC"
// -------------------------------------------------------------------------

//      F O R M
IF Upper(Right(pAw,4) = ".TXT") THEN gsBloqueP = fLoadText(pAw)
IF gsBloqueP = "" THEN Error("X DATA aucente ?"); RETURN

ggnX = 0; ggnD = 0
FOR EACH STRING sL OF gsBloqueP SEPARATED BY CR
	IF sL = "" THEN CONTINUE ELSE ggnX++
	sa is array of ANSI string
	StringToArray(sL,sa,";")
	IF gsPCata = "" THEN gsPCata = sa[2]
	IF gsPCata <> sa[2] THEN ggnD++    // Multi Catalogo
	IF sa[2] = "" THEN sa[2] = "XXXX"  //20 MONGO no trae cat�logo ...

  IF sCpa1 = "TABLE_memoria" THEN
  	TableAdd({sCpa1,indControl},""+TAB+sa[2]+TAB+sa[3]+TAB+sa[4]+TAB+sa[5]...
  	+TAB+sa[6]+TAB+sa[7]+TAB+sa[8]+TAB+sa[9]+TAB+sa[10]+TAB+sa[11]...
  	+TAB+sa[12]+TAB+sa[13]+TAB+sa[14]+TAB+sa[15]+TAB+sa[16]+TAB+sa[17]+TAB+sa[18])
  ELSE

  END
END
IF sCpa1 = "TABLE_memoria" THEN TableDisplay({sCpa1,indControl})
IF ggsDB = "MONGO" THEN gsPCata = ""

// ggnD <> 0  ... diferentes CATALOGOS
IF NOT ggnD THEN Ejecuta("TITU",gsPCata)
