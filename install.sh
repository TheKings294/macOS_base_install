#!/bin/bash

# -------------------------------------------------------
# macOS Development Environment Setup
# Installs common CLI tools and applications
# -------------------------------------------------------

echo "🔧 Starting macOS dev environment setup..."

# --- Xcode Command Line Tools ---
if ! xcode-select -p &>/dev/null; then
  echo "📦 Installing Xcode Command Line Tools..."
  xcode-select --install
else
  echo "✅ Xcode Command Line Tools already installed."
fi

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "📦 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Add brew to PATH
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "✅ Homebrew already installed."
fi

# --- Update & Upgrade Brew ---
echo "🔄 Updating Homebrew..."
brew update && brew upgrade

# --- Install CLI Tools ---
echo "📦 Installing CLI tools..."
brew install git \
             php \
             node \
             composer \
             bat \
             python \
             wget \
             curl \
             tree \
             htop \
             zsh-autosuggestions \
             zsh-syntax-highlighting \
             gcc \
             neofetch \
             nvim \
             vim \

if [ "$SHELL" != "$(which zsh)" ]; then
  echo "⚙️  Setting Zsh as default shell..."
  chsh -s "$(which zsh)"
else
  echo "✅ Zsh is already the default shell."
fi

# --- Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "✅ Oh My Zsh already installed."
fi

# Enable Zsh plugins
ZSHRC="$HOME/.zshrc"
if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
  echo "plugins+=(zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
  echo "✅ Added zsh plugins to .zshrc"
fi

# --- GUI Applications ---
echo "📦 Installing GUI apps..."
brew install --cask iterm2 \
                      visual-studio-code \
                      postman \
                      discord \
                      docker \
                      google-chrome \
                      firefox \
                      appcleaner \
                      mamp \
                      jetbrains-toolbox \

# --- Cleanup ---
echo "🧹 Cleaning up Homebrew..."
brew cleanup

echo "✅ Setup complete! Restart your terminal (iTerm2) to apply changes."

neofetch