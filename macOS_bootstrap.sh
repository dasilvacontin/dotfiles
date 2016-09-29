# dock stuff
defaults write com.apple.dock autohide -boolean YES
defaults write com.apple.dock autohide-time-modifier -float 0.5
defaults write com.apple.dock orientation right
killall Dock

# agree to the Xcode License
echo '> Incoming password prompt for agreeing to the Xcode License:'
sudo xcodebuild -license
sudo xcode-select --install

# get brew
brew -v || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle

# run Brewfile
cd "$(dirname "$0")"
brew bundle

# install TPM (tmux plugin manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install zgen (plugin manager for zsh)
git clone https://github.com/tarjoilija/zgen.git ~/github/tarjoilija/zgen

# set zsh as default shell
chsh -s /bin/zsh

# install notify script from gist
echo "Installing 'notify' script.."
sudo sh -c "curl https://gist.githubusercontent.com/WengerK/ad0c1330966522c05f504d71d29f675b/raw/34e6e53eb2f5c2039f604c10d3bf272b251b31a5/notify.sh -o /usr/local/bin/notify && chmod +x /usr/local/bin/notify"

# install fzf shell extensions
/usr/local/opt/fzf/install

# install some node packages
npm i -g contrib-rocket
