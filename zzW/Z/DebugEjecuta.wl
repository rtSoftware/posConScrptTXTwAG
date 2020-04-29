//EXTERN ".\zzW\Z\DebugEjecuta.wl" // windows



//Info("DebugEjecuta...","gapA[1]="+gapA[1],"gapA[1]="+ArrayCount(gapA))
IF Left(gapA[1],1) = "*" THEN
  gapA[1] = Right(gapA[1],Length(gapA[1])-1); nDebug = Today()
ELSE
  IF Contains(sCompilaTXT , INIRead("cfg","Debug","",ggsIni),IgnoreCase) THEN nDebug = Today(); ggnE3++
END
//IF ggsDebug <> "" THEN INIWrite("Debug","ULTIMO",sCompilaTXT,ggsIni)

IF nDebug = Today() THEN
  Info("     DebugEjecuta...","","gapE[1]="+gapE[1],"gapE[2]="+gapE[2],"gapA[1]="+gapA[1],"gapA[2]="+gapA[2],"gapA[3]="+gapA[3],"","sCompilaTXT="+sCompilaTXT)
  //Info(ggnE3+" "+sCompilaTXT,"","     tarEa: ",gapE[1],"     parAm: ",gapA[1])
END
