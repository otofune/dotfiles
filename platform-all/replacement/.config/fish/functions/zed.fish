# (c) otofune

function zed --wraps=zed
  set length (count $argv)
  if test $length -eq 0
    select_ghq_directory_pipe_command zed
    return $status
  end
  command code $argv
end
