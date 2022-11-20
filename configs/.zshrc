# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
export CLICOLOR=1
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/woolean/.zshrc'
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Completion for kitty
# kitty + complete setup zsh | source /dev/stdin

PROMPT=" %B%F{73}%~%f%b%B%F{220} >>%f%b "
RPROMPT=" %B%F{220}<<%f%b %B%F{134}%T%f%b"

# aliases
# Varios 
alias cd='cd '
alias la='exa -la --group-directories-first' # Mostrar archivos de carpeta como lista con archivos ocultos
alias nv='nvim ' 
alias :q='exit'
alias ls='ls --color'
alias icat='kitty +kitten icat'
alias fuentes='fc-list | grep 'woolean' '
alias zathura='zathura --fork'
#XBPS cosas
alias rxbps='sudo xbps-query -Rs '

# Nixos
# alias nixconf='sudo nvim /etc/nixos/configuration.nix '
# alias nixupdate='sudo nixos-rebuild switch --upgrade '

# i3 config
# alias i3conf='nv /home/woolean/.config/i3/config '

# case insensitive path-completion 
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 

#Go Root
GOROOT=/usr/lib/go
export GO111MODULE=on

# Status Bar Paths
PATH="$PATH:/$HOME/.local/bin"	
PATH="$PATH:$GOROOT/bin"
PATH="$PATH:/home/woolean/dwmscripts"

#enviroment variables para chromium
export GOOGLE_API_KEY="no"
export GOOGLE_DEFAULT_CLIENT_ID="no"
export GOOGLE_DEFAULT_CLIENT_SECRET="no"

source ./.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/woolean/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/woolean/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
