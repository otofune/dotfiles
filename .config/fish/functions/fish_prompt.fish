# (c) 2018 otofune

function fish_prompt
	set_color -o brmagenta
	echo -n (prompt_pwd)
	set_color normal
	if [ -d .git ]
		# branch/commit
		set_color brblue
		set gs (git rev-parse --short HEAD)
		set branch (git symbolic-ref --short -q HEAD)
		if test $status -eq 0
			set gs $branch
		end
		echo -n " ("$gs")"

		set_color brred
		set c (git diff (git rev-list --max-parents=0 HEAD) --check | grep 'conflict marker' | wc -l | string trim)
		if [ $c -ne 0 ]
			echo -n " !"
		end
        end
	set_color normal
        echo -n ' $ '
end
