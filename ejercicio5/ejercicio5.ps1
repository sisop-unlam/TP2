<#
.SYNOPSIS
    Este script retorna la cantidad de procesos corriendo o los archivos en un directorio, cada cierta cantidad de tiempo

.PARAMETER Procesos
    Variable tipo switch para elegir ver la cantidad de procesos siendo ejecutados

.PARAMETER Peso
    Variable tipo switch que indica que se mostrará el peso de un directorio.

.PARAMETER Directorio
    Indica el directorio a evaluar. Debe usarse en conjunto con el parametro "Peso"

.EXAMPLE
    ejercicio5.ps1 -Procesos

    Indica la cantidad de procesos corriendo en el momento de ejecucion
.EXAMPLE

    ejercicio5.ps1 -Peso -Directorio C:\Windows

    Indica el tamaño del directorio C:\Windows
#>

<#
***********************************************************************************
 Nombre Del Script:        ejercicio5.ps1
 Trabajo Practico Nro.:    1
 Ejercicio Nro.:           5
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
    [Parameter(ParameterSetName = "Procesos", Mandatory = "true" ) ]
    [switch]$Procesos,
	
    [Parameter(ParameterSetName = "Peso", Mandatory = "true" ) ]
    [switch]$Peso,

    [Parameter(ParameterSetName = "Peso", Mandatory = "true" ) ]
    [string]$Directorio
)

switch ($PSCmdlet.ParameterSetName) {
    'Procesos' {  
        if ($Procesos -and $Peso) {
            Write-Host "Solo puede usarse uno a la vez"
            exit
        }

        while ($true) {
            $cantidadProcesos = Get-process
            Write-Host $cantidadProcesos.Count
           
            #Cada 10 segundos
            Start-Sleep 10
        }
    }
    'Peso' {
        if ($Directorio -and (-not $Peso)) {
            Write-Host "Para pasar un directorio se necesita usar -Peso"
            exit
        }

        if ($Directorio) {
            $existe = Test-Path $directorio
            if (-not $existe) {
                Write-Host "El directorio no existe"
                exit
            }
        }

        while ($true) {
            "{0}" -f ((Get-ChildItem $Directorio -Recurse | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum)
            
            #Cada 10 segundos
            Start-Sleep 10
        }
    }
}




