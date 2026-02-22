mv ~/.config/i3/config ~/.config/i3/config_backup
ln -s ~/dotfiles/i3_config ~/.config/i3/config

mv ~/.config/i3/i3blocks.conf ~/.config/i3/i3blocks.conf_backup
ln -s ~/dotfiles/i3blocks.conf ~/.config/i3/i3blocks.conf

mkdir ~/.config/nvim
ln -s ~/dotfiles/init.lua ~/.config/nvim/init.lua

mv ~/.config/fish/config.fish ~/.config/fish/config.fish_backup
ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/ghostty
mv ~/.config/ghostty/config ~/.config/ghostty/config_backup 2>/dev/null
mv ~/.config/ghostty/tab-style.css ~/.config/ghostty/tab-style.css_backup 2>/dev/null
ln -s ~/dotfiles/ghostty_config ~/.config/ghostty/config
ln -s ~/dotfiles/ghostty_tab-style.css ~/.config/ghostty/tab-style.css

mv ~/.tmux.conf ~/.tmux.conf_backup 2>/dev/null
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
