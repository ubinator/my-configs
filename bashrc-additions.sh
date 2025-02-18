#!/bin/false

# NOTE: This file is meant to be sourced from your .bashrc using "source /path/to/folder/my-configs/bashrc-additions.sh".
# You can source it as many times as you want.

# Sets the CURRENT_HOME shell variable, which is used to keep track of the currently saved home.
CURRENT_HOME="$HOME"
# Defines an alias that sets the home directory to the current directory.
alias sethome='CURRENT_HOME=$PWD ; echo -e "\033[0;32mHome saved."'
# Defines an alias that moves the working directory to the home directory.
alias home='cd $CURRENT_HOME ; echo -e "\033[0;32mReturned to home."'

# Setup for an alias that makes git log less annoying to work with.
alias gitlog='git --no-pager log --oneline --reverse --decorate'
# Same thing essentially but displays all branches in graph form, sadly, not possible to use --reverse flag here.
alias gitloggraph='git log --oneline --decorate --graph --all'

# This makes it so commands from different sessions all get put into the bash history file. Previously, only the most recently closed session got it's commands added.
commands_to_add_to_prompt_command="history -a"         # After every command, before displaying prompt, append unwritten history to history file.

# Primitive check to determine if PROMPT_COMMAND is empty. If it isn't, add command with ;.
# If it is, just overwrite with command.
filtered_prompt_command=$(echo "$PROMPT_COMMAND" | sed -e "s/ //g")
if [ "$filtered_prompt_command" == "" ]
then
       PROMPT_COMMAND="$commands_to_add_to_prompt_command"
else
       PROMPT_COMMAND="$PROMPT_COMMAND ; $commands_to_add_to_prompt_command"
fi
