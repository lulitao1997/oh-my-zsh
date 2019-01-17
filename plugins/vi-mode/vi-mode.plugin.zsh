# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
  zle -R
}

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && { zle -R; zle reset-prompt }
}

zle -N zle-keymap-select
zle -N edit-command-line


bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-r to perform backward search in history
bindkey '^r' history-incremental-search-backward

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
  MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
}

# define right prompt, if it wasn't defined by a theme
if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
  RPS1='$(vi_mode_prompt_info)'
fi

## custom settings
t_SI=
t_SR=
t_EI=
if [ -n "$(env | grep KONSOLE)" ]; then
    t_SI="\e]50;CursorShape=1\x7"
    t_SR="\e]50;CursorShape=2\x7"
    t_EI="\e]50;CursorShape=0\x7"
else
    t_SI="\e[6 q"
    t_SR="\e[4 q"
    t_EI="\e[2 q"
fi
function zle-keymap-select zle-line-init zle-line-finish  () {
    if [ $(env | grep KONSOLE | wc -l) ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne $t_EI
        else
            # the insert mode for vi
            echo -ne $t_SI
        fi
    fi
    zle reset-prompt
    zle -R
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
# disable delay when switching to normal mode
export KEYTIMEOUT=1
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward
# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

