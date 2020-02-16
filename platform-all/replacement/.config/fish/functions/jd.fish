# (c) otofune

function jd
  set TEMPORARY_DIRECTORY (mktemp -d)
  fish -C "$TEMPORARY_DIRECTORY" $argv
  rm -rf $TEMPORARY_DIRECTORY
end
