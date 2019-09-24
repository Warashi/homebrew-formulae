cask 'emacs-inlinepatched' do
  name 'emacs-inlinepatched'
  version 'emacs-26.3-inlinepatched'
  homepage 'https://github.com/Warashi/emacs-inlinepatched'
  appcast 'https://github.com/Warashi/emacs-inlinepatched/releases.atom'

  conflicts_with(formula: 'emacs', cask: ['emacs', 'emacs-mac', 'emacs-mac-spacemacs-icon'])

  if MacOS.version != :mojave
    raise Exception.new('this cask provided only for mojave')
  end
  url 'https://github.com/Warashi/emacs-inlinepatched/releases/download/v26.3-2/Emacs-26.3-macos-10.14.dmg'
  sha256 '661b0e4849b90008fd413b4b11b5c20fca4a8ece220c0eecd8a2bf769057ab7b'

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
