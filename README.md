# telescope-rg
(cheap fork from [`kelly-lin/telescope-rg`](https://github.com/kelly-lin/telescope-rg), just replaces `Ag` with `Rg`)

nvim-telescope extension providing ripgrep (Rg) functionality 
similar to that of fzf.vim.

## Use case

While the `live_grep` built in function in Telescope is handy for most cases,
it does not have the ability to filter through the search result files. When you
know the exact text that you want to search, it is useful to be able to filter
through only certain files that we care about e.g. "I need to search through all
my files for a certain text that I know, from these resulting files, I do not
want to see the results from my tests folder, or these following file patterns".

## Installation

Install this extension using your favourite package manager.

### Packer

`use({ "kelly-lin/telescope-rg", requires = { { "nvim-telescope/telescope.nvim" } } })`

Load the extension somewhere in your `init.vim`

`telescope.load_extension("rg")`

## Useage

`:Rg [PATTERN]`: executes rg asynchronously for `[PATTERN]` in the current vim
directory and populates a Telescope `file_picker` with the results which can
then be filtered using the standard file picker filters.

## Notes

This plugin will override the `Rg` command that [fzf.vim](https://github.com/junegunn/fzf.vim)
sets.
