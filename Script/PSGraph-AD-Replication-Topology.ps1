$b = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().Sites | Select-Object name,@{l='links';e={$x=$_.name;$_.sitelinks.Sites|where name -ne $x}},@{l='subnets';e={$z="";$_.subnets.name.foreach({$z=$z+"`n"+$_});$z}}
graph sitereplication @{rankdir='LR'}{
    Node @{shape='rect'}

    $edgeparam = @{
        node = $b
        fromscript  = {$_.name}
        toscript = {$_.links}
    }

    Edge @edgeparam

} | Show-PSGraph -LayoutEngine Hierarchical