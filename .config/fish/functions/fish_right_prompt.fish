# (c) 2018 otofune

function fish_right_prompt
	if test (git rev-parse --is-inside-work-tree) = "true"
		set_color brred

		git rev-parse HEAD > /dev/null 2>&1
		if [ $status -ne 0 ]
			echo -n "(Not committed yet)"
			set_color normal
			return
		end

		set c (git diff (git rev-list --max-parents=0 HEAD) --check | grep 'conflict marker' | wc -l | string trim)
		if [ $c -ne 0 ]
			echo -n "!"
		end

		set_color brblue
		set gs (git rev-parse --short HEAD)
		set branch (git symbolic-ref --short -q HEAD)
		if test $status -eq 0
			set gs $branch
		end
		echo -n " "$gs	
        end

	set_color normal
end
