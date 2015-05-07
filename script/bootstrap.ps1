param ($goArgs)

script\fmt.ps1

remove-item -recurse -force "$pwd\bin\*"
remove-item -recurse -force "$pwd\.vendor\pkg"

$env:LocalsRcDir="$pwd\.vendor\src\github.com\github\git-lfs"
new-item $env:LocalsRcDir -itemtype directory -force
cmd /c rmdir -f $env:LocalsRcDir # PowerShell does not natively support symbolic links, so need to do a rmdir via cmd otherwise it may delete the contents of the $pwd.
cmd /c mklink /d $env:LocalsRcDir $pwd # PowerShell does not natively support symbolic links, so need to invoke mklink via cmd to create the link.

$env:GOPATH="$pwd\.vendor"
go run script\*.go -cmd build $goArgs
