local function exclude(srcTable, items)
    return vim.iter(srcTable):filter(function(s)
        for _, item in pairs(items) do
            if s == item then
                return false
            end
        end

        return true
    end):totable()
end

local function log(msg)
    local f = io.open(vim.fn.stdpath("config") .. "\\log.txt", "w")
    if (f == nil) then return end

    f:write(msg)
    f:close()
end

local function log_table(tbl)
    log(vim.inspect(tbl))
end

local function is_cursor_in_rect(y1, x1, y2, x2)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]

    return row >= y1 and row <= y2 and col >= x1 and col <= x2
end

local function get_node_at_cursor_parser()
    local root_node = vim.treesitter.get_parser(0, "typescript"):parse()[1]:root();

    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]

    -- return root_node
    return root_node, root_node:descendant_for_range(row, col, row, col)
end

local function get_node_at_cursor_auto()
    -- Returns smallest NAMED node. Defaults to cursor position.
    return vim.treesitter.get_node({ lang = "typescript" })
end

local function get_node_type()
    local cursor_node = vim.treesitter.get_node({ lang = "svelte", ignore_injections = false })

    -- TODO: Get the nodes up to a opts.depth with pcall to prevent errors.
    local print_str = ''
        .. "ROOT: " .. cursor_node:root():type() .. '\n'
        .. '\nPARENT+: ' .. cursor_node:parent():parent():type()
        .. '\nPARENT : ' .. cursor_node:parent():type()
        .. "\nNODE   : " .. cursor_node:type()

    Snacks.notifier.hide()
    vim.notify(print_str, nil, { title = 'Nodes at cursor', timeout = 0 })
end


local function test()
    local success, node = pcall(vim.treesitter.get_node)
    if not success or not node then return all_sources end

    local LANGUAGE = 'typescript'
    local bufnr = vim.fn.bufnr()
    local root_node = vim.treesitter.get_parser(bufnr, LANGUAGE):parse()[1]:root()

    local query = vim.treesitter.query.parse(LANGUAGE, [[
        (import_statement
            source: (string
                (string_fragment) @import_string))
    ]])

    for id, node, metadata, match in query:iter_captures(root_node, bufnr) do
        local name = query.captures[id]                             -- "import_string"\
        local type = node:type()                                    -- "string"
        local start_row, start_col, end_row, end_col = node:range() -- range of the capture
        local text = vim.treesitter.get_node_text(node, bufnr)      -- 'lucide-svelte'
        local is_cursor_in = is_cursor_in_rect(start_row, start_col, end_row, end_col)
        local is_cursor_in_str = is_cursor_in and 'inside' or "outside"

        local result = text .. ' | ' .. is_cursor_in_str .. " |\n" .. name .. '\n' .. type

        vim.notify(result)
    end
end

vim.keymap.set('n', '<leader>tt', get_node_type, {
    noremap = true,
    silent = true,
    desc = "[t]est get node [t]ype at cursor"
})
vim.keymap.set('n', '<leader>th', Snacks.notifier.hide, {
    noremap = true,
    silent = true,
    desc = "[t]est [h]ide all notifications"
})
vim.keymap.set('n', '<leader>ti', function()
    vim.treesitter.inspect_tree({ command = "new" })
end, {
    noremap = true,
    silent = true,
    desc = "[t]est [i]nspect tree"
})
