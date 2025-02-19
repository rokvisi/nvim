# Generic

- Configure a way to grep search like in VSCode.

- Use snacks picker for picking harpoon marks.

- Use a telescope script that just shows the files that git changed. This is pretty much always a perfect list of the files I’m working on.

```lua
function _G.git_diff(opts)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  list = vim.fn.systemlist('git diff --name-only main')

  pickers.new(opts, {
    prompt_title = "git diff",
    finder = finders.new_table { results = list },
    sorter = conf.generic_sorter(opts)
  }):find()
end
```

# Svelte specific

- Detect ambient types in svelte projects (For context: Infer load function type in +page.ts files.)
- Jump to / create +page.ts|+page.server.ts +server.ts files relative to current .svelte file and vice-versa.

# Known Issues

- using 'vim.cmd.Format' (provided by 'lsp-format' plugin) also writes the file.
- lsp-format doesn't format on first write (using 'vim.lsp.buf.format()' instead breaks folded regions :().
- folding actions (za, zM, zR) take a while to start working because 'ufo.nvim' uses 'lsp' as the primary provider.
