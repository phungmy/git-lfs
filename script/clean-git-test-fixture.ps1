param ($cleanPath)

#/ Usage: script/clean-git-test-fixture <path.git>
$ErrorActionPreference="Stop"

# bail out if path not specified
If (!$cleanPath)
{
    Write-Host "path not specified"
    exit 1
}

# make sure the repo we're cleaning already exists.
If (!(Test-Path $cleanPath))
{
    Write-Host "$path does not exist"
    exit 1
}

# all the superfluous git file names
# note: in most cases, it would be fine to just delete the hooks folder, but
# some tests rely on real hooks, so just delete the sample hooks.
$superfluous_git_files=@("COMMIT_EDITMSG",
    "hooks\applypatch-msg.sample",
    "hooks\commit-msg.sample",
    "hooks\post-update.sample",
    "hooks\pre-applypatch.sample",
    "hooks\pre-commit.sample",
    "hooks\pre-push.sample",
    "hooks\pre-rebase.sample",
    "hooks\prepare-commit-msg.sample",
    "hooks\update.sample",
    "index",
    "info\exclude")

ForEach ($filename in $superfluous_git_files)
{
    $filepath="$cleanPath\$filename"
    If (Test-Path $filepath)
    {
        If (Test-Path $filepath -pathtype container)
        {
            # If the thing at $filepath is a directory, delete it recursively.
            Remove-Item -recurse $filepath
            Write-Host "Deleted dir at $filepath"
        }
        Else
        {
            # If the thing at $filepath is a file, delete it the normal way.
            Remove-Item $filepath
            Write-Host "Deleted file at $filepath"
        }
    }
}
