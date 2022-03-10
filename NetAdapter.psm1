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
        $status, $d = $d.split(" ")
        if ($status -eq "<>") {
            $status = "Disconnected"
        }
        else {
                $status = "Up"
        }
        $mac = $adapts[$i+1].tostring()
        $mac = $mac.split(" ")
        $mediatype = $mac[$mac.length-2]
        $mac = $mac[$mac.length-1]
        $mac = $mac.replace(":","-")
        if ($mediatype -eq "link/ether") {
            $mediatype = $mediatype.replace("link/ether","802.3")
        }
        elseif ($mediatype -eq "link/ieee802.11") {
            $mediatype = $mediatype.replace("link/ieee802.11","Native 802.11")
        }
        elseif ($mediatype -eq "link/loopback") {
            $mediatype = $mediatype.replace("link/loopback","802.3")
        }
        Add-Member -InputObject $adapter -MemberType NoteProperty -name Name -Value $adaptname
        Add-Member -InputObject $adapter -MemberType NoteProperty -name ifIndex -Value $ifindex
        Add-Member -InputObject $adapter -MemberType NoteProperty -name Status -Value $status
        Add-Member -InputObject $adapter -MemberType NoteProperty -name MacAddress -Value $mac
        Add-Member -InputObject $adapter -MemberType NoteProperty -name MediaType -Value $mediatype
        $adapters += $adapter
      }
      
      $adapters
      
    }
}

Export-ModuleMember -Function Get-NetAdapter
