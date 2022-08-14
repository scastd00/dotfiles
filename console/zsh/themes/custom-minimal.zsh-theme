#!/usr/bin/env zsh

# Prints the exit code of the last command.
function print_exit_code() {
  exit_code=$?

  if [ $exit_code -eq 0 ]; then
    echo -n %{${fg_bold[green]}%}
  else
    echo -n %{${fg_bold[red]}%}
  fi

  echo -n "{▸" $exit_code"}%{$reset_color%}"
}

# Beta color Bold green or Bold red.
# CUSTOM="%(?,%{${fg_bold[green]}%}λ,%{${fg_bold[red]}%}λ)"

# Username color
if [[ "$USER" == "root" ]]; then USERCOLOR="red"; else USERCOLOR="cyan"; fi

function get_right_prompt() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    echo -n "$(git_prompt_info) $(git_prompt_status)$(git_prompt_short_sha)%{$reset_color%}"
  else
    echo -n "$(git_prompt_info) $(git_prompt_status)$(git_prompt_short_sha)%{$reset_color%}"
  fi
}

PROMPT=$'$(print_exit_code)''\
 %{$fg_bold[yellow]%}[%'${CUSTOM_DIR_LEVELS:-1}'~]\
 %{${fg_bold[cyan]}%}$\
 %{$reset_color%}'

RPROMPT='$(get_right_prompt)'

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="%{${fg_bold[green]}%} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset_color}%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN="%{${fg_bold[green]}%} ✔"

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_ADDED="%{${fg_bold[green]}%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{${fg_bold[blue]}%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{${fg_bold[red]}%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{${fg_bold[magenta]}%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{${fg_bold[yellow]}%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{${fg_bold[cyan]}%}?"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{${fg_bold[white]}%}^"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{${fg_bold[white]}%}%{${fg_bold[cyan]}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{${fg_bold[white]}%}"

