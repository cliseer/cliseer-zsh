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

  maybe_run "pip install cliprophesy"
}

config_dependency() {
  mkdir -p ~/.config/cliseer
  curl -fsSL \
    https://gist.githubusercontent.com/ygreif/f9879149afbe2382006c867fe099dce8/raw/6874a3989e4bf2886183cf94ee743d399beebd40/gistfile1.txt \
    -o ~/.config/cliseer/settings.cfg
  echo "Configure cliseer behavior from ~/.config/cliseer/settings.cfg"
}

cliseer_fzf_dependency() {
    if command -v fzf >/dev/null 2>&1; then
        echo "fzf is installed"
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

# === Run the setup steps ===
config_dependency
cliseer_fzf_dependency
cliprophesy_dependency
