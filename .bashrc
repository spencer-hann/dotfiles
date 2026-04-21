
# alias nvim='(ln --symbolic ~/dotfiles/nvim ~/.config/; trap "rm -f ~/.config/nvim" EXIT; ~/.local/bin/nvim-linux-x86_64.appimage "$@")'
alias nvim='~/.local/bin/nvim-linux-x86_64.appimage'
alias vim=nvim

alias nvimclean='rm -rf .local/state/nvim; rm -rf .cache/nvim'
alias nvimlinkconfig='ln --verbose --symbolic ~/dotfiles/nvim ~/.config/'
alias nvimunlinkconfig='rm --verbose ~/.config/nvim'

# vanilla neovim
alias vnvim='nvimclean; ~/.local/bin/nvim-linux-x86_64.appimage -u NONE'

alias bat='batcat'
alias cat='batcat --paging=never'

alias fd='fdfind'

alias fzp="fzf --preview='batcat --color=always --style=numbers {}'"
# includes hidden files in fzf search
# https://github.com/junegunn/fzf/issues/337#issuecomment-136383876
alias fzfhidden='find . | fzp'

alias gitbranch='git branch'
alias gitcheckout='git checkout'
alias gitd='git diff'
alias gitdiff='git diff'
alias gitfetch='git fetch'
alias gitlog='git log'
alias gitpull='git pull'
alias gitpush='git push'
alias gitpll='git pull'
alias gitpsh='git push'
alias gitreset='git reset'
alias gitswitch='git switch'
alias gitstatus='git status'

alias bell='echo -e "\a"'
# Add an "alert" alias for long running commands (from Ubuntu default bashrc)
#   $ sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"; bell;'

