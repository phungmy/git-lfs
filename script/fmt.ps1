param ($goFmtArgs)

# don't run gofmt in these directories
$ignored = @("bin", "docs", "log", "man", "tmp", ".vendor")

foreach ($dir in (get-childitem -directory))
{
    if ($ignored -notcontains $dir)
    {
        gofmt -w -l $goFmtArgs $dir
    }
}

script\clean-git-test-fixtures.ps1 > $null
