export PATH=/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export EDITOR='vim'
# LS colors, made with https://geoff.greer.fm/lscolors/
export LSCOLORS="Exfxcxdxbxegedabagacad"
# Link Homebrew casks in `/Applications` rather than `~/Applications`
export HOMEBREW_CASK_OPTS="--appdir=/Applications"
# Pick-up command history where OMZ left off
HISTFILE="$HOME/.zsh_history"
HISTSIZE=32768
SAVEHIST=10000
export HISTCONTROL=ignoredups
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"


# chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh


# Use ripgrep for fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Ctrl-P from the command line
# From https://adamheins.com/blog/ctrl-p-in-the-terminal-with-fzf
# This is the same functionality as fzf's ctrl-t, except that the file or
# directory selected is now automatically cd'ed or opened, respectively.
fzf-open-file-or-dir() {
  local cmd="command find -L . \
    \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | sed 1d | cut -b3-"
  local out=$(eval $cmd | fzf-tmux --exit-0)

  if [ -f "$out" ]; then
    $EDITOR "$out" < /dev/tty
  elif [ -d "$out" ]; then
    cd "$out"
    zle reset-prompt
  fi
}
zle     -N   fzf-open-file-or-dir
bindkey '^T' fzf-open-file-or-dir


# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1
# vim mode
bindkey -v
# Open command line in vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd "^V" edit-command-line


# nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"


# aliases
ls -G . &>/dev/null && alias ls='ls -G'
alias zshconfig="vim ~/.zshrc"
alias zshconfig="vim ~/.zshrc"
alias journal="vim ~/Notes/Journal/$(date '+%Y-%m-%d').txt"
alias gratitude="vim ~/Notes/Gratitude/$(date '+%Y-%m-%d').txt"
alias fort="ssh aaron@45.55.251.140 -p30001"
alias zzz="pmset sleepnow"
# alias rails = "bundle exec rails $1"


# Use pure theme
fpath=("$HOME/dotfiles/zsh/functions" $fpath)
autoload -U promptinit; promptinit
prompt pure


# fish-like command syntax highlighting - needs to be the last source in the file
source /Users/agerdes/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh