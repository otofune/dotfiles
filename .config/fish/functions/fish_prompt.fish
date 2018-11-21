# (c) 2018 otofune

function fish_prompt
	set_color -o brmagenta
	echo -n (prompt_pwd)
	set_color normal
	if [ -d .git ]
		set_color brred
		set gs (git rev-parse --short HEAD)
		set branch (git symbolic-ref --short -q HEAD)
		if test $status -eq 0
			set gs $branch
		end
		echo -n " ("$gs")"
        end
	set_color normal
        echo -n ' $ '
end
