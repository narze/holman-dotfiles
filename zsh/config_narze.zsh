# automatically enter directories without cd
setopt auto_cd

# vi mode
bindkey -v
# bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# expand functions in the prompt
setopt prompt_subst

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

## iTerm movements

# Skip forward/back a word with opt-arrow
bindkey '^[w' forward-word
bindkey '^w' forward-word
bindkey '^[b' backward-word
bindkey '^b' backward-word

# Skip to start/end of line with cmd-arrow
bindkey '^a' beginning-of-line
bindkey '^k' end-of-line

# Delete word with opt-backspace/opt-delete
bindkey '[G' backward-kill-word
bindkey '[H' kill-word

# Delete line with cmd-backspace
bindkey '[I' kill-whole-line