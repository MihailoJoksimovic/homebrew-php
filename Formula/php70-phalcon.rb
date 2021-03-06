require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php70Phalcon < AbstractPhp70Extension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalconphp.com/"
  url "https://github.com/phalcon/cphalcon/archive/v3.1.1.tar.gz"
  sha256 "430359e0103ac926861976815d5f1d1373c6b1d7317e128359409aafd4285f84"
  head "https://github.com/phalcon/cphalcon.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "882a89ec70addb2e450b3cab36c4b7af0e416c0a157538826580a6807da81bc8" => :sierra
    sha256 "d4f252daf14a0b88497f6b6b0e80fdf2df0873dbb773d4d138ed13799208cc10" => :el_capitan
    sha256 "0063758ab0936ecf8098cd37a37cf53ed10ed25b268db049c1385a9a28469511" => :yosemite
  end

  depends_on "pcre"

  def install
    if MacOS.prefer_64_bit?
      Dir.chdir "build/php7/64bits"
    else
      Dir.chdir "build/php7/32bits"
    end

    ENV.universal_binary if build.universal?

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file if build.with? "config-file"
  end
end
