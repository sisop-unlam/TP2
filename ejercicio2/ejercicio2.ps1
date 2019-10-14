
<#
    .SYNOPSIS
        Cantidad de instancia de los procesos.
    .DESCRIPTION
        Informa la cantidad de instancias de los procesos que se encuentran corriendo en el sistema 
        dada una determinada cantidad de instancias(minima) pasada por parametro.
    .PARAMETER Cantidad
        Numero minimo de instancias que debe tener el/los procesos.
    .EXAMPLE
        C:\Users\Pablo\Desktop> .\Ejer2TPPowerShell.ps1 -Cantidad 2
        C:\Users\Pablo\Desktop> .\Ejer2TPPowerShell.ps1
#>

<#
***********************************************************************************
 Nombre Del Script:        ejercicio2.ps1
 Trabajo Practico Nro.:    2
 Ejercicio Nro.:           2
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
param (
    
    [ValidateRange(2, [int]::MaxValue)]
    [ValidateNotNullOrEmpty()]
    [ValidatePattern("[0-9]")]
    [Parameter(Mandatory = $true, Position = 0)] 
    [Int]
    $Cantidad
)
    
#Me quedo con los nombres de los procesos
$var = (Get-Process | Group-Object -NoElement -Property name)


$hash = @{ }

#Genero el hashTable con los nombre de los procesos y las cantidad de instancias
foreach ($i in $var) {
    $hash[$i.Name] = $i.Count
}

#Muestros las claves que cumplan la condicion >Cantidad
foreach ($valor in $hash.GetEnumerator()) {
    if ($valor.value -gt $Cantidad) {
        write-host  $valor.Key 
    }
    
}
  
