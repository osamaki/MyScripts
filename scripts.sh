prefix() {
	# >>> echo "message" | prefix "[hoge] "
	# [hoge] message

	local p="${1:-prefix}"
	local c="s/^/$p/"
	case $(uname) in
		Darwin) sed -l "$c";; # mac/bsd sed: -l buffers on line boundaries
		*)      sed -u "$c";; # unix/gnu sed: -u unbuffered (arbitrary) chunks of data
	esac
}


indent() {
	# >>> echo "message" | indent
	#     message
	# >>> echo "message" | indent 6
	#       message

	local n="${1:-4}"
	local p=""
	for i in `seq 1 $n`; do
		p="$p "
	done;

	local c="s/^/$p/"
	case $(uname) in
		Darwin) sed -l "$c";; # mac/bsd sed: -l buffers on line boundaries
		*)      sed -u "$c";; # unix/gnu sed: -u unbuffered (arbitrary) chunks of data
	esac
}


# fixme: read
confirm() {
	# >>> confirm "Please input yes!:"
	# >>> if [ $? -ne 0 ]; then
	# >>> 	exit 1
	# >>> fi

	local response
	# call with a prompt string or use a default
	read -r -p "${1:-Are you sure? [y/N]:} " response
	case $response in
		[yY][eE][sS]|[yY])
			return 0
			;;
		*)
			return 1
			;;
	esac
}


# fixme: read
ask() {
	# >>> v=$(ask "[input your name]> ")

    local response
    # call with a prompt string or use a default
    read -r -p "${1:->} " response
    echo $response
}


abort() {
	# >>> abort "error message"

	{ if [ "$#" -eq 0 ]; then cat -
		else echo "${txtred}${progname}: $*${txtreset}"
		fi
	} >&2
	exit 1
}


# hrizontal
hr() {
	printf '%*s\n' "${2:-$(tput cols)}" '' | tr ' ' "${1:--}"
}
