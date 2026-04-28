
# alias nvim='(ln --symbolic ~/dotfiles/nvim ~/.config/; trap "rm -f ~/.config/nvim" EXIT; ~/.local/bin/nvim-linux-x86_64.appimage "$@")'
# alias nvim=~/.local/bin/nvim-linux-x86_64.appimage
alias vim=nvim

alias nvimlink='ln -v --symbolic ~/.local/bin/nvim-linux-x86_64.appimage ~/.local/bin/nvim'
alias nvimunlink='rm -v ~/.local/bin/nvim'

# simple rm+echo: 'rm -v' sometimes shows too much
rmv() { echo "remove: $@"; rm "$@" || echo; }
alias nvimclean='rmv -r ~/.local/state/nvim/; rmv -r ~/.cache/nvim/'
alias nvimdeepclean='nvimclean; yes | rmv -r ~/.local/share/nvim/'
alias nvimlinkconfig='ln -v --symbolic ~/dotfiles/nvim ~/.config/'
alias nvimunlinkconfig='rm -v ~/.config/nvim'

# vanilla neovim
alias vnvim='nvimclean; nvim -u NONE'

alias bat='batcat'
alias cat='batcat --paging=never'

alias fd='fdfind'

alias fzp="fzf --preview='batcat --color=always --style=numbers {}'"
# include hidden files in fzf search
# https://github.com/junegunn/fzf/issues/337#issuecomment-136383876
alias fzfhidden='find . | fzp'

alias gitbranch='git branch'
alias gitcheckout='git checkout'
alias gitd='git diff'
alias gitdiff='git diff'
alias gitfetch='git fetch'
alias gitlog='git log'
alias gitpll='git pull'
alias gitpsh='git push'
alias gitreset='git reset'
alias gitswitch='git switch'
alias gitstatus='git status'

alias bell='echo -e "\a"'
# Add an "alert" alias for long running commands (from Ubuntu default bashrc)
#   $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"; bell;'

set -o vi

# https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/credstores.md#gits-built-in-credential-cache
export GCM_CREDENTIAL_STORE=cache export GCM_CREDENTIAL_CACHE_OPTIONS="--timeout 1200"

if [ -f "$HOME/.cargo/env" ]; then
        alias clippy='cargo-clippy'
        . "$HOME/.cargo/env"
fi

