export PATH="$HOME/.local/bin:$PATH"
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
#       General conf
stty stop undef
autoload -U colors && colors

export EDITOR=/bin/nvim
export VISUAL=/bin/nvim

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.cache/zsh/history
setopt correctall
unsetopt correct_all

#        PROMPT
NEWLINE=$'\n'
PROMPT=" %(?.%F{154}√.%F{160}? %?)%f %B%F{213}[📁 %0~]%f%b%F{154} > "

export KEYTIMEOUT=1

#       Show vim mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
preexec() { echo -ne '\e[5 q' ;} 


#       alias
alias p="sudo apt"
alias pp="sudo apt install"
alias aps="apt search"
alias grep="grep --color=auto"
alias vf="vifm"
alias n="nvim"
alias yt-audio="youtube-dl -x -i -f bestaudio/best"
alias yt-mp3="youtube-dl --extract-audio --audio-format mp3"
alias yt-video="youtube-dl -x -i -f best/video"
alias l="exa -al --color=always --group-directories-first"
alias ls="exa -a --color=always --group-directories-first"
alias sl="exa -a --color=always --group-directories-first"
alias cp="cp -i"
alias dcompile="sudo make clean install"
alias commit="git commit -m"
alias push="git push origin"
alias docdir=" cd /mnt/a/doc"
alias adisk="cd /mnt/a"
alias cdisk="cd /mnt/c"

#       autocompletion
autoload -U compinit
zstyle ':completion:*' menu select
compinit
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

#      Keybinds
bindkey -v
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
bindkey '^R' history-incremental-search-backward


bindkey -s '^f' 'nvim $(find ~/.local/bin/ -type f | fzf)\n'
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

#       source 
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
