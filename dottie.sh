# Keep track if any processes fail
__dottie_error=

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Formats a path with the tilde for the home dir
function format_path {
	echo "${1/$HOME/~}"
}

# Cleans up an old file or symlink
function clean {
	if [[ -f "$1" ]]; then
		rm "$1"
		echo -e "${YELLOW}Cleaning $(format_path "$1")${NC}"
	else
		echo -e "${BLUE}File already cleaned $(format_path "$1")${NC}"
	fi
}

# Symlinks a file or directory
function link {
	local src=$(pwd)/$1
	local dest="$2"
	local formatted_dest="${dest/$HOME/~}"

	# If the file already exists and is a symlink to the correct source location,
	# skip linking.
	if [[ $(readlink -f "$dest") == "$src" ]]; then
		echo -e "${BLUE}Link exists $1 -> $formatted_dest${NC}"
		return
	fi

	# If the file already exists and is a regular file, mark as an error
	if [[ -e "$dest" ]]; then
		echo -e "${RED}$formatted_dest already exists but is a regular file or directory${NC}"
		__dottie_error="y"
		return
	fi

	# All good, create the link and any parent directories if necessary
	echo -e "${GREEN}Creating link $1 -> $formatted_dest${NC}"
	mkdir -p $(dirname "$dest")
	ln -s "$src" "$dest"
}

# Links the contents of a directory and it's subdirectories. This is primarily
# needed for tools such as Fish where the entire directory can't be linked due
# to auto-generated files or other files that cannot be committed to VCS.
function link_contents {
	for file in $(find "$1" -name "*" ! -name '.DS_Store' -type f); do
		link $file "$2${file/$1\//}"
	done
}

# If any of the links failed, log a final message indicating something went
# wrong. This helps when the install log gets long.
function finalize {
	if [[ -n $__dottie_error ]]; then
		echo ""
		echo -e "${RED}Some tasks were not successful!${NC}"
		exit 1
	else
		echo ""
		echo -e "${GREEN}All task successfully finished!${NC}"
	fi
}
