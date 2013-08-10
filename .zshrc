setxkbmap fi
alias update="yaourt -Suya"
setxkbmap -option ctrl:nocaps
alias i3lock="i3lock -t -i /home/lumolk/Kuvat/Waves.png"
alias sudo="sudo "
export EDITOR="vim"
alias vim="vim '+set encoding=utf-8'"
alias pacman="pacmatic"
alias connect_wifi='nmcli dev wifi con "Koti_866C" password RR9VKVVU7NT49 name "Koti"'
alias nukkumaan="systemctl poweroff"
alias dropbox="python2.7 ~/bin/dropbox.py"
alias ls='ls --color=auto'

alias pingg="ping -c 1 8.8.8.8;echo DNS:;ping -c 2 google.com"
#PS1='[\u@\h \W]\$ '
setopt autocd
alias g="grep --color=auto"
eval $(dircolors -b)
alias mntntfs='sudo mount -t ntfs-3g /dev/sda3 /mnt/Acer/'

#ZSH
autoload -U compinit promptinit
compinit
promptinit
 
# This will set the default prompt to the walters theme
prompt walters
autoload -U colors && colors
PROMPT="%{$fg_bold[green]%}%n@%m %{$fg_bold[blue]%}%1~ %(#.#.$) %{$reset_color%}"
RPROMPT='%(?,%F{green}:%),%F{red}%? %F{red}:()%f'

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
