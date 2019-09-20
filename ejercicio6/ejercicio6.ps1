<#
***********************************************************************************
 Nombre Del Script:        ejercicio6.ps1
 Trabajo Practico Nro.:    1
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
    [Parameter(Mandatory = $True, Position = 1)]
    [ValidateNotNullOrEmpty()]
    [string]$Entrada,
	
    [Parameter(Mandatory = $false, Position = 2)]
    [ValidateNotNullOrEmpty()]
    [int]$Producto,

    [Parameter(Mandatory = $false, Position = 2)]
    [ValidateNotNullOrEmpty()]
    [string]$Suma
)

$texto_archivo = Get-Content -Path $Entrada;
$renglones = ($texto_archivo.Split('\n')); #Paso las palabras a un vector.

$matrizA = @()
For ($i = 0; $i -lt $renglones.Length; $i++) {
    $valores = ($renglones[$i].Split('|'));
    $arr = @()
    For ($j = 0; $j -lt $valores.Length; $j++) {
        $arr += [int]$valores[$j] * 5;
    }
    $matrizA += , $arr;
}

$Entrada2 = "$Suma";
$matrizResultante = @();

if ($Entrada2 -ne "") {
    $texto_archivo2 = Get-Content -Path $Entrada2;
    $renglones2 = ($texto_archivo2.Split('\n')); #Paso las palabras a un vector.
    $matrizB = @()
    For ($i = 0; $i -lt $renglones.Length; $i++) {
        $valores = ($renglones2[$i].Split('|'));
        $arr = @()
        For ($j = 0; $j -lt $valores.Length; $j++) {
            $arr += [int]$valores[$j] + [int]$matrizA[$i][$j];
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
            $arr += [int]$valores[$j] * $Producto;
        }
        $matrizResultante += , $arr;
    }
}

$salida = "./salida." + $Entrada

#Salida del archivo
#Creo o limoio el archivo
Set-Content $salida -Value "" -NoNewline
#Imrpimo
foreach ($element in $matrizResultante) {
    $renglon = "";
    foreach ($i in $element) {
        $renglon += [string]$i + "|";
    }
    
    $renglon.TrimEnd("|") | Add-Content $salida
}
