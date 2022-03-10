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
      $adapts = (ip link)
      $adapters = @()
      
      for ($i = 0; $i -lt $adapts.length; $i = $i + 2) {
        $adapter = New-Object psobject
        $ifindex,$adaptname,$d = $adapts[$i].tostring().split(": ")
        $mac = $adapts[$i+1].tostring()
        $mac = $mac.split(" ")
        $mac = $mac[$mac.length-1]
        $mac = $mac.replace(":","-")
        Add-Member -InputObject $adapter -MemberType NoteProperty -name Name -Value $adaptname
        Add-Member -InputObject $adapter -MemberType NoteProperty -name ifIndex -Value $ifindex
        Add-Member -InputObject $adapter -MemberType NoteProperty -name MacAddress -Value $mac
        $adapters += $adapter
      }
      
      $adapters
      
    }
}

Export-ModuleMember -Function Get-NetAdapter
