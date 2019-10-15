<#
.SYNOPSIS
    Este script permite realizar la suma de dos matrices o el producto escalar.

.PARAMETER Entrada
    Path del archivo que contiene la matriz.

.PARAMETER Producto
    Numero a ser utilizado para el producto escalar.

.PARAMETER Archivos
    Path del archivo que contiene la matriz a sumar.

.EXAMPLE
    ejercicio6.ps1 -Entrada=matriz1 -Suma=matriz2
    Suma la matriz1 con la matriz2
.EXAMPLE

    ejercicio6.ps1 -Entrada=matriz2 -Producto=10
    Toma la matriz2 y realiza el producto escalar con 10
#>
<#
***********************************************************************************
 Nombre Del Script:        ejercicio6.ps1
 Trabajo Practico Nro.:    2
 Ejercicio Nro.:           6
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
    [Parameter( Mandatory = $true, ParameterSetName = "Producto")]
    [Parameter( Mandatory = $true, ParameterSetName = "Suma")]
    [ValidateNotNullOrEmpty()]
    [string]$Entrada,
	
    [Parameter( Mandatory = $false, ParameterSetName = "Producto")]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(2, [int]::MaxValue)]
    [ValidatePattern("[0-9]")]
    [int]$Producto,

    [Parameter(Mandatory = $false, ParameterSetName = "Suma")]  
    [ValidateNotNullOrEmpty()]
    [string]$Suma
)
if ($Suma -and $Producto) {
    Write-Host "Solo se admite una opcion a la vez"
    exit
}
if (!(Test-Path -Path $Entrada)) {
    Write-Host "Ingrese un archivo valido."
    exit
}

$texto_archivo = Get-Content -Path $Entrada;

if ($texto_archivo.count -eq 0) {
    Write-Host "Archivo ENTRADA vacio, verifique nuevamente"
    exit
}
$renglones = ($texto_archivo.Split('\n')); #Paso las palabras a un vector.

$matrizA = @()
For ($i = 0; $i -lt $renglones.Length; $i++) {
    $valores = ($renglones[$i].Split('|'));
    $arr = @()
    For ($j = 0; $j -lt $valores.Length; $j++) {
        $arr += [double]$valores[$j];
    }
    $matrizA += , $arr;
}

$Entrada2 = "$Suma";
$matrizResultante = @();

if ($Entrada2 -ne "") {
    if (!(Test-Path -Path $Entrada2)) {
        Write-Host "Ingrese un archivo valido."
        exit
    }

    $texto_archivo2 = Get-Content -Path $Entrada2;
    if ($texto_archivo2.count -eq 0) {
        Write-Host "Archivo SUMA vacio, verifique nuevamente"
        exit
    }
    $renglones2 = ($texto_archivo2.Split('\n')); #Paso las palabras a un vector.
    $matrizB = @()
    For ($i = 0; $i -lt $renglones.Length; $i++) {
        $valores = ($renglones2[$i].Split('|'));
        $arr = @()
        For ($j = 0; $j -lt $valores.Length; $j++) {
            $arr += [double]$valores[$j] + [double]$matrizA[$i][$j];
        }
        $matrizB += , $arr;
    }
    $matrizResultante = $matrizB;
}
else {
    For ($i = 0; $i -lt $renglones.Length; $i++) {
        $valores = ($renglones[$i].Split('|'));
        $arr = @()
        For ($j = 0; $j -lt $valores.Length; $j++) {
            $arr += [double]$valores[$j] * $Producto;
        }
        $matrizResultante += , $arr;
    }
}


$nombreArchivo = $Entrada.Split("\")
$nombreArch = $nombreArchivo[$nombreArchivo.Count - 1]
#Salida del archivo
$salida = "$PSScriptRoot\salida.$nombreArch"
#Creo o limoio el archivo

Set-Content "$salida" -Value "" -NoNewline
#Imrpimo
foreach ($element in $matrizResultante) {
    $renglon = "";
    foreach ($i in $element) {
        $renglon += [string]$i + "|";
    }
    
    $renglon.TrimEnd("|") | Add-Content "$salida"
}
