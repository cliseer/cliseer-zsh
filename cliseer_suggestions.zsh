cliseer_generate_suggestion() {
    local history_line
    history_line=$(fc -ln -1)
    if [[ -z "$history_line" ]]; then
        echo ""
        return
    fi

    local escaped
    escaped=$(echo "$history_line" | jq -aRs .)

    local prompt
    prompt="Improve the following command: $history_line"

    local response
    response=$(cliseer <<< "$prompt")

    echo "$response" | sed -n '/^```fish/,/^```/p' | sed '1d;$d' | head -n 1
}
