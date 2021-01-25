# Find-Pattern

## Purpose

This module came about as a orderly way to run a command with more verbose output.  The command that this is based off of is used to search through files in a directory and find certain patterns.

While the original command worked fine, more details such as the Line Number and Line found were not reported back to the user.  These details could be helpful when searching through results.

### Original Command

Simple Get-ChildItem with Grouping and Selecting to parse down the output.

```Powershell
Get-ChildItem -Path <path> -Recurse -Filter <filter> | Select-String -Pattern <pattern> | Group-Object Path | Select-Object Name
```

### Find-Pattern Command

This is the Core Logic of the command.  Instead of Grouping the objects and Selecting only the *Name* as output, this pulls the *LineNumber*, *Path*, and *Line* for output

```Powershell
$Command = "get-childitem -Path $Path"
if ($Recurse) { $Command += " -Recurse" }
if ($Filter.Length -gt 0) { $Command += " -Filter $Filter" }
$Command += " | Select-String -Pattern $Pattern | Format-Table -Property LineNumber, Path, Line -RepeatHeader -AutoSize"

Invoke-Expression $Command
```

## Installation

1. Download the latest release
2. Save to *Env:SystemDrive\Users\<username>\Documents\Powershell\Modules\Find-Module\Find-Module.psm1* or your favorite scripts place.
3. Add to your Powershell profile
   1. Run `notepad $Profile`
   2. Add `Import-Module Find-Pattern`
   3. Save your profile
4.  Reload your Powershell instance `& $profile`

## Removal
1. Remove from your Powershell profile
   1. Run `notepad $Profile`
   2. Delete `Import-Module Find-Pattern`
   3. Save your profile
2.  Reload your Powershell instance `& $profile`
