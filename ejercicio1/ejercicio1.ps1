Param (
    [Parameter(Position = 1, Mandatory = $false)]
    [String] $pathsalida = ".\procesos.txt ",
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

# 1) El objetivo del script es escribir en un archivo (el cual por default es procesos.txt, o uno    ingresado por el usuario) todos los procesos del sistema, con su nombre y ID.
# 2) Validaria que el path es efectivamente un archivo (si se trata de un directorio, se muestra el siguiente mensaje de error: "out-file : Access to the path 'D:\dev\sisop\TP2\ejercicio1\prueba' is denied.")
# 3) Si se ejecuta el script sin ningun parametro, pueden ocurrir dos situaciones:
#       a) Si el archivo procesos.txt no existe, se indicara que el path no existe.
#       b) Si el archivo procesos.txt existe, entonces se comenzara a ejecutar el script y hara un append en el archivo
