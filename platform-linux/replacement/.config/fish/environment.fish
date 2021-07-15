# (c) otofune

# update packages once per hour at background
# this part is not so well. it's better choise to use cron
set update_lock_dir ~/.config/fish/bu
mkdir -p $update_lock_dir
set update_lock ".u_"(date '+%y%m%d-%H')
if [ ! -f $update_lock_dir/$update_lock  ]
  touch $update_lock_dir/$update_lock
  __check_update
end

alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias pacman="sudo pacman"

if ! set -q $DISPLAY
  export PULSE_LATENCY_MSEC=30
  xrandr | grep "DisplayPort-1 connected" 1>/dev/null 2>/dev/null
  if test $status -eq 0
    export GDK_DPI_SCALE=1.4
  else
    export GDK_DPI_SCALE=1.2
  end
end

export XDG_CONFIG_HOME=$HOME/.config
