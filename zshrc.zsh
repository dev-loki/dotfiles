# Make sure we have zsh!
[[ ! -d $HOME/.oh-my-zsh ]] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Pfade
export GOPATH=$HOME/projects/go
export PATH=$PATH:$GOPATH/bin/
export PATH=$PATH:/usr/local/go/bin/
export PATH=$PATH:~/.bin/
export PATH=$PATH:~/.node_modules/bin/
export PATH=$PATH:~/.config/composer/vendor/bin/
export npm_config_prefix=~/.node_modules

# Oh My ZSH Stuff
export ZSH="$HOME/.oh-my-zsh"
# ZSH_THEME="dstufft"
# ZSH_THEME="fino-time" # needs rvm-prompt
# ZSH_THEME="suvash"
# ZSH_THEME="steeef"
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel10k/powerlevel10k"

# source ~/.alientheme/alien.zsh
# ALIEN_THEME="green"

plugins=(
  autojump
  colored-man-pages
  colorize
  common-aliases
  cp  # cpv - copy with rsync
  fzf
  git
  git-flow-avh
  git-extras
  gitfast
  httpie
  jump
  mosh
  rsync  # rsync-{copy,move,update,synchronize}
  systemadmin  # https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/systemadmin
  systemd
  taskwarrior
  timewarrior
  tig  # tis, til, tib - status, log blame
  tmuxinator
  transfer  # https://transfer.sh
  virtualenv
  virtualenvwrapper
)
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Genereller Kram
export EDITOR=nvim
export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5
if [[ $LANG = '' ]];
    then export LANG=en_US.UTF-8
fi


# Aliase
alias ls=lsd
alias la='lsd -a'
alias ll='lsd -l'
alias lla='lsd -la'
alias mkdir="mkdir -p"
alias y='yay --sudoloop'
alias yi="yay -Sy --sudoloop --noanswerclean --answerdiff=None --noansweredit --noanswerupgrade"
alias yu="yay -Syu --sudoloop --noanswerclean --noanswerdiff --noansweredit --noanswerupgrade"
alias yrm="yay -Runsc"
alias v=nvim
alias q=exit
alias tw=timew
alias rmdockers="docker system prune -a"
alias cat=bat

# fzf

function f(){
  fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (highlight -O ansi -l {} ||
                  pygmentize {} ||
                  ccat {}) 2> /dev/null | head -500'
}

# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
# zsh autoload function
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     vim -- $files
     print -l $files[1]
  fi
}

# c - browse chrome history
c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  google_history="$HOME/.config/google-chrome-unstable/Default/History"
  open=xdg-open

  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

check () {
  clear
  files=`(git diff --name-only --cached --diff-filter=ACMR; git diff --name-only --diff-filter=ACMR) | sort | uniq | tr '\n' ' '`
  echo 'Check PHPStan'
  php ./vendor/bin/phpstan analyze `(git diff --name-only --cached --diff-filter=ACMR; git diff --name-only --diff-filter=ACMR) | sort | uniq | tr '\n' ' '`
  echo "\nCheck PHP Codesniffer:"
  php ./vendor/bin/phpcs -p `(git diff --name-only --cached --diff-filter=ACMR; git diff --name-only --diff-filter=ACMR) | sort | uniq | tr '\n' ' '`
}

checkall () {
  clear
  echo 'Check PHPStan'
  php ./vendor/bin/phpstan analyze src config
  echo "\nCheck PHP Codesniffer"
  php ./vendor/bin/phpcs -p src config
  echo "\nPHPUnit"
  php ./vendor/bin/phpunit
}

source $HOME/.oh-my-zsh/custom/plugins/calc.plugin.zsh/calc.plugin.zsh
alias v="nvim"
alias vim="nvim"

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
