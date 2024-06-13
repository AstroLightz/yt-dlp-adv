### YouTube Downloader: Advanced - User-friendly, Menu-driven yt-dlp ZSH script ###
### Made by: AstroLightz

# Helper function for getting the number of titles from the YT url
function get_title_count()
{
  local yt_url=$1
  local titles=()

  # Extract all the titles from a url
  while IFS= read -r line; do
    title=$(echo "$line" | cut -d '|' -f1 | tr -d '[:cntrl:]')
    titles+=("$title")

  done < <(yt-dlp --flat-playlist --print "%(title)s" "$yt_url" 2>/dev/null)

  echo ${#titles[@]}
}

# yt-dlp Advanced: More menu driven version of yt-dlp
function yt-dlp-adv
{
  # ANSI Color Codes
  RED="\e[31m"      # Fail
  GREEN="\e[32m"    # Success
  YELLOW="\e[33m"   # Prompt
  BLUE="\e[34m"     # Action
  MAGENTA="\e[35m"  # Misc
  CYAN="\e[36m"     # Highlight
  RESET="\e[0m"     # Reset

  # Title (tribute to ArchLinux) and credits
  echo -e "\nWelcome to ${RED}YouTube Downloader: Advanced${RESET}!\n"
  echo -e "${RED}●${RESET} This is a ZSH script that simplifies the use of the ${RED}yt-dlp${RESET} tool (${CYAN}'https://github.com/yt-dlp/yt-dlp'${RESET})."
  echo -e "${RED}●${RESET} It provides a user-friendly, menu-driven interface to help you download videos, audio, and thumbnails from YouTube and other platforms."
  echo -e "${RED}●${RESET} You can easily customize download options and formats without needing to remember complex command-line arguments."
  echo -e "${RED}●${RESET} The script supports downloading entire playlists or single items."
  echo -e "${RED}●${RESET} It also offers detailed feedback on the download status and file sizes.\n"
  echo -e "${MAGENTA}●${RESET} I designed this script to be straightforward and user-friendly for people who, like me, don't have a lot of time to look up-"
  echo -e "${MAGENTA}●${RESET} complex commands and just need a quick way to download content.\n"
  echo -e "${YELLOW}●${RESET} Script made by ${CYAN}AstroLightz${RESET}. I hope you enjoy!\n\n"



  # Get Download type
  echo -e "\n${YELLOW}?${RESET} What would you like to download?"
  echo -e "  ${CYAN}1${RESET}) Videos"
  echo -e "  ${CYAN}2${RESET}) Audio"
  echo -e "  ${CYAN}3${RESET}) Thumbnails"
  echo -n "\n> ${MAGENTA}[1/2/3]${RESET} ${CYAN}(1)${RESET}: "
  read dwn_type

  # Check which download type the user chose
  case $dwn_type in
    2)
      # Audio
      echo -e "\n${YELLOW}?${RESET} What file format do you want to use?"
      echo -e "  ${CYAN}1${RESET}) MP3"
      echo -e "  ${CYAN}2${RESET}) OGG"
      echo -e "  ${CYAN}3${RESET}) WAV"
      echo -e "  ${CYAN}4${RESET}) FLAC"
      echo -n "\n> ${MAGENTA}[1/2/3/4]${RESET} ${CYAN}(1)${RESET}: "
      read file_format
      ;;

    3)
      # Thumbnails
      echo -e "\n${YELLOW}?${RESET} What file format do you want to use?"
      echo -e "  ${CYAN}1${RESET}) PNG"
      echo -e "  ${CYAN}2${RESET}) JPG"
      echo -n "\n> ${MAGENTA}[1/2]${RESET} ${CYAN}(1)${RESET}: "
      read file_format
      ;;

    *)
      # Default to Videos
      echo -e "\n${YELLOW}?${RESET} What file format do you want to use?"
      echo -e "  ${CYAN}1${RESET}) MP4"
      echo -e "  ${CYAN}2${RESET}) MKV"
      echo -e "  ${CYAN}3${RESET}) WEBM"
      echo -n "\n> ${MAGENTA}[1/2/3]${RESET} ${CYAN}(1)${RESET}: "
      read file_format
      ;;
  esac

  # Prompt user if this is a playlist or a single item
  echo -e "\n${YELLOW}?${RESET} Is it a playlist or a single item?"
  echo -e "  ${CYAN}1${RESET}) Playlist"
  echo -e "  ${CYAN}2${RESET}) Single Item"
  echo -n "\n> ${MAGENTA}[1/2]${RESET} ${CYAN}(2)${RESET}: "
  read item_count

  # If item_count is anything but 1, default its value to 2.
  if [[ $item_count != "1" ]]; then
    item_count="2"
  fi

  # Prompt user the filename format if the download type isnt Thumbnails
  if [[ $dwn_type != "3" ]]; then
    echo -e "\n${YELLOW}?${RESET} What format do you want the filenames to be?"
    echo -e "  ${CYAN}1${RESET}) (uploader) - (title).(ext)"
    echo -e "  ${CYAN}2${RESET}) (title).(ext)"
    echo -n "\n> ${MAGENTA}[1/2]${RESET} ${CYAN}(1)${RESET}: "
    read filename_format
  fi

  # Prompt user to enter URL
  echo -e "\n${YELLOW}?${RESET} Enter the YouTube URL:"
  echo -n "> ${CYAN}"
  read yt_url
  echo -e "${RESET}"

  # Check if URL is not a valid URL
  if [[ ! "$yt_url" =~ ^https?:// ]]; then
        echo -e "${RED}✘${RESET} The entered URL is not valid. Please make sure the URL starts with ${CYAN}'https'${RESET} or ${CYAN}'http'${RESET}."
        return 1
  fi

  yt_dlp_options=""

  # Setup download options based on file extension and download type
  case $dwn_type in
    2)
      # Audio
      case $file_format in
        2) ext="OGG"; yt_dlp_options="-x --audio-format vorbis" ;;
        3) ext="WAV"; yt_dlp_options="-x --audio-format wav" ;;
        4) ext="FLAC"; yt_dlp_options="-x --audio-format flac" ;;
        *) ext="MP3"; yt_dlp_options="-x --audio-format mp3" ;;
      esac

      output_dir="~/Music/YouTube Downloads/${ext}/"
      ;;

    3)
      # Thumbnails
      case $file_format in
        2) ext="JPG"; yt_dlp_options="--skip-download --write-thumbnail --convert-thumbnails jpg" ;;
        *) ext="PNG"; yt_dlp_options="--skip-download --write-thumbnail --convert-thumbnails png" ;;
      esac

      output_dir="~/Pictures/YouTube Downloads/${ext}/"
      ;;

    *)
      # Default to Videos
      case $file_format in
        2) ext="MKV"; yt_dlp_options="-f bestvideo+bestaudio --merge-output-format mkv" ;;
        3) ext="WEBM"; yt_dlp_options="-f bestvideo+bestaudio --merge-output-format webm" ;;
        *) ext="MP4"; yt_dlp_options="-f bestvideo+bestaudio --merge-output-format mp4" ;;
      esac

      output_dir="~/Videos/YouTube Downloads/${ext}/"
      ;;
  esac

  # Get total number of titles in a URL and check if it matches the selected $item_count
  echo -e "${BLUE}➜${RESET} Processing URL. Please wait..."

  title_count=$(get_title_count "$yt_url")
  incorrect_mode="false"

  if [[ $title_count -gt 1 ]] && [[ $item_count == "2" ]]; then
    # Playlist # of items, Single item chosen

    # Set incorrect mode
    incorrect_mode="true"

    # Get mode names
    mode_name_chosen="Single Mode"
    mode_name_correct="Playlist"

    echo -e "\n${YELLOW}?${RESET} The URL contains more than one item, when ${RED}'${mode_name_chosen}'${RESET} mode was chosen. Do you want to switch to ${GREEN}'${mode_name_correct}'${RESET} mode?"
    echo -n "> ${MAGENTA}[Y/n]${RESET}: "
    read switch_mode

  elif [[ $title_count -eq 1 ]] && [[ $item_count == "1" ]]; then
    # 1 item, Playlist chosen

    # Set incorrect mode
    incorrect_mode="true"

    mode_name_chosen="Playlist"
    mode_name_correct="Single Item"

    echo -e "\n${YELLOW}?${RESET} The URL contains only one item, when ${RED}'${mode_name_chosen}'${RESET} mode was chosen. Do you want to switch to ${GREEN}'${mode_name_correct}'${RESET} mode?"
    echo -n "> ${MAGENTA}[Y/n]${RESET}: "
    read switch_mode
  fi

  # Automatically Change to correct $item_count value if yes was selected. Exit if no was selected.
  if [[ $incorrect_mode == "true" ]]; then
    if [[ "$switch_mode" == "n" ]] || [[ "$switch_mode" == "N" ]]; then
        # Did not want to auto switch modes
        echo -e "\n${RED}✘${RESET} Cannot download items due to incorrect mode selected. Please choose the right mode for the provided URL."
        echo -e "- Chosen Mode: ${RED}'${mode_name_chosen}'${RESET}"
        echo -e "- Correct Mode: ${GREEN}'${mode_name_correct}'${RESET}"
        return 1

    else
        # Default to switch modes
        if [[ $item_count == "1" ]]; then
          item_count="2"
        else
          item_count="1"
        fi

        echo -e "\n${GREEN}✔${RESET} Mode changed successfully from ${RED}'${mode_name_chosen}'${RESET} to ${GREEN}'${mode_name_correct}'${RESET}. Continuing with download..."
    fi
  fi

  # Arrays for storing information about provided URL
  titles=()
  urls=()
  uploaders=()
  statuses=()

  # Determine output dir based on if item is single or playlist. Default to singles
  case $item_count in
    1)
      # Get playlist name
      playlist_name=$(yt-dlp --flat-playlist --print "%(playlist_title)s" "$yt_url" 2>/dev/null | awk 'NR==1 {print; exit}')

      output_dir+="Playlists/${playlist_name}/"

      # Extract all the titles of a video in a playlist
      while IFS= read -r line; do
        title=$(echo "$line" | cut -d '|' -f1 | tr -d '[:cntrl:]')
        uploader=$(echo "$line" | cut -d '|' -f2 | tr -d '[:cntrl:]')
        url=$(echo "$line" | cut -d '|' -f3)
        titles+=("$title")
        uploaders+=("$uploader")
        urls+=("$url")
        statuses+=("Pending")

      done < <(yt-dlp --flat-playlist --print "%(title)s|%(uploader)s|%(url)s" "$yt_url" 2>/dev/null)
      ;;

    *)
      output_dir+="Singles/"

      # Extract title and url of single video
      title=$(yt-dlp --print "%(title)s" "$yt_url" 2>/dev/null | tr -d '[:cntrl:]')
      uploader=$(yt-dlp --print "%(uploader)s" "$yt_url" 2>/dev/null | tr -d '[:cntrl:]')
      titles+=("$title")
      uploaders+=("$uploader")
      urls+=("$yt_url")
      statuses+=("Pending")
      ;;

  esac

  # For Audio and Video, determine filename format
  if [[ $dwn_type != "3" ]]; then
    case $filename_format in
      2) yt_dlp_options+=" -o \"${output_dir}%(title)s.%(ext)s\"" ;;  # (title).(ext)
      *) yt_dlp_options+=" -o \"${output_dir}%(uploader)s - %(title)s.%(ext)s\"" ;;  # (uploader) - (title).(ext) (default)
    esac

  # For Thumbnails, default to just title
  else
    yt_dlp_options+=" -o \"${output_dir}%(title)s.%(ext)s\""
  fi

  # Download each video and update the status
  echo -e "\n${BLUE}➜${RESET} Starting to download ${YELLOW}${#titles[@]}${RESET} item(s). Please be patient as this might take a while...\n"

  for (( i=1; i<${#titles[@]}+1; i++ )); do
    title="${titles[$i]}"
    url="${urls[$i]}"

    echo -ne "${YELLOW}($(($i))/${#titles[@]})${RESET} Downloading: ${CYAN}'${title}'${RESET} ... "

    # Execute the download command
    eval "yt-dlp $yt_dlp_options \"$url\"" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
      statuses[$i]="Completed"
      echo -e "${GREEN}Completed${RESET}"

    else
      statuses[$i]="Failed"
      echo -e "${RED}Failed${RESET}"
    fi

  done

  # Get the current user's home directory
  USER_HOME=$(echo ~)

  # Replace the tilde with the full home directory path in $output_dir
  output_dir_full=$(echo "$output_dir" | sed "s|^~/|$USER_HOME/|")

  # Get the size of the playlist or single item
  if [[ $item_count == "1" ]]; then
    # For playlists, calculate the size of the entire directory
    download_size_bytes=$(du -sb "$output_dir_full" | cut -f1)
    download_size_mb=$(awk "BEGIN {printf \"%.2f\", $download_size_bytes / 1048576}")

  else

    # Get ext in lower
    ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')

    # For single items, calculate the size based on the filename format chosen
    if [[ $filename_format == "2" ]]; then
      # Format: (title).(ext)
      single_file="${output_dir_full}${titles[1]}.${ext_lower}"
    else
      # Default Format: (uploader) - (title).(ext)
      single_file="${output_dir_full}${uploaders[1]} - ${titles[1]}.${ext_lower}"

      # Remove special characters that might be part of filenames
      single_file=$(echo "$single_file" | tr -d '[:cntrl:]')
    fi

    # Check which file actually exists and get its size
    if [ -f "$single_file" ]; then
      download_size_bytes=$(wc -c <"$single_file")

      download_size_mb=$(awk "BEGIN {printf \"%.2f\", $download_size_bytes / 1048576}")
    fi
  fi

  # Downloads Summary
  completed_count=0
  failed_count=0

  # Increment each counter depending on what is in the statuses array
  for (( i=1; i<${#titles[@]}+1; i++ )); do
    if [[ "${statuses[$i]}" == "Completed" ]]; then
      ((completed_count++))
    else
      ((failed_count++))
    fi
  done

  # Summary display
  echo -ne "\n\n\n${GREEN}✔${RESET} ${YELLOW}${completed_count}${RESET} out of ${YELLOW}${#titles[@]}${RESET} item(s) downloaded successfully. "
  echo -e "Used ${YELLOW}${download_size_mb} MB${RESET} of storage."

  # Number of failed downloads display
  if [ $failed_count -gt 0 ]; then
    echo -e "${RED}✘${RESET} ${RED}${failed_count}${RESET} item(s) failed to download:"

    for (( i=0; i<${#titles[@]}; i++ )); do
      if [[ "${statuses[$i]}" == "Failed" ]]; then
        echo -e "  - ${CYAN}'${titles[$i]}'${RESET}"
      fi

    done
  fi

}
