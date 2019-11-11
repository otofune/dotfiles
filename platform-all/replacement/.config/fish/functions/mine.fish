# rubymine

function mine
  set length (count $argv)
  if test $length -eq 0
    select_ghq_directory_pipe_command code
    return $status
  end
  command code $argv
end
