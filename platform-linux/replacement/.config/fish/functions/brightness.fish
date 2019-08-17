# (c) otofune

function brightness
  set level $argv[1]
  if test "$level" != ""
    echo $level | sudo tee /sys/class/backlight/*/brightness
    return
  end
  cat /sys/class/backlight/*/brightness
end
