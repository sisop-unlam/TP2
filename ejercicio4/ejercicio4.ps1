<#
***********************************************************************************
 Nombre Del Script:        ejercicio4.ps1
 Trabajo Practico Nro.:    2
 Ejercicio Nro.:           4
 Entrega Nro.:             1
 Integrantes:
    Apellido            Nombre                  DNI
    --------------------------------------------------
   
   Krasuk              Joaquín               40745090
   Rodriguez           Christian             37947646
   Vivas               Pablo                 38703964
***********************************************************************************
#>

<#
.SYNOPSIS
    Este script permite realizar las siguientes operaciones sobre archivos ZIP:
	-Descompresión: Descomprime un archivo ZIP en un directorio pasado por parámetro.
	-Compresión: Comprime un directorio en un archivo .ZIP.
	-Información: Muestra un listado con los nombres de los archivos, el peso y la relación de compresión, que se encuentran dentro de un archivo ZIP.
	
.PARAMETER PathZip
    Path del archivo ZIP.
	
.PARAMETER Directorio
   Indica el directorio a comprimir o el destino de la descompresión del archivo ZIP.
   
.PARAMETER Descomprimir
    Indica que el modo de operación es “Descompresión”.
	
.PARAMETER Comprimir
	Indica que el modo de operación es “Compresión”.
	
.PARAMETER Informar
    Indica que el modo de operación es “Información”.
	
.EXAMPLE
    ejercicio4.ps1 -Descomprimir -pathZip "path origen del archivo .zip" -Directorio "directorio de destino para descomprimir"

.EXAMPLE
    ejercicio4.ps1 -Informar -pathZip "path del archivo .zip"
	
.EXAMPLE
    ejercicio4.ps1 -Comprimir -pathZip "path  destino del archivo .zip" -Directorio "directorio a comprimir"
#>

[CmdletBinding()]
Param(
    [Parameter(Position = 0,ParameterSetName = "Descompresión",Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [switch]$Descomprimir,
	
    [Parameter(Position = 0,ParameterSetName = "Compresión",Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [switch]$Comprimir,

    [Parameter(Position = 0,ParameterSetName="Informacion",Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [switch]$Informar,
	
	[Parameter(ParameterSetName = "Compresión",Mandatory = $true)]
	[Parameter(ParameterSetName = "Descompresión",Mandatory = $true)]
	[Parameter(ParameterSetName = "Informacion",Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$PathZip,
	
	[Parameter(ParameterSetName = "Compresión",Mandatory = $true)]
	[Parameter(ParameterSetName = "Descompresión",Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Directorio
	
	
)

if (-not $Descomprimir -and -not $Comprimir -and -not $Informar) {
    Write-Host "Ingrese un parametro"
    exit
}

Add-Type -assembly "system.io.compression.filesystem"

#comprimir
if ($Comprimir -and $PathZip -and $Directorio) {
    if ($Directorio) {
    $existe = Test-Path $Directorio
    if (-not $existe) {
        Write-Host "El directorio a comprimir no existe"
        exit
    }
	}
	if ($PathZip) {
    $existe2 = Test-Path $PathZip
    if (-not $existe2) {
        Write-Host "El directorio de destino no existe"
        exit
    }
	}
    
	$date = Get-Date -format "dd-MM-yyyy HH:mm:ss"
	$destination = $PathZip+(Get-Date -format "dd-MM-yyyy HH-mm-ss")+(".zip")
	
	Write-Host "Comprimiendo.............."
	#Compress-Archive -Path $Directorio  -CompressionLevel Optimal -DestinationPath $destination #sin la clase zipfile
	[io.compression.zipfile]::CreateFromDirectory($Directorio, $destination) #con  la clase zipfile
	
	exit
}

#descomprimir
if ($Descomprimir -and $PathZip -and $Directorio) {
    if ($Directorio) {
    $existe = Test-Path $Directorio
    if (-not $existe) {
        Write-Host "El directorio de destino no existe"
        exit
    }
	}
	if ($PathZip) {
    $existe2 = Test-Path $PathZip
    if (-not $existe2) {
        Write-Host "El directorio a descomprimir no existe"
        exit
    }
	}
    
	
	
	Write-Host "Descomprimiendo.............."
	#Expand-Archive $PathZip -DestinationPath $Directorio  #sin la clase zipfile
	[io.compression.zipfile]::ExtractToDirectory($PathZip,  $Directorio)  #con  la clase zipfile
	
	exit
}


