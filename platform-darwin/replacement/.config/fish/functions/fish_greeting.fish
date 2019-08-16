# (c) otofune

function fish_greeting
	set c (brew outdated | wc -l | string trim)
	echo "🍺 There are "$c" packages to upgrade."
end
