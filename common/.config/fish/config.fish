alias vim nvim
alias r ranger
alias wiki "vim -c VimwikiIndex"

set -gx PATH $HOME/dotfiles/scripts $HOME/.cargo/bin $PATH

set EDITOR nvim
set VISUAL nvim
set editor nvim
set BROWSER firefox

set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx TMUXP_CONFIGDIR $HOME/.config/tmuxp


set fish_greeting

function sudo
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end
