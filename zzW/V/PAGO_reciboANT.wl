//EXTERN ".\zzW\PAGO_reciboANT.wl" // android Windows



//    E M P L E A D O S
ggsSoyCodigo = INIRead("EMPL","Usuario","9999",ggsIni)
ggsSoyNombre = INIRead("EMPL","Nombre","Anonimo",ggsIni)
ggNumeroCelular= INIRead("EMPL","Celular","",ggsIni)


//    E S T A C I O N
// Lee desde el INI cuál es la estación. Puede ser mayor a 1
// siempre numerica para minimizar errores
ggsEst  = NumToString(Val(Right(INIRead("cfg","Estacion","NULA",ggsIni),4)))
IF Val(ggsEst) = 0 THEN ggsEst = NumToString(Val(Right(INIRead("cfg","Estacion","NULA",ggsIni),3)))
IF Val(ggsEst) = 0 THEN ggsEst = NumToString(Val(Right(INIRead("cfg","Estacion","NULA",ggsIni),2)))
IF Val(ggsEst) = 0 THEN ggsEst = NumToString(Val(Right(INIRead("cfg","Estacion","NULA",ggsIni),1)))
IF Val(ggsEst) = 0 THEN ggsEst = Right(Now(),4) ;INIWrite("cfg","Estacion",ggsEst,ggsIni)

ggsRef = "_"+Right(Now(),3)   // R e f e r e n c i a



//    P R E F I J O S    C O D I G O
// 91201 ... 00130  Y:19 ... 20   M:901 ... 912    W:1 ... 52
ggsCDe = ";"+Right(Today(),5)+"_"    ;ggsCMe = ";"+Middle(Today(),4,3)+"_"	// 
ggsCYe = ";"+Middle(Today(),3,2)+"_" ;ggsCWe = ";"+DateToWeekNumber(Today())+"_"


//    Y e a r     M e s     W e e k
IF INIRead("DATA","YEAR","NULO",ggsIni) = "NULO" THEN INIWrite("DATA","YEAR","N",ggsIni)
IF INIRead("DATA","MES","NULO",ggsIni) = "NULO" THEN INIWrite("DATA","MES","N",ggsIni)
IF INIRead("DATA","WEEK","NULO",ggsIni) = "NULO" THEN INIWrite("DATA","WEEK","N",ggsIni)
IF Upper(INIRead("DATA","YEAR","N",ggsIni)) IN ("Y","S","1") THEN ggbYe = True
IF Upper(INIRead("DATA","MES","N",ggsIni)) IN ("Y","S","1") THEN ggbMe = True
IF Upper(INIRead("DATA","WEEK","N",ggsIni)) IN ("Y","S","1") THEN ggbWe = True


//  ASEGURA ...
ggsRef = "_"+Right(Now(),3)
ggsALES = ""; ggsVNXE = 0; ggsVNXER = ""; ggsVNXI = "" ;ggsVN = ""
