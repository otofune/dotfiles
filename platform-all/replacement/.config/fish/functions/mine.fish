# rubymine

function mine
  set length (count $argv)
  if test $length -eq 0
    select_ghq_directory_pipe_command mine
    return $status
  end
  command mine $argv
end
