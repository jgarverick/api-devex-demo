#!/bin/bash

echo '[INFO] Setting up zsh as default shell...'
echo 'export SHELL=`which zsh`' >> ~/.bashrc
echo '[ -z "$ZSH_VERSION" ] && exec "$SHELL" -l' >> ~/.bashrc

echo '[INFO] Setting up Powerlevel10k...'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo '[INFO] Setting up git aliases...'
git config --global alias.lol "log --oneline --graph --decorate --all"
# Prompt for name
echo "Please enter your name:"
read name

# Prompt for email
echo "Please enter your email:"
read email

# Set the values in git config
git config --global user.name "$name"
git config --global user.email "$email"

echo "Git config has been set with the following values:"
echo "Name: $(git config --global user.name)"
echo "Email: $(git config --global user.email)"

echo '[INFO] Setting up pre-commit...'
pre-commit install && pre-commit install-hooks

echo '[INFO] Copying p10k.zsh...'
cp ./.devcontainer/p10k.zsh /home/vscode/.p10k.zsh

echo '[INFO] Setting up oh-my-zsh...'
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

echo '[INFO] Setting up dotnet paths...'
echo 'export DOTNET_ROOT=$HOME/.dotnet' >> ~/.zshrc
echo 'export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools' >> ~/.zshrc

echo '[INFO] postCreateCommand.sh finished!'
