$scriptPath = Split-Path $MyInvocation.InvocationName
& "$scriptPath\fmt.ps1"

$binDir = "$pwd\bin"
$pkgDir = "$pwd\.vendor\pkg"

if (Test-Path $binDir)
{
    Remove-Item -recurse -force $binDir
}

if (Test-Path $pkgDir)
{
    Remove-Item -recurse -force "$pwd\.vendor\pkg"
}

$Env:LOCALSRCDIR="$pwd\.vendor\src\github.com\github\git-lfs"
$githubDir = Split-Path $Env:LOCALSRCDIR
if (!(Test-Path $githubDir))
{
    New-Item $githubDir -itemtype directory -force
}
cmd /c rmdir -f $Env:LOCALSRCDIR # PowerShell does not natively support symbolic links, so need to do a rmdir via cmd otherwise it may delete the contents of the $pwd.
cmd /c mklink /d $Env:LOCALSRCDIR $pwd # PowerShell does not natively support symbolic links, so need to invoke mklink via cmd to create the link.

$Env:GOPATH="$pwd\.vendor"
# TODO: Wildcard is not working below, giving "GetFileAttributesEx script\*.go: The filename, directory name, or volume label syntax is incorrect."
# Figure out correct way to invoke with wild card on Windows.
#go run script\*.go -cmd build @args
go run script\build.go script\release.go script\script.go -cmd build @args
