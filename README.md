<p align="center">
  <img width="256" src="http://icons.iconarchive.com/icons/sicons/basic-round-social/512/slashdot-icon.png">
</p>

# dotfiles

Welcome to my _lousy_ dotfiles!

The pejorative adjective takes away all the guilt regarding typos, illogical lines of code or assumptions that my dotfiles might make. Feel free to use and improve.

Please, point your finger at _any lousy stuff_ that you spot out, you'll make my day better - sharing is caring!

> (oh, and if you explain the _why_, I have some kudos to give out)

## Usage / Install / whatnot

```bash
cd somewhere-you-keep-gh-repos
git clone https://github.com/dasilvacontin/dotfiles
ln -s $PWD/dotfiles/.*[^git] ~
```

You probably don't want my `.gitconfig` file nor the `.git` folder. That's [why](exclude-pattern-glob-match) the `[^git]` is there.

Check the linked files:

```bash
$> ls -la ~ | grep '^l'
lrwxr-xr-x     1 dasilvacontin  staff      61 Sep 22 20:18 .tmux.conf -> /Users/dasilvacontin/GitHub/dasilvacontin/dotfiles/.tmux.conf
lrwxr-xr-x     1 dasilvacontin  staff      57 Sep 22 20:18 .vimrc -> /Users/dasilvacontin/GitHub/dasilvacontin/dotfiles/.vimrc
lrwxr-xr-x     1 dasilvacontin  staff      57 Sep 22 20:18 .zshrc -> /Users/dasilvacontin/GitHub/dasilvacontin/dotfiles/.zshrc
```

Also, the `ln` command there is non-destructive, so chill:

```bash
$> ln -s $PWD/dotfiles/.*[^git] ~
ln: /Users/dasilvacontin/.tmux.conf: File exists
ln: /Users/dasilvacontin/.vimrc: File exists
ln: /Users/dasilvacontin/.zshrc: File exists
```

## License

MIT © [David da Silva](http://dasilvacont.in)

[exclude-pattern-glob-match]: http://unix.stackexchange.com/questions/164025/exclude-one-pattern-from-glob-match
