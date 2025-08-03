#!/bin/ash

# Colors for output
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
RESET="\033[0m"

# Function to print messages with colors
log_success() {
    echo -e "${GREEN}[SUCCESS] $1${RESET}"
}

log_warning() {
    echo -e "${YELLOW}[WARNING] $1${RESET}"
}

log_error() {
    echo -e "${RED}[ERROR] $1${RESET}"
}

# Clean up temp directory
echo "⏳ Cleaning up temporary files..."
if rm -rf /home/container/tmp/*; then
    log_success "Temporary files removed successfully."
else
    log_error "Failed to remove temporary files."
    exit 1
fi

# Start PHP-FPM
echo "⏳ Starting PHP-FPM..."
if /usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize; then
    log_success "PHP-FPM started successfully."
else
    log_error "Failed to start PHP-FPM."
    exit 1
fi

# NGINX if else WIP
echo "⏳ Starting Nginx..."
# Final message
log_success "Web server is running. All services started successfully."

clear

BOLD=$(tput bold)
RESET_FMT=$(tput sgr0)
LINE_COLOR="${BLUE}"
TEXT_COLOR="${WHITE}"
WARN_COLOR="${YELLOW}"
LINK_COLOR="${GREY}"
TITLE_COLOR="${BLUE}"

TITLE="DuckCDN"
WELCOME="Welcome! Thank you for choosing us."
MESSAGE="Your CDN has been launched successfully!"
WARNING="Don't forget to look into webroot/config.php"
FOOTER="GitHub - https://github.com/freeutka/DuckCDN"
SIGMA="Powered by https://github.com/Sigma-Production/ptero-eggs"

WIDTH=60

print_line() {
    printf "${LINE_COLOR}+"
    i=0
    while [ "$i" -lt "$WIDTH" ]; do
        printf "-"
        i=$((i + 1))
    done
    printf "+\n"
}

print_centered() {
    local text="$1"
    local color="$2"
    local length=${#text}
    local padding=$(( (WIDTH - length) / 2 ))
    printf "${LINE_COLOR}|"
    printf "%*s" $padding ""
    printf "${color}${BOLD}%s${RESET_FMT}" "$text"
    printf "%*s" $((WIDTH - padding - length)) ""
    printf "${LINE_COLOR}|\n"
}

print_empty() {
    printf "${LINE_COLOR}|%*s|\n" $WIDTH ""
}

# Draw box
print_line
print_empty
print_centered "$TITLE" "$TITLE_COLOR"
print_empty
print_centered "$WELCOME" "$TEXT_COLOR"
print_centered "$MESSAGE" "$TEXT_COLOR"
print_centered "$WARNING" "$WARN_COLOR"
print_empty
print_centered "$FOOTER" "$LINK_COLOR"
print_centered "$SIGMA" "$LINK_COLOR"
print_empty
print_line
echo

/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/

# Keep the container running (optional, depending on your container setup)
tail -f /dev/null
