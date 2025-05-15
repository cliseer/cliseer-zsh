cliseer_suggest_widget() {
    zle -I

    local selected_cmd
    selected_cmd=$(cliprophesy "$BUFFER" --shell zsh | fzf --height 40% --reverse --ansi --bind 'ctrl-space:abort')
    if [[ -n "$selected_cmd" ]]; then
        selected_cmd=$(echo $selected_cmd | sed 's/\s*#.*$//')
        BUFFER="$selected_cmd"
        CURSOR=${#BUFFER}
    fi
    zle reset-prompt
}
zle -N cliseer_suggest_widget
# Bind Ctrl-Space (represented as ^@)
bindkey '^@' cliseer_suggest_widget
bindkey '^G' cliseer_suggest_widget

typeset -x HISTFILE
