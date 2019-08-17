# (c) otofune

function brightness
  set max_brightness (cat /sys/class/backlight/*/max_brightness)
  set level $argv[1]
  if test "$level" != ""
    if test $level -gt $max_brightness
      echo "Invalid level specified." 1>&2
      return 1
    end
    echo $level | sudo tee /sys/class/backlight/*/brightness 1>/dev/null
    return
  end
  cat /sys/class/backlight/*/brightness
end
