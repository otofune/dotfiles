# (c) otofune

function fish_greeting
	set c (brew outdated 2>/dev/null | wc -l | string trim)
	echo "🍺 There are "$c" packages to upgrade."
end
