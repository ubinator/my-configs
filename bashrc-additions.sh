#!/bin/false

# NOTE: This file is meant to be sourced from your .bashrc using "source /path/to/folder/my-configs/bashrc-additions.sh".
# You can source it as many times as you want.

# Sets the CURRENT_HOME shell variable, which is used to keep track of the currently saved home.
CURRENT_HOME=$HOME
# Defines an alias that sets the home directory to the current directory.
alias sethome='CURRENT_HOME=$PWD ; echo -e "\033[0;32mHome saved."'
# Defines an alias that moves the working directory to the home directory.
alias home='cd $CURRENT_HOME ; echo -e "\033[0;32mReturned to home."'

# Setup for an alias that makes git log less annoying to work with.
alias gitlog='git --no-pager log --oneline --reverse --decorate'
# Same thing essentially but displays all branches in graph form, sadly, not possible to use --reverse flag here.
alias gitloggraph='git log --oneline --decorate --graph --all'

# This makes it so commands from different sessions all get put into the bash history file. Previously, only the most recently closed session got it's commands added.
PROMPT_COMMAND='history -a'     # After every command, before displaying prompt (the green and blue thing with user + hostname), append unwritten history to history file. Shouldn't be a heavy operation, just appending single lines.
