# (c) otofune

alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias pacman="sudo pacman"

export PULSE_LATENCY_MSEC=30
xrandr | grep "DisplayPort-1 connected" 1>/dev/null 2>/dev/null
if test $status -eq 0
  export GDK_DPI_SCALE=1.4
else
  export GDK_DPI_SCALE=1.2
end
