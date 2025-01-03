# `show-jump.nvim`

This plugin provides a simple key binding to view the last commit (`git show <commit-hash>`) for the current line in a temporary buffer, whilst adding the navigation to the tag stack.

Heavily inspired by tpope's [Fugitive](https://github.com/tpope/vim-fugitive) `:G blame` -> `<CR>` functionality.

I basically wanted a way to provide the same functionality of quickly viewing the last commit whilst also providing a convenient way of navigating back to the user's previous location. I used the same approach as LSP [g]o to [d]efinition so that the navigation is added to the tag stack, allowing the user to jump back to their previous location with `<c-t>`.

## Usage

## Credits

tpope

