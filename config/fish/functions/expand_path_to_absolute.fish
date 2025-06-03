function expand_path_to_absolute
    set -l token (commandline -t)
    if test -e "$token"
        set -l abs_path (realpath "$token")
        commandline -rt "$abs_path"
    end
end
