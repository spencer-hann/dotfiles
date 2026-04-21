
alias vim='~/.local/bin/nvim-linux-x86_64.appimage -u NONE'

# alias nvim='(ln --symbolic ~/dotfiles/nvim ~/.config/; trap "rm -f ~/.config/nvim" EXIT; ~/.local/bin/nvim-linux-x86_64.appimage "$@")'
alias nvim='~/.local/bin/nvim-linux-x86_64.appimage'

alias nvimclean='rm -rf .local/state/nvim; rm -rf .cache/nvim'

alias rdsjump='ssh uw-vsc.nb-engr.skyworksinc.com'

alias bat='batcat'
alias cat='batcat --paging=never'

alias fd='fdfind'

# https://github.com/junegunn/fzf/issues/337#issuecomment-136383876
export FZF_DEFAULT_COMMAND='find .'

alias fzp="fzf --preview='batcat --color=always --style=numbers {}'"

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

