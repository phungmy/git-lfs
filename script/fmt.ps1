Get-ChildItem -Directory -Exclude bin, docs, log, man, tmp, .vendor | %{ gofmt -w -l "$_" }

script\clean-git-test-fixtures.ps1 > $null
