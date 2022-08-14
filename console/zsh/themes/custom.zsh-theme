#!/usr/bin/env zsh

# Number codification:
#   0: Minimal (only exit code, name, current dir and $)
#   1: Time
#   2: RAM
#   3: CPU Temperature
#   4: RAM | Current time
#   5: CPU Temp. | Current time
#   6: CPU Temp. | RAM
#   7: All

HUD_SELECTION=7

if [ "$HUD_SELECTION" -ne 0 ]; then
  echo "${fg_bold[white]}Login: $(date +"%A %d %B %X")$reset_color"
  echo
fi

# Prints the current time of the computer (in the right prompt) every time a command is executed.
function print_current_time() {
  echo " %{${fg_bold[white]}%}$(date +"%X")"
}

function get_CPU_temp() {
  cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp)
  core_temp=$((cpu_temp / 1000))

  echo -n " %{${fg_bold[white]}%}CPU: "

  if [ $core_temp -ge 80 ]; then
    echo -n %{${fg_bold[red]}%}
  elif [ $core_temp -ge 65 ]; then
    echo -n %{${fg_bold[yellow]}%}
  else
    echo -n %{${fg_bold[green]}%}
  fi

  echo -n "$core_temp ºC%{$reset_color%}"
}

function get_free_RAM() {
  # Table of the memory usage | Mem filter | returning the used column of the obtained table.
  # <50 Green   50..80 Yellow   >80 Red
  # Two %% because it is a special character and it must be escaped
  used_memory=$(free -m | grep "^Mem" | awk '{print $3}')
  total_memory=$(free -m | grep "^Mem" | awk '{print $2}')

  percentage_of_memory=$(($used_memory * 100 / $total_memory))

  echo -n " %{${fg_bold[white]}%}RAM: "

  if [ "$percentage_of_memory" -ge "$(($total_memory * 80 / 100))" ]; then
    echo -n %{${fg_bold[red]}%}
  elif [ "$percentage_of_memory" -ge "$(($total_memory * 50 / 100))" ]; then
    echo -n %{${fg_bold[yellow]}%}
  else
    echo -n %{${fg_bold[green]}%}
  fi

  echo -n "$percentage_of_memory%%%{$reset_color%}"
}

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

function hud_selection() {
  case $HUD_SELECTION in
  0)
    echo -n ""
    ;;
  1)
    echo -n "$(print_current_time)"
    ;;
  2)
    echo -n "$(get_free_RAM)"
    ;;
  3)
    echo -n "$(get_CPU_temp)"
    ;;
  4)
    echo -n "$(get_free_RAM)$(print_current_time)"
    ;;
  5)
    echo -n "$(get_CPU_temp)$(print_current_time)"
    ;;
  6)
    echo -n "$(get_CPU_temp)$(get_free_RAM)"
    ;;
  7)
    echo -n "$(get_CPU_temp)$(get_free_RAM)$(print_current_time)"
    ;;
  *)
    echo "Usage: {0|1|2|3|4|5|6|7}"
    ;;
  esac
}

# Username color
if [[ "$USER" == "root" ]]; then USERCOLOR="red"; else USERCOLOR="cyan"; fi

function get_right_prompt() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    echo -n "$(hud_selection) $(git_prompt_info) $(git_prompt_status)$(git_prompt_long_sha)%{$reset_color%}"
  else
    echo -n "$(hud_selection)%{$reset_color%}"
  fi
}

PROMPT=$'$(print_exit_code)''\
 %{$fg_bold[$USERCOLOR]%}$USER\
 %{$fg_bold[yellow]%}[%'${CUSTOM_DIR_LEVELS:-3}'~]\
 %{$fg_bold[cyan]%}$ \
%{$reset_color%}'

RPROMPT='$(get_right_prompt)'

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="%{${fg_bold[green]}%}"
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
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{${fg_bold[white]}%}[%{${fg_bold[cyan]}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{${fg_bold[white]}%}]"
