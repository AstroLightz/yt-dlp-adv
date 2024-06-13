# yt-dlp-adv
A user-friendly, menu-driven ZSH script for yt-dlp

## Requirements
- **Nerd Font in Terminal**: To see the icons on the text, it is recommended to have a Nerd Font active for your terminal. I personally use `Hack Nerd Font`, but you can use whatever you want.

- **ZSH**: Since this is a ZSH script, obviously, ZSH must be installed.

  To install ZSH, you can follow these steps depending on your operating system:

  - **Debian/Ubuntu**: `sudo apt install zsh`
  - **Fedora**: `sudo dnf install zsh`
  - **Arch Linux/Manjaro**: `sudo pacman -S zsh`
  - **macOS**: `brew install zsh` (requires Homebrew)
  - **Windows**: Use WSL (Windows Subsystem for Linux) or install ZSH using a terminal emulator like Git Bash or a package manager like Chocolatey.

## Running the Script

### Adding the Script to Your ZSH Configuration
To integrate the `yt-dlp-adv` script with your ZSH environment, you need to source it in your `.zshrc` file. This setup allows you to run the `yt-dlp-adv` function directly from your terminal.

1. **Download or Clone the Script**:
   Ensure the `yt-dlp-adv.zsh` script is downloaded or cloned to a directory of your choice. For example, you could place it in `~/.zsh/scripts/`.

2. **Source the Script in `.zshrc`**:
   Open your `.zshrc` file with your preferred text editor and add the following line to source the script:
   ```bash
   source /path/to/yt-dlp-adv.zsh
   ```


3. **Run the Script**: To run the script, type the following line in your terminal:
   ```bash
   yt-dlp-adv
   ```
