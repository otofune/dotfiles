# (c) 2018 otofune

if test -f ~/.config/fish/environment.fish
  source ~/.config/fish/environment.fish
end

ssh-add -A > /dev/null 2>&1

set -x GOPATH ~/projects
set -x PATH $GOPATH/bin $PATH
if which direnv > /dev/null
  # backward compatibility
  direnv hook fish | source
end

set -x PATH $HOME/bin $PATH

# not fish syntax: source ~/.cargo/env
set -x PATH $HOME/.cargo/bin $PATH

if which anyenv > /dev/null
  # backward compatibility
  anyenv init - | source
end
if which asdf > /dev/null
  # backward compatibility
  source ~/.asdf/asdf.fish
end
if which mise > /dev/null
  mise activate fish | source
end

# typo
abbr --add gti git
abbr --add pcaman pacman

# shorthand
abbr --add gg git grep
abbr --add l ls -a

abbr --add claude command claude --dangerously-skip-permissions
abbr --add codex command codex --dangerously-bypass-approvals-and-sandbox

abbr --add ff 'git fetch origin HEAD && git rebase FETCH_HEAD'

# update packages once per hour at background
# this part is not so well. it's better choise to use cron
if type __check_update > /dev/null 2>&1
  set update_lock_dir ~/.config/fish/bu
  mkdir -p $update_lock_dir
  set update_lock ".u_"(date '+%y%m%d-%H')
  if [ ! -f $update_lock_dir/$update_lock  ]
    touch $update_lock_dir/$update_lock
    __check_update
  end
end

if test -f ~/.config/fish/config-secret.fish
  source ~/.config/fish/config-secret.fish
end

source ~/.config/fish/aliases.fish

# opam configuration
# https://github.com/ocaml/opam/pull/4736
#source /Users/owner/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
if which opam > /dev/null
  eval (opam env)
end
