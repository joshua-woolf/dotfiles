# Shell options and completion setup.

setopt APPEND_HISTORY
setopt AUTO_CD
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt NO_CASE_GLOB

autoload -Uz compinit
# Regenerate the completion cache at most once a day, otherwise load it (-C skips
# the security/freshness checks) to keep shell startup fast.
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

if command -v carapace >/dev/null 2>&1; then
  source <(carapace _carapace)
fi
