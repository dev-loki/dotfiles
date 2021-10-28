# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$PATH:$HOME/.pub-cache/bin:$HOME/.deta/bin
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  # archlinux
  autojump
  aws
  colorize
  docker
  docker-compose
  docker-machine
  emacs
	fast-syntax-highlighting
  fd
  flutter
  fzf
	git
  git-extras
  git-flow-avh
  httpie
  jump
  pass
  pipenv
  pyenv
  ripgrep
  rust
  rustup
  rsync
  scd
  systemadmin
  systemd
)

# if mac system
# if archlike system

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/plugins/calc.plugin.zsh/calc.plugin.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias paru='paru --bottomup'
alias pu='paru -Syu'
alias pi='paru -Sy'
alias ls='lsd'
alias ll='lsd -lah'
alias la='lsd -a'
alias cat='bat'
alias y=youtube-dl
