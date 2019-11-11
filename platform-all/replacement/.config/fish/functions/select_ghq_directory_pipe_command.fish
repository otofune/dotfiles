function select_ghq_directory_pipe_command
  set command $argv[1]
  set repository (select_ghq_directory)
  if test $status -ne 0
    return 1
  end
  command $command $repository
end
