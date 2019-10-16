<#
.SYNOPSIS
    Este script permite, utilizando un archivo CSV, el movimiento de archivos de un lugar de origen hacia otro destino. Al realizar esta operacion, se guardara en un archivo separado por comas el nombre del destino asi como la fecha y hora del momento de ejecucion.

.PARAMETER Entrada
    Ruta del archivo de entrada, que contiene los nombres de los archivos en origen y su correspondiente en destino

.PARAMETER Salida
    Ruta donde se almacenara el archivo de salida a forma de log de las operaciones realizadas, conteniendo el path de destino asi como la fecha y hora.

.EXAMPLE
    ejercicio3.ps1 .\archivos\entrada.csv salida.csv

    Se toman el archivo entrada.csv, donde el primer campo sera el archivo en origen y el segundo en destino. Todos aquellos archivos que sea posible mover, se tomara el path destino, asi como la fecha y hora de la operacion y se escribiran en el archivo salida.csv
#>

<#
***********************************************************************************
 Nombre Del Script:        ejercicio3.ps1
 Trabajo Practico Nro.:    2
 Ejercicio Nro.:           3
 Entrega Nro.:             1
 Integrantes:

    Apellido            Nombre                  DNI
    --------------------------------------------------
   
   Krasuk              Joaquín               40745090
   Rodriguez           Christian             37947646
   Vivas               Pablo                 38703964

***********************************************************************************
#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory = $True, Position = 1)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript( {
            if (-Not ($_ | Test-Path -PathType Leaf) ) {
                throw "El PATH ingresado debe ser un archivo"
            }
            if ($_ -notmatch "(\.csv)") {
                throw "El archivo debe ser del tipo .csv"
            }
            return $true 
        })]
    [string]$Entrada,
	
    [Parameter(Mandatory = $True, Position = 2)]
    [ValidateNotNullOrEmpty()]
    [ValidateScript( {
            if ($_ -notmatch "(\.csv)") {
                throw "El archivo debe ser del tipo .csv"
            }
            return $true 
        })]
    [string]$Salida
)

#Verifico si la entrada existe
if (Test-Path -Path $Entrada ) {
    #Si no tengo el dir base, debo crearlo.
    $dirBase = Split-Path -Path $Salida
    
    if ($dirBase -ne "" -and (Test-Path -Path $dirBase)) {
        New-Item -ItemType Directory -Force -Path $dirBase
    }

    #Hago el import del csv
    $lista = Import-Csv -Path $Entrada  -Delimiter  ','
    $arrMovimientos = @()

    #Validacion del CSV de entrada
    if ($lista[0].psobject.properties.name.count -ne 2 -or $lista[0].psobject.properties.name[0] -ne 'origen' -or $lista[0].psobject.properties.name[1] -ne 'destino') {
        Write-Host "Archivo .csv origen invalido"
        exit
    }
    
    #Voy recorreando renglon a renglon el CSV
    foreach ($line in $lista) {   

        #Compruebo que puedo mover el archivo
        if (Test-Path -Path $line.origen ) {
            #Si no tengo el dir base del destino, debo crearlo.
            $dirBaseDestino = Split-Path -Path $line.destino
            if (!(Test-Path -Path $dirBaseDestino)) {
                New-Item -ItemType Directory -Force -Path $dirBaseDestino
            }
            
            Move-Item -Path $line.origen -Destination $line.destino -Force

            #Obtengo la fecha actual
            $hoy = Get-Date -Format "dd/MM/yyyy HH:mm:ss";
            #Creo mi objeto
            $obj = New-Object -TypeName psobject
            #Agrego los atributos al archivo
            $obj | Add-Member NoteProperty -Name "archivo" -Value $line.destino
            $obj | Add-Member NoteProperty -Name "fecha" -Value $hoy

            #Lo sumo al array
            $arrMovimientos += $obj;
        }
    } 

    #Escribo el array en csv y hago un append
    $arrMovimientos | Export-Csv $Salida -Delimiter ',' -NoTypeInformation -Append
}
else {
    Write-Host "El archivo de entrada no se puede acceder."
}