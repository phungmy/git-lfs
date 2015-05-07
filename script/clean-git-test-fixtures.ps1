foreach ($dir in (get-childitem -directory "commands\repos"))
{
  script\clean-git-test-fixture.ps1 $dir
}

foreach ($dir in (get-childitem -directory "commands\repos\*\modules"))
{
  script\clean-git-test-fixture.ps1 $dir
}
