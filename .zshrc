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
