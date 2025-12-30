if status is-interactive

    # bind \eo prevd # Ctrl+O for previous directory
    # bind \ei nextd # Ctrl+I for next directory
    # Commands to run in interactive sessions can go here
    bind \eo 'prevd; commandline -f repaint' # Ctrl+O for previous directory
    bind \ei 'nextd; commandline -f repaint' # Ctrl+I for next directory

    function n
        nvim .
    end

# Git shortcuts
    function gst
        git status
    end

    function gp
        git push
    end

    function gca
        git add .
        git commit -m "$argv"
    end
 # Git extras
    function gd
        git diff $argv
    end

    function venv
        if test -d .venv
            source .venv/bin/activate.fish
        else
            python3 -m venv .venv
            source .venv/bin/activate.fish
        end
    end

    function gl
        git log --oneline --graph --decorate $argv
    end

    # Quick directory creation and navigation
    function mkcd
        mkdir -p $argv[1] && cd $argv[1]
    end

    # List directory contents with human-readable sizes
    function l
        ls -lah $argv
    end

    # Find files by name
    function ff
        fd --type f --hidden --exclude .git $argv
    end

    function ffd
        fd --type d --hidden --exclude .git $argv
    end
    # Quick edit of config.fish
    function fishconfig
        nvim ~/.config/fish/config.fish
        source ~/.config/fish/config.fish  
    end

    function psgrep
        ps aux | grep $argv[1]
    end

    function killport
        kill -9 (lsof -t -i:$argv[1])
    end

    function portinfo 
        ps (lsof -t -i:$argv[1])
    end


    function loc
        find . -type f -name "*.$argv[1]" | xargs wc -l
    end

    set fish_color_autosuggestion '#d5c4a1' # Gruvbox light gray


end

eval "$(/opt/homebrew/bin/brew shellenv)"

zoxide init fish | source
fzf --fish | source


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/emresin/google-cloud-sdk/path.fish.inc' ]; . '/Users/emresin/google-cloud-sdk/path.fish.inc'; end

# Created by `pipx` on 2025-02-17 21:31:46
set PATH $PATH /Users/emresin/.local/bin
set PATH $HOME/development/flutter/bin:$PATH
set -gx PATH $HOME/development/flutter/bin $PATH
set -gx PATH $HOME/.gem/bin $PATH
set -x PATH $PATH $HOME/.pub-cache/bin


# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/emresin/.lmstudio/bin
