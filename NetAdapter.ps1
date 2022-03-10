function Get-NetAdapter {

    <#
    .SYNOPSIS
        Gets the basic network adapter properties.

    .EXAMPLE
        PS> Get-NetAdapter
    #>

    [CmdletBinding()]

    param (

    )
    
    process {
      $adapts = (ip address)
      Write-Host "$adapts"
    }
}

Export-ModuleMember -Function Get-NetAdapter
