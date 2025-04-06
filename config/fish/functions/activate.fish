function activate
    set venv_name $argv[1]

    if test -z "$venv_name"
        set venv_name ".venv"
        echo "No virtualenv name provided. Defaulting to '.venv'"
    end

    set venv_path "$venv_name/bin/activate.fish"

    if test -f $venv_path
        source $venv_path
        return
    end

    if not string match -r '^\.' $venv_name
        set alt_venv_path ".$venv_name/bin/activate.fish"

        if test -f $alt_venv_path
            echo "Note: '$venv_name' not found, using '.$venv_name' instead."
            source $alt_venv_path
            return
        end
    end

    echo "Virtualenv activation script not found."
    echo "Tried:"
    echo "  $venv_path"
    if set -q alt_venv_path
        echo "  $alt_venv_path"
    end
    return 1
end

