class EmacsImepatched < Formula
  desc "takaxp's patch is applied emacs"
  homepage "https://www.gnu.org/software/emacs/"
  url "https://alpha.gnu.org/gnu/emacs/pretest/emacs-26.2-rc1.tar.gz"
  version "26.2-rc1-1"
  sha256 "e37e8fe554f1c8243ec2ccf58ed0b71e7dca6b11e6c4e4778d30f7591ffaf918"

  depends_on "autoconf" => :build
  depends_on "gnu-sed" => :build
  depends_on "texinfo" => :build
  depends_on "pkg-config" => :build
  depends_on "gnutls"

  patch do
    url "https://gist.githubusercontent.com/takaxp/3314a153f6d02d82ef1833638d338ecf/raw/156aaa50dc028ebb731521abaf423e751fd080de/emacs-25.2-inline.patch"
    sha256 "9b1b9734f701901a4ffbaae319b107591fae6081a3ef1a7488cb67e529ff0957"
  end
  
  def install
    args = %W[
      --disable-dependency-tracking
      --disable-silent-rules
      --enable-locallisppath=#{HOMEBREW_PREFIX}/share/emacs/site-lisp
      --infodir=#{info}/emacs
      --prefix=#{prefix}
      --with-gnutls
      --without-x
      --with-xml2
      --without-dbus
      --with-modules
      --with-ns
      --disable-ns-self-contained
      --without-imagemagick
    ]

    ENV.prepend_path "PATH", Formula["gnu-sed"].opt_libexec/"gnubin"
    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"

    prefix.install "nextstep/Emacs.app"

    # Follow MacPorts and don't install ctags from Emacs. This allows Vim
    # and Emacs and ctags to play together without violence.
    (bin/"ctags").unlink
    (man1/"ctags.1.gz").unlink
  end

  plist_options :manual => "emacs"

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>KeepAlive</key>
      <true/>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/emacs</string>
        <string>--fg-daemon</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
  EOS
  end

  def caveats; <<~EOS
      This is takaxp's patch applied GNU Emacs 26.
      Emacs.app was installed to:
        #{prefix}
      To link the application to default Homebrew App location:
        ln -s #{prefix}/Emacs.app /Applications
  EOS
  end

  test do
    assert_equal "4", shell_output("#{bin}/emacs --batch --eval=\"(print (+ 2 2))\"").strip
  end
end
