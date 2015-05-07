param ($cleanPath)

#/ Usage: script/clean-git-test-fixture <path.git>
$ErrorActionPreference="Stop"

# bail out if path not specified
if (!$cleanPath)
{
    write-host "path not specified"
    exit 1
}

# make sure the repo we're cleaning already exists.
if (!(test-path $cleanPath))
{
    write-host "$path does not exist"
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

foreach ($filename in $superfluous_git_files)
{
    $filepath="$cleanPath\$filename"

    if (test-path $filepath)
    {
        if (test-path $filepath -pathtype container)
        {
            # If the thing at $filepath is a directory, delete it recursively.
            remove-item -recurse $filepath
            write-host "Deleted dir at $filepath"
        }
        else
        {
            # If the thing at $filepath is a file, delete it the normal way.
            remove-item $filepath
            write-host "Deleted file at $filepath"
        }
    }
}
