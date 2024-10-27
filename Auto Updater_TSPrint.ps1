##                Auto Updater for TSPrint Server                 ## 
##                     Made by Samie                              ##

## All areas that need to be filled out by you are marked as "INPUT" ##

$installLink = (Invoke-WebRequest -uri "https://www.terminalworks.com/remote-desktop-printing/downloads").Links

$newInstallLink = $installLink | Where-Object { $_.href -match 'server' } | Select-Object -ExpandProperty href
$newInstallVer = $newInstallLink | Select-String -Pattern '((?:\d{1,3}\.){3}\d{1,3})' | ForEach-Object {
    $_.Matches[0].Groups[0].Value
}

$filePathCurrent = "C:\Program Files (x86)\TerminalWorks\TSPrint Server\Startup.exe"
$currentInstallVer = (Get-Item $filePathCurrent).VersionInfo.FileVersion

## Please enter where you would like the new install to go 
$filePathNew = "INPUT"

$newInstallInstall = "https://www.terminalworks.com" + $newInstallLink 

if ([System.Version]$newInstallVer -gt [System.Version]$currentInstallVer) { 
    Invoke-WebRequest -uri $newInstallInstall -OutFile $filePathNew 
    &$filePathNew /S /V /qn /SP- /VERYSILENT /SUPPRESSMSGBOXES /NORESTART 
    Write-Output "Update complete!"
}   else {
        Write-Output "Update not needed"
        }