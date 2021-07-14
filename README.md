# dotfiles

A collection of my dotfiles for both servers and clients.

### zsh

To use the zsh dotfiles, you must first install [zsh](http://www.zsh.org/) and [oh-my-zsh](http://ohmyz.sh/).

Copy zsh files to your home directory:

```
cp -R .zshrc ~
cp -R .oh-my-zsh ~
```

This `~/.zshrc` requires the following theme and plugins, which are not included with oh-my-zsh:

#### Theme

##### powerlevel10k

[more info](https://github.com/romkatv/powerlevel10k)

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### Plugins

###### history-search-multi-word

[more info](https://github.com/zdharma/history-search-multi-word)

```
git clone git://github.com/zdharma/history-search-multi-word.git ~/.oh-my-zsh/custom/plugins/history-search-multi-word
```

###### zsh-syntax-highlighting

[more info](https://github.com/zsh-users/zsh-syntax-highlighting)

```
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 
```

###### zsh-autosuggestions


[more info](https://github.com/zsh-users/zsh-autosuggestions)

```
git clone git://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
```

###### Enabling/Disabling zsh plugins

These plugins are used to bring [fish](http://fishshell.com)-like behavior to zsh.

If you don't like this behavior, these can be disabled in `.zshrc` by commenting out the following:

```
AUTOSUGGESTION="true"
ENHANCED_COMPLETION="true"
```

You should also remove `zsh-syntax-highlighting zsh-autosuggestions` from the plugin list if you decide to go this route.

### tmux

Uses screen-like binds and a nice looking theme.

```
cp -R .tmux* ~
```

### screen

More informative clean theme.

```
cp -R .screenrc ~
```

### vim

Requires [vundle](https://github.com/VundleVim/Vundle.vim) for plugins (NERDtree, tabman).

```
cp -R .vim* ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

### License

MIT

