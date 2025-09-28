# Arisa's Hyprland Dotfiles

This repository contains my personal configuration files for setting up my Wayland desktop environment. It is designed around **Hyprland**, and features a highly customized and minimal workflow using **fish** shell, **Eww** widgets, **Swww**, and **WezTerm** as my terminal emulator. These dotfiles aim for a balance of aesthetics, performance, and productivity, tailored to my everyday needs. 🎀

> [!NOTE]
> This config is already been made for my daily use with hyprland arch only. 
> If you want to use this for daily use, please config it for your daily suitable.
---

## ✨ Features
- Hyprland dynamic tiling window manager
- Gaps, rounded corners, drop shadows
- Smooth window animations
- Eww and Ewww for customizable and beautiful desktop widgets
- Fish shell with fast, modern command-line workflow
- WezTerm as a GPU-accelerated terminal emulator
- Mako for minimal notifications
- Preconfigured keybindings for fast navigation

## 📂 Structure
```bash
.
├── asset
├── .config
│   ├── cava
│   ├── eww
│   ├── fish
│   ├── hypr
│   ├── mako
│   ├── swww
│   ├── waybar
│   ├── wezterm
│   └── wofi
├── README.md
└── script
    ├── bash
    └── main.sh
```

## 🖥️ Core Applications
| Purpose | Application |
|---------|-------------|
| Launcher | `rofi` |
| Terminal | `wezterm` |
| Bar | `eww` |
| Notifications | `mako` |
| Wallpaper | `swww` |

## 🛠️ Installation
```bash
# Clone this repository
git clone https://github.com/AnataAria/hyprdotfiles.git

# Copy configs to ~/.config/
cp -r hyprdotfiles/.config/* ~/.config/

# Install required packages(Arch Linux)
yay -S hyprland-git rofi wezterm fish eww mako swww cliphist wl-clipboard

# Switch your shell to fish
chsh -s /usr/bin/fish

# Enjoy your new environment! 🎀
```

## 🎮 Keybindings (Super = Windows key)
| Keybind | Action |
|--------|--------|
| SUPER + Enter | Open WezTerm |
| SUPER + F | Launch rofi drun |
| SUPER + Q | Close active window |
| SUPER + F | Toggle fullscreen |
| SUPER + V | Toggle floating mode |
| SUPER + P | Toggle pseudo tiling |
| SUPER + S | Toggle split layout |

## 📜 License
MIT License — feel free to use, fork, and customize! 🌸

---

That's all for my everyday Hyprland setup! 🎀

---
