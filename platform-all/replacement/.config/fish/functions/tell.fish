# (c) otofune

# otofune/seaside helper
function tell
    set body $argv[1]
    if test -z "$body"
        echo "You must specify body." 1>&2
        return
    end
    # for cancel
    sleep 1.5
    echo $body | seaside t
end
