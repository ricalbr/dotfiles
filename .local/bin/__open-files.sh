#!/usr/bin/env bash
set -o pipefail

# help
help_function() {
	echo "usage: __open_file.sh [query] [-h|--help]"
	echo ""
	echo "open files using fzf (or fzf-tmux inside tmux) and the configured editor"
	echo "supports multi-selection and smart layout in nvim"
	echo ""
	echo "options:"
	echo "  -h, --help    show this help message and exit"
	echo ""
	echo "arguments:"
	echo "  [query]       optional query to filter file selection"
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
	help_function
	exit 0
fi
QUERY="${1:-}"

# choose fzf or fzf-tmux
if [[ -n "${TMUX:-}" ]] && command -v fzf-tmux >/dev/null 2>&1; then
	FZF_CMD=(fzf-tmux -p 80%,80%)
else
	FZF_CMD=(fzf --height 80% --border)
fi

# file source, fd preferred
if command -v fd >/dev/null 2>&1; then
	FILE_LIST_CMD=(fd --type f --hidden --follow --exclude .git)
else
	FILE_LIST_CMD=(find . -type f)
fi

# preview for fzf
preview_cmd='
if [[ -d {} ]]; then
	eza --color=always --long --all --header --icons --git {}
else
	bat --color=always --style=numbers --line-range=:500 {}
fi
'

# run fzf
selected=$("${FILE_LIST_CMD[@]}" | "${FZF_CMD[@]}" \
	--preview "$preview_cmd" \
	--reverse \
	--query "$QUERY" \
	--multi \
	--select-1 \
	--exit-0
)

[[ -z "$selected" ]] && exit 0

# convert selection to array safely
IFS=$'\n' read -r -d '' -a files <<< "$selected"$'\0'

# normalize paths
for i in "${!files[@]}"; do
	files[i]=$(realpath "${files[i]}")
done

EDITOR_CMD="${EDITOR:-nvim}"

# open files in smart layout
case "${#files[@]}" in
2)
	"$EDITOR_CMD" -O +'silent! normal g;' "${files[@]}"
	;;
3)
	"$EDITOR_CMD" -O "${files[0]}" -c 'wincmd j' -c "silent! vsplit ${files[1]}" -c "silent! split ${files[2]}"
	;;
4)
	"$EDITOR_CMD" -O "${files[0]}" -c "silent! vsplit ${files[1]}" -c "silent! split ${files[2]}" -c 'wincmd h' -c "silent! split ${files[3]}"
	;;
*)
	"$EDITOR_CMD" "${files[@]}"
	;;
esac

