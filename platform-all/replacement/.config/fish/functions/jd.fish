# (c) otofune

function jd
  set TEMPORARY_DIRECTORY (mktemp -d)
  sh -c "cd $TEMPORARY_DIRECTORY && fish $argv"
  rm -rf $TEMPORARY_DIRECTORY
end
