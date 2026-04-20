# Dotfiles

## Dependencies:

### Basics:

```
sudo pacman -S --needed git curl wget base-devel bc cmake make rsync ripgrep fontconfig clang
```

### nvim:

```
yay -S --needed neovim nvim-packer-git meson nodejs npm tree-sitter tree-sitter-{bash,c,javascript,lua,markdown,rust}
```

### Terminal emulator:

```
yay -S --needed alacritty starship ttf-jetbrains-mono ttf-jetbrains-mono-nerd autojump zoxide readline bash-completion
```

### Hyprland:

https://github.com/hyprwm/contrib Only the grimblast utility is needed for screenshots

```
yay -S --needed xdg-desktop-portal-hyprland grim slurp cava pavucontrol-qt playerctl geoclue brightnessctl ddcutil cliphist jq xdg-user-dirs xdg-utils adw-gtk-theme-git darkly-bin matugen-bin otf-space-grotesk ttf-jetbrainss-mono-nerd ttf-material-symbols-variable-git ttf-readex-pro ttf-rubik-vf ttf-twemoji wl-clipboard hypr{land,sunset,idle,land-protocols,land-qt-support,lang,lock,paper,shot,toolkit,utils,wire} nwg-displays nwg-dock-hyprland nwg-panel gnome-keyring polkit-kde-agent swappy tesseract tesseract-data-eng wf-recorder upower wtype ydotool fuzzel glib2 imagemagick songrec translate-shell wlogout libqalculate quickshell dunst
```
Extra qt dependencies:

```
yay -S --needed qt6-base qt6-declarative qt6-5compat qt6-avif-image-plugin qt6-imageformats qt6-multimedia qt6-positioning qt6-quicktimeline qt6-sensors qt6-svg qt6-tools qt6-translations qt6-virtualkeyboard qt6-wayland kirigami kdialog syntax-highlighting vulkan-headers libdrm cpptrace jemalloc
```

