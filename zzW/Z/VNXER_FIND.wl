//EXTERN ".\zzW\VNXER_FIND.wl" // windows



// ***  gsBloqueP = VNXER de un solo día  ***

gsBloqueP = "" // Asegura
IF ggsFecha1 = "" OR DateValid(ggsFecha1) = False THEN ggsFecha1 = Today()
sfiltro is string = "SELECT * FROM lWe WHERE cata='VNXER' AND fecha="+ggsFecha1
IF ggsDB = "MONGO" OR ggsDBTemp = "MONGO" THEN
  sfiltro = ";"+ggsKataAlias+";;;;;;;;;;;;;;;"+ggsFecha1
  //IF NOT YesNo("(WIN_Q mongo) Continuo ?","",ggsCiaTemp,"DB="+ggsDBtemp,"CX="+ggsDB4Temp,sfiltro) THEN Close() ELSE nDebug = 65
  Open(WIN_A,"ME",sfiltro)
ELSE
  //IF NOT YesNo("(WIN_Q) Continuo ?","", ggsCiaTemp, "DB="+ggsDBtemp, "CX="+ggsDB4Temp, sfiltro) THEN Close() ELSE nDebug = 65
  Open(WIN_K,"KH",sfiltro)
END
IF Upper(Left(gsBloqueP,1)) = "X" THEN gsBloqueP = ""
IF gsBloqueP = "" THEN Error("VNXER_FIND... ","","no hay DATA en "+ggsFecha1); Close()
IF nDebug = 65 THEN Info("VNXER_FIND  gsBloqueP... ","",gsBloqueP)
