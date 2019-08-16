# (c) otofune

function __check_update
    echo 'Updating brew...'
    brew update > /dev/null 2>&1 &
end
