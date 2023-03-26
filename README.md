# telescope-ag

nvim-telescope extension to filter file results from grep-like programs
(grep/rg/ag). The workflow for searching and filtering files is similar to
[fzf.vim](https://github.com/junegunn/fzf.vim).

By default `ag` [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
will be used to execute the searches. This can be configured to run any program
which returns search results formatted similar to grep and friends, see
[configuration](#configuration).

## Use case

While the `live_grep` built in function in Telescope is handy for most cases,
it does not have the ability to filter through the search result files. When you
know the exact text that you want to search, it is useful to be able to filter
through only certain files that we care about e.g. "I need to search through all
my files for a certain text that I know, from these resulting files, I do not
want to see the results from my tests folder, or these following file patterns".

## Installation

Install this extension using your favourite package manager.

### Dependencies

* [Telescope](https://github.com/nvim-telescope/telescope.nvim)
* [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)

Lazy

```lua
{
    "kelly-lin/telescope-ag",
    dependencies = { "nvim-telescope/telescope.nvim" },
    end,
}
```

Packer

```lua
use({
    "kelly-lin/telescope-ag",
    requires = { "nvim-telescope/telescope.nvim" },
    end,
})(
```

Load the extension somewhere in your `init.vim`

`telescope.load_extension("ag")`

### Configuration

#### Search Command

To change the command used to execute the search, invoke `telescope_ag.setup`
with a table with a `cmd` key which is a `table` of command line arguments as
strings. You can use built-in searcher commands defined in `telescope_ag.cmds`
or write your own custom command.

##### Built-in

```lua
{
    config = function()
        local telescope_ag = require("telescope-ag")
        telescope_ag.setup({
            cmd = telescope_ag.cmds.rg, -- defaults to telescope_ag.cmds.ag
        })
    end
}
```

##### Custom

```lua
{
    config = function()
        local telescope_ag = require("telescope-ag")
        telescope_ag.setup({
            cmd = { "grep", "-rn" }
        })
    end
}
```

## Usage

`:Ag [PATTERN]`: executes ag asynchronously for `[PATTERN]` in the current vim
directory and populates a Telescope `file_picker` with the results which can
then be filtered using the standard file picker filters.

## Notes

This plugin will override the `Ag` command that [fzf.vim](https://github.com/junegunn/fzf.vim)
sets.
