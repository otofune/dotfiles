# (c) otofune

# otofune/seaside helper
function tell
    if test -z "$argv"
        echo "You must specify body." 1>&2
        return
    end
    # for cancel
    sleep 1.5
    echo $argv | seaside t
end
