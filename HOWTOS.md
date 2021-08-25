# Useful informations

Here I save some useful informations that I sometimes need if I have to format/change computer.

## Airplay Server
To mirror the iPad screen, you need to run the UxPlay server:
1. Start the avahi daemon: `sudo avahi-daemon`
2. Start the Airplay server: `uxserver`

## Pandoc
**Setting up**:
1. Download `pandoc` using `stack` (remember to check the LTS version under `~/.stack/global-project/stack.yaml`)
2. Replace the cloned `.pandoc` folder with the `~/.pandoc/` folder
3. To compile using the *"dispense"* configuration, run `pandoc INFILES -d dispense.yaml -o OUTFILE`

## LaTeX
Avoid downloading TeX Live from the `aur` or other repositories.
Instead, install it using the `install-tl` script available [here](https://tug.org/texlive/acquire-netinstall.html).  
**Note**: `PATH` variable should be updated accordingly after a fresh installation.

To update/install packages, use the `tlmgr` utility. If the version cannot be updated from the utility, simply re-install another version, then update the `PATH` variable with the new installation.

## Dotfiles
To store dotfiles I followed [this](https://news.ycombinator.com/item?id=11070797) guide. Basically you just have to run these commands:
```bash
git init --bare $HOME/.myconf
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
config config status.showUntrackedFiles no

# From now on, "config" will work simply as the git command, then
config add .vimrc
config commit -m "Add vimrc"
config push
```

## Haskell
* `ghcup` to manage `ghc` versions
* `stack` to manage packages

## Setting up WiFi connection (Laptop only)
On the laptop if you have to change WiFi connection, just use `wifi-menu`. Configurations are stored under `/etc/netctl/`
