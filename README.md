# Cong's Terminal Setup

This is the collection of necessary files to set up Cong's working environment from scratch.

## iTerm2
I use the Solarized theme for my iTerm2. To update your iTerm2 with my profile, you need to include
the .plist file in your iTerm2. Open the Preferences under `iTerm2 > Preferences`. In the `General` tab,
look at the bottom under the `Preferences` menu. You want to check the `Load preferences from a custom folder or URL`.
Make a directory, select it, and then copy the .plist file there. Restart iTerm2 and the new Profile should be loaded.

## Bash
I use Bash and have a simple `.bash_profile` file that shows the existing git branch I'm in and sources a `.bash_aliases` file.

## Tmux
Use `tmux.conf` for tmux set up.

## Vim
Use `vimrc` for vim set up. I used Vundle to manage plugins and they're listed out in the `vimrc.bundle` file.
