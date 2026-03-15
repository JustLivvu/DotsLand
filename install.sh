create_backup() {
    mkdir -p ~/dotsland-backup
    [ -d ~/.config/hypr ] && cp -r ~/.config/hypr ~/dotsland-backup/
    [ -d ~/.config/kitty ] && cp -r ~/.config/kitty ~/dotsland-backup/
    [ -d ~/.config/waybar ] && cp -r ~/.config/waybar ~/dotsland-backup/
    [ -d ~/.config/fastfetch ] && cp -r ~/.config/fastfetch ~/dotsland-backup/
    [ -d ~/.config/rofi ] && cp -r ~/.config/rofi ~/dotsland-backup/
    echo "Backup complete..."
}

check_packages() {

    GREEN="\033[92m"
    RED="\033[91m"
    RESET="\033[0m"

    packages=(hyprland swaylock grim slurp kitty waybar rofi fastfetch nautilus swaylock-effects)

    echo "Checking packages..."
    for pkg in "${packages[@]}"; do
        if command -v "$pkg" >/dev/null 2>&1; then
            echo -e "[${GREEN}✓${RESET}] $pkg"
        else
            echo -e "[${RED}✗${RESET}] $pkg"
        fi
    done

    echo
}

install_dotfiles() {
    CONFIG_DIR="$HOME/.config"
    DOTFILES_DIR="./configs" 

    folders=(fastfetch hypr kitty rofi waybar)

    for folder in "${folders[@]}"; do
        SRC="$DOTFILES_DIR/$folder"
        DEST="$CONFIG_DIR/$folder"

        if [ -d "$SRC" ]; then
            mkdir -p "$DEST"
            cp -r "$SRC/"* "$DEST/"
            echo -e "Installed $folder \033[92m→\033[0m $DEST"
        else
            echo "Skipping $folder, folder not found in configs/"
        fi
    done

    echo -e "\033[92mDotfiles installation complete!\033[0m"
}
echo '
 ________          __         .____                       .___
 \______ \   _____/  |_  _____|    |   _____    ____    __| _/
  |    |  \ /  _ \   __\/  ___/    |   \__  \  /    \  / __ | 
  |    `   (  <_> )  |  \___ \|    |___ / __ \|   |  \/ /_/ | 
 /_______  /\____/|__| /____  >_______ (____  /___|  /\____ | 
         \/                 \/        \/    \/     \/      \/ 
 Welcome to DotsLand installation script.
'

check_packages

echo -e -n "Do you want to create backup of existing configuration? (\033[92mY\033[0m/\033[91mN\033[0m) "
read answer

if [ "$answer" = "Y" ] || [ "$answer" = "y" ]; then
    echo "Creating backup..."
    create_backup
elif [ "$answer" = "N" ] || [ "$answer" = "n" ]; then
    echo "Skipping backup."
else
    echo "Invalid option."
fi

echo -e -n "Do you want to install dotfiles to ~/.config? (\033[92mY\033[0m/\033[91mN\033[0m) "
read answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
    echo "Installing dotfiles..."
    install_dotfiles
elif [[ "$answer" =~ ^[Nn]$ ]]; then
    echo "Skipping dotfiles installation."
else
    echo "Invalid option. Skipping dotfiles installation."
fi