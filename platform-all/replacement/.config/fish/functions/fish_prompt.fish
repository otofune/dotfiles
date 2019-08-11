# (c) 2018 otofune

function fish_prompt
	set_color -o brmagenta
	echo -n (prompt_pwd)

	set_color -o normal
        echo -n ' > '
end
