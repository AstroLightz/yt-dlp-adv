# YouTube Downloader: Advanced
A user-friendly, menu-driven ZSH script for yt-dlp

### IMPORTANT: This Script is now deprecated. Please use the [Python Remake](https://github.com/AstroLightz/yt-dlp-adv2) instead.

### User-Friendly Prompts
![yt script prompts](https://github.com/AstroLightz/yt-dlp-adv/assets/35205155/cd4bc52f-ddd4-45bc-b911-9d1a553ea16d)

### Clean Downloads
![yt script downloads](https://github.com/AstroLightz/yt-dlp-adv/assets/35205155/0a5a58b0-9544-4388-bbaa-7ebb3354e0ff)

### Detailed Summary
![yt script summary](https://github.com/AstroLightz/yt-dlp-adv/assets/35205155/ffe52207-367b-4111-a3ac-36da93bfba36)

## Requirements
- **yt-dlp**: Obviously, this script relies on `yt-dlp` to download videos. Make sure you have `yt-dlp` installed and available in your system's PATH. You can install `yt-dlp` using the following methods:

  - **Python (Recommended)**: 
    ```bash
    pip install yt-dlp
    ```
  
  - **Direct Download**: 
    Download the binary from [yt-dlp releases](https://github.com/yt-dlp/yt-dlp/releases) and place it in a directory included in your PATH.
  
  - **Package Manager**:
    - **Debian/Ubuntu**: `sudo apt install yt-dlp`
    - **Arch Linux/Manjaro**: `sudo pacman -S yt-dlp`
    - **macOS**: `brew install yt-dlp` (requires Homebrew)

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

## Notes

- **Designed for Desktop Linux**: This script was mainly created for use on **desktop Linux systems**. I haven’t tested it on other systems like macOS or Windows with WSL, so it might not work perfectly on those. Keep this in mind if you’re using something other than desktop Linux.

- **Tested Only with YouTube URLs**: So far, I’ve only tested this script with URLs from YouTube. If you try using it with URLs from other sites, your results may vary. 

- **Early ZSH Script**: This is my first major script written in ZSH, so it might not be the most optimized or perfectly structured. I’m still learning, so there could be areas to improve.

- **Feel Free to Fork**: You’re welcome to fork this repository and make your own changes. No need to give credit—just use it however you want!
