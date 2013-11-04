require 'formula'
class Chphp < Formula
  homepage 'https://github.com/marcosdsanchez/chphp#readme'
  url 'https://github.com/marcosdsanchez/chphp/archive/v0.0.1.tar.gz'
  sha1 '56c19d339cec860c8adc908e50c3e5da89143007'

  head 'https://github.com/marcosdsanchez/chphp.git'

  def install
    system 'make', 'install', "PREFIX=#{prefix}"
  end

  def caveats; <<-EOS.undent
    Add the following to the ~/.bashrc or ~/.zshrc file:

      source #{opt_prefix}/share/chphp/chphp.sh

    By default chphp will search for Rubies installed into /opt/rubies/ or
    ~/.rubies/. For non-standard installation locations, simply set the RUBIES
    variable after loading chphp.sh:

      PHP_VERSIONS=(
        /opt/php-5.3.5
      )

    To enable auto-switching of Php versions specified by .php-version files,
    add the following to ~/.bashrc or ~/.zshrc:

      source #{opt_prefix}/share/chphp/auto.sh
    EOS
  end
end
