HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=8192
HISTSIZE=8192

# Load modular configuration (options, aliases, functions).
# (N) is a null-glob qualifier so this is a no-op if the directory isn't present.
for _zsh_config in "$HOME"/.config/zsh/*.zsh(N); do
  [ -r "$_zsh_config" ] && source "$_zsh_config"
done
unset _zsh_config

# Homebrew zsh plugins (optional — guard so a fresh machine doesn't error).
[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
  && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
  && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Tool initialisation.
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
