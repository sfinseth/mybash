# BetterGitBash
Contains a bunch of aliases and a much improved PS1

#Installation
For Windows:

Move the file to 
    
    C:\Users\[username]\.bashrc

open your git prompt and input

source [file\_path]

For Linux:

Move the file to desired location

    I have cloned the repository to ~/projects/mybash

And then run:
    
    ln -s ~/.bashrc ~/projects/mybash/.bashrc

run: source ~/.bashrc

Enjoy :)

#Only show status indicators when there are any changes
If you only wish to see the status indicators when there are changes you can change line 244:

    always_show="true";

to

    always_show="false";

#Aliases
There are too many aliases to list, but there are shorthand versions of most common git operations,
refer to the aliases section in .bashrc for a complete list.

#Functions
This will take the first part of your branch name (PRODUCTION-1234) and prefix your commit message with that
This is equal to: git commit -m "PRODUCTION-1234 your commit message"

    gsc "your commit message"

Open Google Chrome, only works under WSL:

    chrome [url to open]

_note:_ Will open google chrome with the specified page 
(or a new tab if no page was specified) - multiple pages can be specified at once

Open the MSP Github website in the branch and path you are currently:

    github

_note:_ Uses the chrome function

Echo the name of the current branch:

    current_branch

Echo the name of the current repository:

    current_repository

Git smart commit and push:

    gcp "your commit message"

_note:_ Invokes the gsc and does a push

Lists the changes currently in your branch that are not in the origin

    gcl

Clean your local copy of the repository completely _use with causion_

    gnuke

_note:_ Does a checkout of the entire repository and a complete clean
