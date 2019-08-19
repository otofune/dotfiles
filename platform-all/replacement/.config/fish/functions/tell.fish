# (c) otofune

# otofune/seaside helper
function tell
    set directory (ghq root)/github.com/otofune/seaside
    set body $1
    if test -z "$body"
        echo "You must specify body." 1>&2
        return
    end
    echo $body | env DIRENV_LOG_FORMAT="" direnv exec $directory $directory/seaside t 
end
