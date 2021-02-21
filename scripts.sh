hr() {
    printf '%*s\n' "${2:-$(tput cols)}" '' | tr ' ' "${1:--}"
}
