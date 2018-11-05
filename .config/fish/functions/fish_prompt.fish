# (c) 2018 otofune

function fish_prompt
	set_color -o brmagenta
	echo -n (prompt_pwd)
	set_color normal
	if [ -d .git ]
		set_color brred
		echo -n " ("(git symbolic-ref --short HEAD)")"
        end
	set_color normal
        echo -n ' $ '
end
