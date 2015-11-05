# dotfiles
A collection of my dotfiles

### zsh
To use the zsh dotfiles, you must first install zsh and [oh-my-zsh](http://ohmyz.sh/).
Be sure to copy both .zshrc and .oh-my-zsh/ to your home directory.

By default, zed.theme requires the following plugins not included with oh-my-zsh:

zsh-syntax-highlighting
```
git clone git://github.com/tarruda/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins
```

zsh-autosuggestions
```
git clone git://github.com/jimmijj/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins
```

These plugins are used to simulate [fish](http://fishshell.com)-like behavior.

You can disable these and drop the requirement by commenting out the following variables in .zshrc:

```
AUTOSUGGESTION="true"
ENHANCED_COMPLETION="true"
```

You should also remove ```zsh-syntax-highlighting zsh-autosuggestions``` from the plugin list.

### tmux
Uses screen-like binds and a nice looking theme.

### screen
More informative clean theme.
