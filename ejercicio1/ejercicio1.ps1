<#
***********************************************************************************
 Nombre Del Script:        ejercicio1.ps1
 Trabajo Practico Nro.:    2
 Ejercicio Nro.:           1
 Entrega Nro.:             1
 Integrantes:
    Apellido            Nombre                  DNI
    --------------------------------------------------
   
   Krasuk              Joaquín               40745090
   Rodriguez           Christian             37947646
   Vivas               Pablo                 38703964
***********************************************************************************
#>


Param (
    #Path salida es el primer parametro en ser enviado, y no es obligatorio enviarlo (por default tiene procesos.txt)
    [Parameter(Position = 1, Mandatory = $false)]
    [String] $pathsalida = ".\procesos.txt ",
    #En este caso, por default la cantidad de procesos a mostrar por pantalla sera 3
    [int] $cantidad = 3
)
#Verifica si existe $pathSalida
$existe = Test-Path $pathsalida
if ($existe -eq $true) {
    #Obtiene la lista de procesos
    $listaproceso = Get-Process
    #Recorre cada proceso
    #Los formatea como:
    # ID: XX 
    # Name: Nombre
    #Y hace un append en el archivo de salida
    foreach ($proceso in $listaproceso) {
        #Se utiliza -Property Id, Name ya que solamente se quieren conocer esas dos propiedades
        #Get-Process tambien posee Handles, CPU y SI
        $proceso | Format-List -Property Id, Name >> $pathsalida
    }

    #Imprime los primeros N elementos de la lista
    #Donde N es la variable $cantidad
    for ($i = 0; $i -lt $cantidad ; $i++) {
        Write-Host $listaproceso[$i].Name - $listaproceso[$i].Id
    }
}
else {
    #En caso contrario, imprime
    Write-Host "El path no existe"
}

# 1) El objetivo del script es escribir en un archivo ya existente (el cual por default es procesos.txt, o uno    ingresado por el usuario) todos los procesos del sistema, con su nombre y ID. Luego, muestra por pantalla los N primeros procesos.
# 2) Validaria que el path es efectivamente un archivo (si se trata de un directorio, se muestra el siguiente mensaje de error: "out-file : Access to the path 'D:\dev\sisop\TP2\ejercicio1\prueba' is denied."). Otra validacion podria ser que la cantidad ingresada por parametro no sea mayor a la cantidad de profesos que efectivamente se estan corriendo al momento de la ejecucion.
#
# 3) Si se ejecuta el script sin ningun parametro, pueden ocurrir dos situaciones:
#       a) Si el archivo procesos.txt no existe, se indicara que el path no existe.
#       b) Si el archivo procesos.txt existe, entonces se comenzara a ejecutar el script y hara un append en el archivo
