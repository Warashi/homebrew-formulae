cask 'emacs-inlinepatched' do
  name 'emacs-inlinepatched'
  version 'emacs-26.3-inlinepatched-5'
  homepage 'https://github.com/Warashi/emacs-inlinepatched'
  appcast 'https://github.com/Warashi/emacs-inlinepatched/releases.atom'

  conflicts_with(formula: 'emacs', cask: ['emacs', 'emacs-mac', 'emacs-mac-spacemacs-icon'])

  if MacOS.version != :mojave
    raise Exception.new('this cask provided only for mojave')
  end
  url 'https://github.com/Warashi/emacs-inlinepatched/releases/download/v26.3-5/Emacs-26.3-macOS-10.14.dmg'
  sha256 'cafdf276714b582b283c8a09dec9738d03c091277f8e9445705aa46ee59633eb'

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
