# Tests

Run the tests from the repository root. They use the plugin's existing
dependency, [vim-misc](https://github.com/xolox/vim-misc). Set `VIM_MISC_PATH`
to its local checkout:

```sh
export VIM_MISC_PATH=/path/to/vim-misc
vim -Nu NONE -i NONE -n -es -V1 -S test/title-highlight.vim
nvim --headless -u NONE -i NONE -n -V1 -S test/title-highlight.vim
```

Run either command with the editor you have installed, or both to check both
editors. If `vim` points to Neovim on your system, use the actual Vim executable
(for example, `vim.basic` on Debian) for the first command.

`title-highlight.vim` checks that both `Projet` and `Projet étude SQL` are
highlighted through their last character, with and without enough titles to
trigger prefix factoring. It tests all three `regexpengine` settings and
checks that vim-notes leaves the global setting unchanged. It does not write
any note files. A failed assertion exits with a nonzero status.
