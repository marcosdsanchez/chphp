# chphp

[![Build Status](https://travis-ci.org/marcosdsanchez/chphp.png)](https://travis-ci.org/marcosdsanchez/chphp)

Changes the current PHP.

## Features

* Updates `$PATH`.
* Additionally sets `$PHP_ROOT`, `$PHP_ENGINE`, `$PHP_VERSION`
* Optionally sets `$PHPOPT` if second argument is given.
* Calls `hash -r` to clear the command-lookup hash-table.
* Defaults to the system PHP.
* Optionally supports auto-switching and the `.php-version` file.
* Supports [bash] and [zsh].
* Small (~90 LOC).
* Has tests.

## Anti-Features

* Does not hook `cd`.
* Does not install executable shims.
* Does not require PHP versions be installed into your home directory.
* Does not automatically switch PHP by default.

## Install

    wget -O chphp-0.0.1.tar.gz https://github.com/marcosdsanchez/chphp/archive/v0.0.1.tar.gz
    tar -xzvf chphp-0.0.1.tar.gz
    cd chphp-0.0.1/
    sudo make install

### setup.sh

chphp also includes a `setup.sh` script, which installs chphp and the latest
releases of [PHP]. Simply run the script as root or
via `sudo`:

    sudo ./scripts/setup.sh

#### php-install

You can also use [php-install] to install additional Rubies:

Installing to `/opt/php_versions` or `~/.php_versions`:

    php-install php
    php-install php 5.4
    php-install php 5.5
    php-install php 5.3.19

## Configuration

Add the following to the `/etc/profile.d/chphp.sh`, `~/.bashrc` or
`~/.zshrc` file:

    source /usr/local/share/chphp/chphp.sh

By default chphp will search for php versions installed into `/opt/php_versions/` or
`~/.php_versions/`. For non-standard installation locations, simply set the
`PHP_VERSIONS` variable after loading `chphp.sh`:

    PHP_VERSIONS=(
      /opt/php-5.5.0
      $HOME/src/php-5.3.27
    )

### System Wide

If you wish to enable chphp system-wide, add the following to
`/etc/profile.d/chphp.sh`:

    [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return

    source /usr/local/share/chphp/chphp.sh

### Auto-Switching

If you want chphp to auto-switch the current version of PHP when you `cd`
between your different projects, simply load `auto.sh` in `~/.bashrc` or
`~/.zshrc`:

    source /usr/local/share/chphp/auto.sh

chphp will check the current and parent directories for a [.php-version]
file.

### Default PHP

If you wish to set a default PHP, simply call `chphp` in `~/.bash_profile` or
`~/.zprofile`:

    chphp php-5.3

If you have enabled auto-switching, simply create a `.php-version` file:

    echo "php-5.3" > ~/.php-version

## Examples

List available PHP versions:

    $ chphp
       php-5.3.0
       php-5.5.5

Select a PHP version:

    $ chphp 5.3.5
    $ chphp
     * php-5.3.5
       php-5.5.5
       php-5.3.0

Switch back to system PHP:

    $ chphp system
    $ echo $PATH
    /usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/marcos/bin

Switch to an arbitrary PHP on the fly:

    $ chphp_use /path/to/php

## Uninstall

After removing the chphp configuration:

    $ sudo make uninstall
