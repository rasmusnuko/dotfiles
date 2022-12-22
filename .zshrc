bindkey -v

# Scripts PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH="/Users/nuko/scripts:$PATH"
export PATH="/opt/homebrew/opt/qt/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/qt/lib"
export CPPFLAGS="-I/opt/homebrew/opt/qt/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/qt/lib/pkgconfig"
export PATH=/usr/local/anaconda3/bin:$PATH
export PATH=/opt/homebrew/anaconda3/bin:$PATH
export PATH=$PATH:/Users/nuko/.spicetify
export ZSH="/Users/nuko/.oh-my-zsh"

# Path to your oh-my-zsh installation.
source $ZSH/oh-my-zsh.sh
ZSH_THEME="powerlevel10k/powerlevel10k"
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#### Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)


#### Alias
alias np='python3 -i -c "import numpy as np"'
alias nx='python3 -i -c "import networkx as nx"'
alias zshconf="vim ~/.zshrc"
alias zfzf="cat ~/.zsh_history | fzf"
alias vim=nvim
alias oldvim=\vim

#### Functions
# Quick look
ql () {
  qlmanage -p "$1" && > /dev/null 2>&1
}

# cat to clipboard
pcat () {
  cat "$1" | pbcopy
}

# add, commit, push with message
function acp() {
  git add .
  git commit -m "$1"
  git push
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

