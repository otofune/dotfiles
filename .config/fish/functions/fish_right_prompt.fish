# (c) 2018 otofune

function fish_right_prompt
	set grp (git rev-parse --is-inside-work-tree 2>/dev/null)
	if [ $status -eq 0 ]; and [ $grp = "true" ]
		set_color brblue

		git rev-parse HEAD > /dev/null 2>&1
		if [ $status -eq 0 ]
			set c (git diff (git rev-list --max-parents=0 HEAD) --check | grep 'conflict marker' | wc -l | string trim)
			if [ $c -ne 0 ]
				set_color brred
				echo -n "!"
			end
			set gs (git rev-parse --short HEAD)
		end

		set branch (git symbolic-ref --short -q HEAD)
		if test $status -eq 0
			set gs $branch
		end
		echo -n " "$gs	
        end

	set_color normal
end
