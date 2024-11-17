if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

source ~/dotfiles/aliases.sh
source ~/dotfiles/functions.fish
source ~/.secret_aliases
pyenv init - | source
pyenv virtualenv-init - | source
