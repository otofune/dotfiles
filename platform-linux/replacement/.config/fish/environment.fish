# (c) otofune

export PULSE_LATENCY_MSEC=30
xrandr | grep "DisplayPort-1 connected" 1>/dev/null 2>/dev/null
if test $status -eq 0
  export GDK_DPI_SCALE=1.4
end
