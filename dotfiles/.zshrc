HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=8192
HISTSIZE=8192

# Load modular configuration (options, aliases, functions).
# (N) is a null-glob qualifier so this is a no-op if the directory isn't present.
for _zsh_config in "$HOME"/.config/zsh/*.zsh(N); do
  [ -r "$_zsh_config" ] && source "$_zsh_config"
done
unset _zsh_config

# Use ripgrep's Git-aware file list for fzf's file picker, including dotfiles
# while excluding the Git metadata directory.
if command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Tool initialisation. fzf goes before atuin so atuin keeps ctrl-r and fzf keeps
# ctrl-t / alt-c — whichever loads last wins the binding.
# [-t 0] because fzf's keybindings need a terminal; without it `zsh -i -c ...`
# warns "can't change option: zle".
command -v fzf >/dev/null 2>&1 && [ -t 0 ] && source <(fzf --zsh)
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# Homebrew zsh plugins (optional — guard so a fresh machine doesn't error).
# These must come after every tool that adds a widget: zsh-syntax-highlighting
# only wraps widgets that already exist when it loads, so it goes last of all.
# HOMEBREW_PREFIX comes from brew shellenv in .zprofile, so this costs no fork.
_brew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
[ -f "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] \
  && source "$_brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] \
  && source "$_brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
unset _brew_prefix
