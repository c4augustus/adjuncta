# remove Windows Update capability entirely
# by moving critical files to C:\Windoze\System32
#
$username = (Get-WMIObject -ClassName Win32_ComputerSystem).Username
$aclperm = $username, "FullControl", "Allow"
$aclrule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $aclperm
$dirfrom = "C:\Windows\System32"
$dirto = "C:\Windoze\System32"
if (-not (Test-Path $dirto)) {
    mkdir -p $dirto
}
$files = @(
    "usoapi.dll",
    "UsoClient.exe",
    "usocoreps.dll",
    "usocoreworker.exe",
    "usosvc.dll",
    "WaaSAssessment.dll",
    "WaaSMedicAgent.exe",
    "WaaSMedicCapsule.dll",
    "WaaSMedicPS.dll",
    "WaaSMedicSvc.dll",
    "wuapi.dll",
    "wuapihost.exe",
    "wuauclt.exe",
    "wuaueng.dll",
    "wudriver.dll",
    "wups.dll",
    "wups2.dll",
    "wusa.exe",
    "wuuhext.dll",
    "wuuhosdeployment.dll"
)
foreach ($file in $files) {
    $filefrom = "$dirfrom\$file"
    if (Test-Path $filefrom) {
        takeown /F $filefrom
        $aclobj = Get-Acl $filefrom
        $aclobj.SetAccessRule($aclrule)
        Set-Acl -Path $filefrom -AclObject $aclobj
        mv $filefrom $dirto\$file
    }
}
