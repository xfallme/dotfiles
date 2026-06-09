if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Run TMUX, except for vscode
if [[ -n "$VSCODE_PID" ]] || [[ "$TERM_PROGRAM" == "vscode" ]]; then
  ZSH_TMUX_AUTOSTART="false"
else
  ZSH_TMUX_AUTOSTART="true"
  ZSH_TMUX_DEFAULT_SESSION_NAME="Main"
fi

# Set Catppuccin Machiatto for FZF
export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--multi" 

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
zinit light lukechilds/zsh-nvm

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::sudo
zinit snippet OMZP::tmux
zinit snippet OMZP::git
zinit snippet OMZP::docker
zinit snippet OMZP::command-not-found
zinit snippet OMZP::1password
zinit snippet OMZP::systemadmin
zinit snippet OMZP::vscode
# k8s
zinit snippet OMZP::kubectl
zinit snippet OMZP::minikube
zinit snippet OMZP::helm
zinit snippet OMZP::fluxcd

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Oh My Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-flags $(echo $FZF_DEFAULT_OPTS)
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias vmstart="colima start --vm-type=vz --vz-rosetta"
alias vmstop="colima stop"
alias python="python3"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
alias ls="eza --icons=always"
