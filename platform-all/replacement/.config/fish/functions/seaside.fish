# (c) otofune

function seaside
    set directory (ghq root)/github.com/otofune/seaside
    env SEASIDE_CREDENTIAL_FILE="$directory/credential.json" DIRENV_LOG_FORMAT="" direnv exec $directory $directory/seaside $argv
end
