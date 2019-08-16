# (c) otofune

function fish_greeting
	set c (pacman -Qu | wc -l | string trim)
	echo "[:V] There are "$c" packages to upgrade."
end

