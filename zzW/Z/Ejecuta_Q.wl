//EXTERN ".\zzW\Ejecuta_Q.wl" // windows



IF gapA[1] = "" THEN Error("X  aucente en "+sCompilaTXT); RETURN

arrPQ is array <growth=1> of string
// Ejecuta("F","CALC;VN|CIA:BX,DB:HIF,DB4=K2,FECHA1:20191231|guarda en txt")
StringToArray(gapA[1],arrPQ,"|")	// "pEw" , "pAw" , "pBw"  		pEw<-- "CALC;VN"
Open(WIN_Q,gsCas+arrPQ[1]+gsCas , gsCas+arrPQ[2]+gsCas , gsCas+arrPQ[3]+gsCas) // solo comandos directos
IF Upper(Left(ggsLog,1)) = "X" THEN Error(ggsLog)
