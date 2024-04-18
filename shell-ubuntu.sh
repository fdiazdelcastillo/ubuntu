UBUNTU_HOME=/home/ubuntu
UBUNTU_ZSH_CUSTOM=${UBUNTU_HOME}/.oh-my-zsh/custom

# Updating packages
apt update && apt -y full-upgrade && apt -y dist-upgrade && apt -y autoremove && apt -y autoclean

# Installing packages
for i in zsh neovim bat fzf fd-find exa git locales python3-dev python3-pip python3-setuptools; do apt install -y $i; done

# Configuring Unattended Upgrades
apt install -y unattended-upgrades
sed -i 's/\/\/Unattended-Upgrade::Automatic-Reboot "false";/Unattended-Upgrade::Automatic-Reboot "true";/' /etc/apt/apt.conf.d/50unattended-upgrades
systemctl restart unattended-upgrades.service

# Installing oh-my-zsh, plugins and prompt
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# ZSH Autosuggestions & Highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
echo 'ZSH_AUTOSUGGEST_STRATEGY=(history completion)' >>~/.zshrc
echo 'ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)' >>~/.zshrc

# ZSH Prompt
sh -c "$(curl -sS https://starship.rs/install.sh)" -y -f
echo 'eval "$(starship init zsh)"' >>~/.zshrc

# Locale
sed -i 's/# export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/' ~/.zshrc
echo 'export LC_ALL=en_US.UTF-8' >>~/.zshrc

# fzf
echo '[ -f  /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh' >>~/.zshrc
echo '[ -f  /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh' >>~/.zshrc

# fd
echo 'alias fd=fdfind' >>~/.zshrc

# bat
echo 'alias bat=batcat' >>~/.zshrc

# The Fuck
pip3 install thefuck --user
echo 'eval $(thefuck --alias)' >>~/.zshrc
sed -i 's/# export PATH=$HOME\/bin:\/usr\/local\/bin:$PATH/export PATH=$HOME\/bin:$HOME\/.local\/bin:\/usr\/local\/bin:$PATH/' ~/.zshrc

chsh -s /bin/zsh

# Installing oh-my-zsh, plugins and prompt on ubuntu
git clone https://github.com/robbyrussell/oh-my-zsh.git ${UBUNTU_HOME}/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ${UBUNTU_HOME}/.zshrc
chown ubuntu ${UBUNTU_HOME}/.oh-my-zsh ${UBUNTU_HOME}/.zshrc

# ZSH Autosuggestions & Highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${UBUNTU_ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${UBUNTU_ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ${UBUNTU_HOME}/.zshrc
echo 'ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)' >>${UBUNTU_HOME}/.zshrc
echo 'ZSH_AUTOSUGGEST_STRATEGY=(history completion)' >>${UBUNTU_HOME}/.zshrc

# ZSH Prompt
echo 'eval "$(starship init zsh)"' >>${UBUNTU_HOME}/.zshrc

# Locale
sed -i 's/# export LANG=en_US.UTF-8/export LANG=en_US.UTF-8/' ${UBUNTU_HOME}/.zshrc
echo 'export LC_ALL=en_US.UTF-8' >>${UBUNTU_HOME}/.zshrc

# fzf
echo '[ -f  /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh' >>${UBUNTU_HOME}/.zshrc
echo '[ -f  /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh' >>${UBUNTU_HOME}/.zshrc

# fd
echo 'alias fd=fdfind' >>${UBUNTU_HOME}/.zshrc

# bat
echo 'alias bat=batcat' >>${UBUNTU_HOME}/.zshrc

# Permissions
chown -R ubuntu:ubuntu ${UBUNTU_HOME}/.oh-my-zsh ${UBUNTU_HOME}/.zshrc

chsh -s /bin/zsh ubuntu
