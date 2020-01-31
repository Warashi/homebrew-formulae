cask 'emacs-inlinepatched' do
  name 'emacs-inlinepatched'
  version 'emacs-26.3-inlinepatched-8'
  homepage 'https://github.com/Warashi/emacs-inlinepatched'
  appcast 'https://github.com/Warashi/emacs-inlinepatched/releases.atom'

  conflicts_with(formula: 'emacs', cask: ['emacs', 'emacs-mac', 'emacs-mac-spacemacs-icon'])

  depends_on macos: :catalina

  url 'https://github.com/Warashi/emacs-inlinepatched/releases/download/v26.3-8/Emacs-26.3-macOS-latest.dmg'
  sha256 '9c42e2d653beb5d9c0d4cfbd4fabb693f209f7c444128371421c550c8210c611'

  app 'Emacs.app'
  binary "#{appdir}/Emacs.app/Contents/MacOS/Emacs.sh", target: 'emacs'
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin/ebrowse"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin/emacsclient"
  binary "#{appdir}/Emacs.app/Contents/MacOS/bin/etags"

  zap trash: [
               '~/Library/Caches/org.gnu.Emacs',
               '~/Library/Preferences/org.gnu.Emacs.plist',
               '~/Library/Saved Application State/org.gnu.Emacs.savedState',
             ]
end
