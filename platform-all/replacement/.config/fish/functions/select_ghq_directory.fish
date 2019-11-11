function select_ghq_directory
  set repository (ghq list | fzf --exit-0)
  if test (string length "$repository") -eq 0
    return 1
  end
  echo (ghq root)/$repository
end
