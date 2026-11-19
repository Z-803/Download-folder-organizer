#!/usr/bin/env bash
# Sort loose files in a folder into subfolders by type.
# Usage: sort-downloads.sh [-x] [dir]
#   no flag : dry run (prints what would happen)
#   -x      : actually move the files
#   dir     : defaults to ~/Downloads
set -euo pipefail

run=0
if [[ "${1:-}" == "-x" ]]; then run=1; shift; fi
dir="${1:-$HOME/Downloads}"
cd "$dir"

category() {
  case "${1,,}" in
    jpg|jpeg|png|gif|webp|svg|bmp|heic|avif)          echo Images ;;
    mp4|mkv|webm|mov|avi)                             echo Videos ;;
    mp3|flac|ogg|wav|m4a|opus)                        echo Audio ;;
    pdf|doc|docx|odt|txt|md|epub|xls|xlsx|ods|csv|ppt|pptx|odp) echo Documents ;;
    zip|7z|rar|tar|gz|xz|zst|bz2|tgz)                 echo Archives ;;
    iso|img)                                          echo DiskImages ;;
    deb|rpm|appimage|exe|msi)                         echo Installers ;;
    py|sh|js|ts|c|cpp|h|rs|go|json|yaml|yml|toml)     echo Code ;;
    *)                                                echo Other ;;
  esac
}

for f in *; do
  [[ -f "$f" ]] || continue
  case "$f" in *.part|*.crdownload|*.aria2|*.tmp) continue ;; esac

  if [[ "$f" == *.* ]]; then ext="${f##*.}"; else ext=""; fi
  cat="$(category "$ext")"

  if (( run )); then
    mkdir -p -- "$cat"
    mv -n -- "$f" "$cat/"
    [[ -e "$f" ]] && echo "skipped (already exists in $cat/): $f" || echo "moved: $f -> $cat/"
  else
    echo "would move: $f -> $cat/"
  fi
done

(( run )) || echo "Dry run only. Re-run with -x to apply."
