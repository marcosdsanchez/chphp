#!/usr/bin/env bash
#
# chphp script that installs php-install which then installs the latest
# stable versions of PHP into /opt/php_versions or ~/.php_versions
#

set -e

#
# Constants
#
export PREFIX="${PREFIX:-/usr/local}"

if (( $UID == 0 )); then SRC_DIR="${SRC_DIR:-/usr/local/src}"
else                     SRC_DIR="${SRC_DIR:-$HOME/src}"
fi

#
# Functions
#
function log() {
	if [[ -t 1 ]]; then
		printf "%b>>>%b %b%s%b\n" "\x1b[1m\x1b[32m" "\x1b[0m" \
		                          "\x1b[1m\x1b[37m" "$1" "\x1b[0m"
	else
		printf ">>> %s\n" "$1"
	fi
}

function error() {
	if [[ -t 1 ]]; then
		printf "%b!!!%b %b%s%b\n" "\x1b[1m\x1b[31m" "\x1b[0m" \
		                          "\x1b[1m\x1b[37m" "$1" "\x1b[0m" >&2
	else
		printf "!!! %s\n" "$1" >&2
	fi
}

function warning() {
	if [[ -t 1 ]]; then
		printf "%b***%b %b%s%b\n" "\x1b[1m\x1b[33m" "\x1b[0m" \
			                  "\x1b[1m\x1b[37m" "$1" "\x1b[0m" >&2
	else
		printf "*** %s\n" "$1" >&2
	fi
}

#
# Install chphp
#
log "Installing chphp ..."
make install

#
# Pre Install
#
install -d "$SRC_DIR"
cd "$SRC_DIR"

#
# Install php-install (https://github.com/marcosdsanchez/php-install#readme)
#
php_install_version="0.0.1"

log "Downloading php-install ..."
wget -O "php-install-$php_install_version.tar.gz" "https://github.com/marcosdsanchez/php-install/archive/v$php_install_version.tar.gz"

log "Extracting php-install $php_install_version ..."
tar -xzf "php-install-$php_install_version.tar.gz"
cd "php-install-$php_install_version/"

log "Installing php-install and different versions of php"
./setup.sh

#
# Configuration
#
log "Configuring chphp ..."

config="[ -n \"\$BASH_VERSION\" ] || [ -n \"\$ZSH_VERSION\" ] || return

source $PREFIX/share/chphp/chphp.sh"

if [[ -d /etc/profile.d/ ]]; then
	# Bash/Zsh
	echo "$config" > /etc/profile.d/chphp.sh
	log "Setup complete! Please restart the shell"
else
	warning "Could not determine where to add chphp configuration."
	warning "Please add the following configuration where appropriate:"
	echo
	echo "$config"
	echo
fi
