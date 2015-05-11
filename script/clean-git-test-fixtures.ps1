ForEach ($dir in (Get-ChildItem -directory "commands\repos"))
{
  script\clean-git-test-fixture.ps1 $dir
}

ForEach ($dir in (Get-ChildItem -directory "commands\repos\*\modules"))
{
  script\clean-git-test-fixture.ps1 $dir
}
