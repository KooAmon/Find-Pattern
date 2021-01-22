Function Find-Pattern{
    <#
    .SYNOPSIS
    Searches files in a path for a pattern

    .DESCRIPTION
    Searches for patterns in files within a path.  This can be filtered to specific file/path name/extentions and be recursive.  It returns the LineNumber, Path, and Line found.
    
    .PARAMETER Path
    Path to a folder\file to start the search.

    Example "c:\temp"

    .PARAMETER Pattern
    Pattern to search for

    Example "funny"

    .EXAMPLE
    Find files inside the etc directory with the word "tcp" in it
    Find-Pattern -Path "c:\windows\system32\drivers\etc\" -Pattern "tcp" -Recurse -Filter "serv*"

    LineNumber Path                                     Line
    ---------- ----                                     ----
        10 C:\Windows\System32\drivers\etc\services echo                7/tcp
        12 C:\Windows\System32\drivers\etc\services discard             9/tcp    sink null
        14 C:\Windows\System32\drivers\etc\services systat             11/tcp    users                  #Active users
        16 C:\Windows\System32\drivers\etc\services daytime            13/tcp
        18 C:\Windows\System32\drivers\etc\services qotd               17/tcp    quote                  #Quote of the day
    #>
    [CmdletBinding(ConfirmImpact='Low')]
    Param(
        [Parameter(Position = 1, Mandatory)][string]$Path,
        [Parameter(Position = 2, Mandatory)][string]$Pattern,
        [Parameter()][string]$Filter,
        [Parameter()][switch]$Recurse
    )

    $Command = "get-childitem -Path $Path"
    if ($Recurse) { $Command += " -Recurse" }
    if ($Filter.Length -gt 0) { $Command += " -Filter $Filter" }
    $Command += " | Select-String -pattern $Pattern | Format-Table -Property LineNumber, Path, Line -RepeatHeader -AutoSize"

    Invoke-Expression $Command
}
