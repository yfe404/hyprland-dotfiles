#!/bin/bash
#
# Hyprland Dotfiles Installation Script
# Creates symlinks from this repo to ~/.config
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BIN_DIR="$HOME/.local/bin"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Configs to symlink (source -> destination)
declare -A CONFIGS=(
    ["hypr"]="$CONFIG_DIR/hypr"
    ["kitty"]="$CONFIG_DIR/kitty"
    ["nvim"]="$CONFIG_DIR/nvim"
    ["waybar"]="$CONFIG_DIR/waybar"
    ["wofi"]="$CONFIG_DIR/wofi"
    ["zsh/.zshrc"]="$HOME/.zshrc"
    ["hyprmocha"]="$CONFIG_DIR/hyprmocha"
)

backup_if_exists() {
    local target="$1"
    if [[ -e "$target" && ! -L "$target" ]]; then
        local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
        warn "Backing up existing $target to $backup"
        mv "$target" "$backup"
    elif [[ -L "$target" ]]; then
        rm "$target"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"

    if [[ ! -e "$source" ]]; then
        error "Source does not exist: $source"
        return 1
    fi

    backup_if_exists "$target"

    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"

    ln -sf "$source" "$target"
    success "Linked $target -> $source"
}

install_bin_scripts() {
    info "Installing bin scripts to $BIN_DIR..."
    mkdir -p "$BIN_DIR"

    for script in "$DOTFILES_DIR/bin/"*; do
        if [[ -f "$script" ]]; then
            local name=$(basename "$script")
            backup_if_exists "$BIN_DIR/$name"
            ln -sf "$script" "$BIN_DIR/$name"
            chmod +x "$script"
            success "Linked $BIN_DIR/$name"
        fi
    done
}

create_background_dir() {
    local bg_dir="$CONFIG_DIR/backgrounds"
    if [[ ! -d "$bg_dir" ]]; then
        mkdir -p "$bg_dir"
        info "Created $bg_dir - add your wallpaper as 'shaded.png'"
    fi
}

check_dependencies() {
    info "Checking dependencies..."

    local required=(hyprland waybar kitty wofi swaync hypridle hyprlock hyprpaper)
    local optional=(yazi fzf playerctl brightnessctl power-profiles-daemon mpd)
    local missing_required=()
    local missing_optional=()

    for cmd in "${required[@]}"; do
        if ! command -v "$cmd" &>/dev/null; then
            missing_required+=("$cmd")
        fi
    done

    for cmd in "${optional[@]}"; do
        if ! command -v "$cmd" &>/dev/null; then
            missing_optional+=("$cmd")
        fi
    done

    if [[ ${#missing_required[@]} -gt 0 ]]; then
        warn "Missing required: ${missing_required[*]}"
    else
        success "All required dependencies found"
    fi

    if [[ ${#missing_optional[@]} -gt 0 ]]; then
        info "Missing optional: ${missing_optional[*]}"
    fi
}

print_post_install() {
    echo
    echo -e "${GREEN}=== Installation Complete ===${NC}"
    echo
    echo "Next steps:"
    echo "  1. Add a wallpaper to ~/.config/backgrounds/shaded.png"
    echo "  2. Add an avatar image to ~/.face (optional, for lock screen)"
    echo "  3. Install required fonts: JetBrainsMono Nerd Font, Caskaydia Cove Nerd Font"
    echo "  4. Log out and select Hyprland from your display manager"
    echo
    echo "For transmission scripts (tadd, tdel, tlist), set these env vars:"
    echo "  export TRANSMISSION_HOST='your-server:9091'"
    echo "  export TRANSMISSION_USER='your-username'"
    echo "  export TRANSMISSION_PASS_PATH='path/in/pass/store'"
    echo
}

main() {
    echo -e "${BLUE}=== Hyprland Dotfiles Installer ===${NC}"
    echo

    check_dependencies
    echo

    info "Installing config symlinks..."
    for source in "${!CONFIGS[@]}"; do
        create_symlink "$DOTFILES_DIR/$source" "${CONFIGS[$source]}"
    done
    echo

    install_bin_scripts
    echo

    create_background_dir

    print_post_install
}

# Run with --check to only check dependencies
if [[ "$1" == "--check" ]]; then
    check_dependencies
    exit 0
fi

main
