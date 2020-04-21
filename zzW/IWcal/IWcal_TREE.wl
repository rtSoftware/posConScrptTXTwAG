//EXTERN ".\zzW\IWcal\IWcal_TREE.wl" // windows

//Ejecuta("TREE")
//Ejecuta("TREE","algo.TXT")
/////////////////////////////////////////////////////////////////////////
// Flujo:
//
/////////////////////////////////////////////////////////////////////////
// nDebug = Today()
// 		SI: Ejecuta("gapE[1]","*gapA[1]")
// 		SI: INIRead("cfg","Debug","",ggsIni) = sCompilaTXT
EXTERN ".\zzW\Z\DebugEjecuta.wl"

{gestoyEn,indWindow}..Plane = 8

arrTREE is array of ANSI string
//ArrayDeleteAll(arrTREE)
nCpa1 = 0

  // ARBOL //
TreeAdd(TREE_1, "Universo", tvDefault, tvDefault)

  // RAMAS //
TreeAdd(TREE_1, "Universo" + TAB + "Cat�logos", tvDefault, tvDefault)
TreeAdd(TREE_1, "Universo" + TAB + "Reportes", tvDefault, tvDefault)

  // HOJAS //
ArrayAdd(arrTREE,"Empleados") ;nCpa1++	/////////////////////
TreeAdd(TREE_1, "Universo" + TAB + "Cat�logos" + TAB +  ...
arrTREE[nCpa1], tvDefault, tvDefault)

ArrayAdd(arrTREE,"Productos") ;nCpa1++	/////////////////////
TreeAdd(TREE_1, "Universo" + TAB + "Cat�logos" + TAB +  ...
arrTREE[nCpa1], tvDefault, tvDefault)

ArrayAdd(arrTREE,"Proveedores") ;nCpa1++	/////////////////////
TreeAdd(TREE_1, "Universo" + TAB + "Cat�logos" + TAB +  ...
arrTREE[nCpa1], tvDefault, tvDefault)
