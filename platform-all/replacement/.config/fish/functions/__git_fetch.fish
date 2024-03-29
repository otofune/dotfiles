# (c) otofune

function __git_fetch --description 'git fetch on entering directory'
    git status 1>/dev/null 2>/dev/null
    if test $status -ne 128
        if ls .git 1>/dev/null 2>/dev/null
            # ignore moving from sub-directory
            if not string match -q -- "$PWD*" "$PPWD/"
                echo "Running git fetch..."
                git fetch
            end
        end
    end
end
