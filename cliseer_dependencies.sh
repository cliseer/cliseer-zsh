#!/usr/bin/env bash

maybe_run() {
    local cmd="$*"
    read -p "Do you want to run: $cmd [y/N] " response
    if [[ "$response" == "y" || "$response" == "Y" ]]; then
        echo "Running: $cmd"
        eval "$cmd"
    else
        echo "Skipped: $cmd"
    fi
}

cliprophesy_dependency() {
    if command -v cliprophesy >/dev/null 2>&1; then
        return 0
    fi

    uname_out="$(uname)"
    case "$uname_out" in
        Linux)
            binary_name="cliprophesy-linux"
            ;;
        Darwin)
            binary_name="cliprophesy-macos"
            ;;
        *)
            echo "Unsupported OS: $uname_out"
            return 1
            ;;
    esac

    bin_dir="$HOME/.local/bin"
    mkdir -p "$bin_dir"

    url="https://github.com/cliseer/cliprophesy/releases/latest/download/$binary_name"
    dest="$bin_dir/cliprophesy"

    echo "CLIProphesy command line tool required"
    maybe_run "curl -L \"$url\" -o \"$dest\" && chmod +x \"$dest\""

    case ":$PATH:" in
        *":$bin_dir:"*) ;;
        *)
            echo "Warning: $bin_dir needs to be in path for completions to be generated"
            ;;
    esac
}


config_dependency() {
    mkdir -p ~/.config/cliseer
    url=$(curl -s https://api.github.com/repos/cliseer/cliprophesy/releases/latest \
              | grep "browser_download_url" \
              | grep "settings.cfg" \
              | cut -d '"' -f 4)

    curl -L "$url" -o ~/.config/cliseer/settings.cfg

    echo "Configure cliseer AI provider in ~/.config/cliseer/settings.cfg"
}

cliseer_fzf_dependency() {
    if command -v fzf >/dev/null 2>&1; then
        return 0
    fi

  echo "fzf, command-line fuzzy finder, is required"

  os=$(uname)
  if [[ "$os" == "Darwin" ]]; then
    maybe_run brew install fzf
  elif [[ "$os" == "Linux" ]]; then
    if [[ -f /etc/debian_version ]]; then
      maybe_run sudo apt install fzf
    else
      maybe_run sudo dnf install fzf
    fi
  fi
}

config_dependency
cliseer_fzf_dependency
cliprophesy_dependency

echo "Dependency install script completed"
