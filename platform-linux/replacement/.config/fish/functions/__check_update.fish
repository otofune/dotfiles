# (c) otofune

function __check_update
    echo 'Updating pacman...'
    pacman -Sy > /dev/null 2>&1 &
end
