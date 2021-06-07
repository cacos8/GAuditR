#cargar e instalar librerias
library(googleAuthR)
library(openxlsx)
library(googleAnalyticsR)

#Autorizamos la aplicacion...
gar_auth()


#extraer cuentas para elegir el ID que necesitas
cuentasGA <- ga_account_list()#escribe en consola cuentasGA y tendrás un listado de tus cuentas.
#introducir el ID de cuenta
cuenta_id<-"<INTRODUCE AQUÍ TU id DE CUENTA>"

#extrae todas las propiedades de una cuenta
propiedades<-ga_webproperty_list(cuenta_id)#escribe en consola propiedades y tendrás un listado de tus cuentas.
#introducir el UA elegido
propiedad_id<-"<INTRODUCE AQUÍ TU UA de propiedad>"
propiedad<- ga_webproperty(cuenta_id, propiedad_id)




#estilo para cabeceras en excel
hs <- createStyle(fontColour = "#ffffff", fgFill = "#f39531", fontSize="14",
                  halign = "left", valign = "center", textDecoration = "Bold",wrapText = FALSE)
texto<- "Auditoría realizada por @analisisweb https://analisis-web.es"
timestamp() -> date

#funcion que hace todo el trabajo de construir los excel y poner los datos
audita<-function (cuenta_id,propiedad_id){
for(i in 1:numVistas) {
  #extraer las vistas 
    vistas<-ga_view_list(cuenta_id, propiedad_id)
    numVistas<-nrow(vistas)
  #captura el id de cada vista
    vista_id<-vistas$id[i]
    vista_name<-vistas$name[i]
    propiedad_name<-propiedad$name
    texto_vista<- paste0(propiedad_name,'   Vista: ',vista_name)
    texto_time <-paste0(texto," ",date)
  
  #Crea el objeto excel
  archivo<-createWorkbook()
  #extrae los datos de GA
  wp <- ga_webproperty(cuenta_id, propiedad_id)
  customVArs<-ga_custom_vars_list(cuenta_id, propiedad_id, type = "customDimensions")
  customMetrics<-ga_custom_vars_list(cuenta_id, propiedad_id, type = "customMetrics")
  
  adwords<-ga_adwords_list(cuenta_id, propiedad_id)
 
   filtros<-ga_filter_view_list(cuenta_id,propiedad_id,vista_id)
  objetivos<-ga_goal_list(cuenta_id, propiedad_id, vista_id)
  
 
  
   
    addWorksheet(archivo, sheetName = "VISTAS", gridLines = TRUE)
  writeData(archivo, "VISTAS", vistas, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
  writeData(archivo, "VISTAS", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
  writeData(archivo, "VISTAS", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
  addStyle(archivo, "VISTAS", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)
  
  addWorksheet(archivo, sheetName = "OBJETIVOS", gridLines = TRUE)
  writeData(archivo, "OBJETIVOS", objetivos, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
  writeData(archivo, "OBJETIVOS", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
  writeData(archivo, "OBJETIVOS", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
  addStyle(archivo, "OBJETIVOS", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)
  
  addWorksheet(archivo, sheetName = "ADWORDS", gridLines = TRUE)
  writeData(archivo, "ADWORDS", adwords, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
  writeData(archivo, "ADWORDS", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
  writeData(archivo, "ADWORDS", texto_time, startCol = 1, startRow = 2, colNames = FALSE,headerStyle=hs)
  addStyle(archivo, "ADWORDS", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)
  
  addWorksheet(archivo, sheetName = "FILTROS", gridLines = TRUE)
  writeData(archivo, "FILTROS", filtros, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
  writeData(archivo, "FILTROS", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
  writeData(archivo, "FILTROS", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
  addStyle(archivo, "FILTROS",hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)
  
   addWorksheet(archivo, sheetName = "CUSTOMMETRICS", gridLines = TRUE)
  writeData(archivo, "CUSTOMMETRICS", customMetrics, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
  writeData(archivo, "CUSTOMMETRICS", texto_vista, startCol = 1, startRow = 1,colNames = FALSE,headerStyle=hs)
  writeData(archivo, "CUSTOMMETRICS", texto_time, startCol = 1, startRow = 2,colNames = FALSE,headerStyle=hs)
  addStyle(archivo, "CUSTOMMETRICS", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)
  
   addWorksheet(archivo, sheetName = "CUSTOMDIMENSIONS", gridLines = TRUE)
  writeData(archivo, "CUSTOMDIMENSIONS", customVArs, startCol = 2, startRow = 5, rowNames = TRUE,colNames = TRUE,headerStyle=hs)
  writeData(archivo, "CUSTOMDIMENSIONS", texto_vista, startCol = 1, startRow = 1, colNames = FALSE,headerStyle=hs)
  writeData(archivo, "CUSTOMDIMENSIONS", texto_time, startCol = 1, startRow = 2, colNames = FALSE,headerStyle=hs)
  addStyle(archivo, "CUSTOMDIMENSIONS", hs, rows = 1:2, cols = 1:25, gridExpand = TRUE)
  
  
   #crea nombre de archivo
  nombreArchivo <- paste0("GAauditAW(",vistas$name[i] ,').xlsx')
  
  
  print(nombreArchivo)
  saveWorkbook(archivo, nombreArchivo, overwrite = TRUE) ## save to working directory
  
  
  
}
}
