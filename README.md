# CLISeer

Press `Ctrl+Space` in your terminal to activate AI powered command line suggestions.

![Demo](./.github/demo.gif)

CLISeer helps you

- **Remember complex syntax** without googling or asking ChatGPT
- **Discover command options** you didn't know existed
- **Understand commands** in plain English

It only runs when invoked and hides suggestions after they are generated so it doesn't modify the default zsh experience.

## How it works

Simply start typing in a command and at any point press `Ctrl-Space` for recommendations.  It will generate recommendations based on your current command buffer, command history, operating information, and previous command statuses.

Select a suggestion to replace the current buffer or pres `Ctrl-Space` again to exit.

## Installation

### Option 1: Oh-My-Zsh

``` zsh
git clone https://github.com/cliseer/cliseer-zsh
mkdir -p $ZSH/custom/plugins/cliseer
cp cliseer.plugin.zsh $ZSH/custom/plugins/cliseer/
bash cliseer_dependencies.sh # installs the dependencies
source ~/.zshrc
```
Use `$ZSH_CUSTOM` instead of `$ZSH/custom` if set.

### Option 2: No plugins
``` zsh
git clone https://github.com/cliseer/cliseer-zsh
# set to where you want to store your plugin
ZSH_PLUGINS=~/.zsh_plugins/
mkdir -p $ZSH_PLUGINS
cp cliseer.plugin.zsh $ZSH_PLUGINS
# add source ~/.zsh-plugins/cliseer.plugin.zsh to your ~/.zshrc file
bash install_cliseer_dependencies.sh
source ~/.zshrc
```

## Dependencies

- [fzf](https://github.com/junegunn/fzf) - Displays and navigates command suggestions
- [cliprophesy](https://github.com/cliseer/cliprophesy) - Calls the LLM backend

Run `bash cliseer_dependencies.sh` to install

## Configuration

The timeout, AI provider and other settings are configured by `~/.config/cliseer/settings.cfg`

### AI Providers

By default, CLISeer uses the `cliseer` provider, which offers a rate-limited number of completions through our hosted server. You can configure these alternate providers


| Provider | Environment Variable | Description |
|----------|---------------------|-------------|
| `openai` | `OPENAI_API_KEY` | Uses OpenAI's models for suggestions |
| `anthropic` | `ANTHROPIC_API_KEY` | Uses Anthropic's Claude models |
| `cliseer`   | no api key, but rate limited |                 |

### iTerm2 Users

iterm2 doesn't send ctrl-space by default. To enable it, go to Preferences → Profiles → Keys, and add a new key mapping for `Ctrl+Space` with the action "Send Hex Code" and value "0x20" (space character).

## Privacy Notice

**Important:** When invoked CLISeer sends the following data to the configured AI provider

- Your current and recent Zsh shell commands
- Operating system and shell information
- Previous command exit codes

This data may inadvertently include sensitive information such as API keys or passwords if present in your history. Use with care


## Support

- GitHub: [https://github.com/cliseer/cliseer-zsh](https://github.com/cliseer/cliseer-zsh)
- Issues: [https://github.com/cliseer/cliseer-zsh/issues](https://github.com/cliseer/cliseer-zsh/]
