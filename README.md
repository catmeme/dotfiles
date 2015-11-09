# dotfiles
A collection of my dotfiles for both servers and clients.

### zsh
To use the zsh dotfiles, you must first install [zsh](http://www.zsh.org/) and [oh-my-zsh](http://ohmyz.sh/).
Be sure to copy both `.zshrc` and `.oh-my-zsh/` to your home directory.

By default, `zed.zsh-theme` requires the following plugins, which are not included with oh-my-zsh:

###### zsh-syntax-highlighting
```
git clone git://github.com/tarruda/zsh-syntax-highlightin ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 
```

###### zsh-autosuggestions
```
git clone git://github.com/jimmijj/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
```

These plugins are used to simulate [fish](http://fishshell.com)-like behavior.

Alternatively, these can be disabled in `.zshrc` by commenting out the following:

```
AUTOSUGGESTION="true"
ENHANCED_COMPLETION="true"
```

You should also remove `zsh-syntax-highlighting zsh-autosuggestions` from the plugin list if you decide to go this route.

### tmux
Uses screen-like binds and a nice looking theme.

### screen
More informative clean theme.
