# (c) otofune

function __git_fetch --on-variable PWD --description 'git fetch on entering directory'
    git status 1>/dev/null 2>/dev/null
    if test $status -ne 128
        git fetch
    end
end
