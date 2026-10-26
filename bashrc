alias vim=nvim

alias nvimlink='ln -v --symbolic ~/.local/bin/nvim-linux-x86_64.appimage ~/.local/bin/nvim'
alias nvimunlink='rm -v ~/.local/bin/nvim'

# simple rm+echo: 'rm -v' sometimes too much
rmv() { echo "remove: $*"; rm "$@" || echo; }
alias nvimclean='rmv -r ~/.local/state/nvim/; rmv -r ~/.cache/nvim/'
alias nvimdeepclean='nvimclean; yes | rmv -r ~/.local/share/nvim/'
alias nvimlinkconfig='ln -v --symbolic ~/dotfiles/nvim ~/.config/'
alias nvimunlinkconfig='rm -v ~/.config/nvim'

# vanilla neovim
alias vnvim='nvimclean; nvim -u NONE'

alias ghosttylink='ln -v --symbolic ~/dotfiles/ghostty/ ~/.config/'

# export BAT_THEME="base16"
export BAT_THEME="ansi"
alias bat='batcat --paging=always'
alias cat='batcat --paging=never --style=plain'

alias fd='fdfind'

alias fzp="fzf --preview='batcat --color=always --style=numbers {}'"
# include hidden files in fzf search
# https://github.com/junegunn/fzf/issues/337#issuecomment-136383876
alias fzfhidden='find . | fzp'

alias difft=difftastic

alias status='echoandrun git fetch; git status'

alias bell="printf '\a'"
# Add an "alert" alias for long running commands (from Ubuntu default bashrc)
#   $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"; bell;'

echoandrun() { echo "$@"; "$@"; }


export EDITOR=nvim
export MANPAGER='nvim +Man!'

set -o vi
bind -m vi-insert '"\C-l": clear-screen'


# https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/credstores.md#gits-built-in-credential-cache
export GCM_CREDENTIAL_STORE=cache
export GCM_CREDENTIAL_CACHE_OPTIONS="--timeout 1200"

git config --global core.editor nvim
# git config --global core.pager batcat
git config --global diff.tool nvimdiff
git config --global diff.guitool nvimdiff
git config --global difftool.prompt false
git config --global merge.ff true
git config --global merge.tool nvimdiff
git config --global merge.conflictstyle zdiff3
# git config --global merge.conflictstyle diff3

# https://stackoverflow.com/questions/72911004/how-to-configure-git-mergetool-properly-for-neovim
git config --global mergetool.nvimdiff.layout "LOCAL,BASE,REMOTE / MERGED"


# add '.local/bin/' to $PATH
case ":$PATH:" in
    *:"$HOME/.local/bin":*) ;;
    *)
        export PATH="$HOME/.local/bin:$PATH"
        ;;
esac


if [ -f "$HOME/.cargo/env" ]; then
    alias clippy='cargo clippy'
    . "$HOME/.cargo/env"
fi

if [ $(command -v uv >/dev/null) ]; then
    alias ipython='uv run --with ipython ipython'
fi

# free -h; echo
date; echo

