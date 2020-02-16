# (c) otofune

function jd
  set TEMPORARY_DIRECTORY (mktemp -d)
  fish -iC "$TEMPORARY_DIRECTORY"
  rm -rf $TEMPORARY_DIRECTORY
end
