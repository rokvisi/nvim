--- Convienience function to convert a message (table or string) to a string.
--- @param msg string | table
--- @return string
local function tostr(msg)
    -- Using 'vim.inspect(string)' breaks special characters. So only use it for tables.
    if (type(msg) == 'table') then
        msg = vim.inspect(msg)
    end

    return msg
end

--- @class log_OPTS
--- @field level? number The log level. Default = nil
--- @field title? string The log title. Default = nil
--- @field timeout? number How long the message stays on screen. Default = nil

--- Logs a message or table to vim.notify.
--- @param msg string | table
--- @param opts? log_OPTS
local function log(msg, opts)
    opts = opts or {}
    msg = tostr(msg)

    vim.notify(msg, opts.level, opts)
end

--- @class flog_OPTS
--- @field dest? string The log file directory. Default = 'vim.fn.stdpath("config")'
--- @field filename? string The log file filename. Default = 'log.txt'
--- @field mode? string The write mode. Default = 'a'

--- Logs a message or table to a file.
--- @param msg string | table
--- @param opts? flog_OPTS
local function flog(msg, opts)
    opts = opts or {}
    opts.dest = opts.dest or vim.fn.stdpath("config")
    opts.mode = opts.mode or "a"
    opts.filename = opts.filename or "log.txt"

    msg = tostr(msg)

    local full_path = opts.dest .. "/" .. opts.filename
    local log_file = io.open(full_path, opts.mode)

    if (log_file == nil) then
        local err_msg = ""
            .. "Can't open log file:"
            .. '\n"' .. full_path .. '"'
            .. '\nmode: "' .. opts.mode .. '"'

        log(err_msg, { title = "Failed to log", level = vim.log.levels.ERROR, timeout = 5000 })
        return
    end

    log_file:write(msg)
    log_file:close()
end

--- Checks if the current cursor position is inside a rectangle.
--- @param y1 number
--- @param x1 number
--- @param y2 number
--- @param x2 number
--- @return boolean
local function is_cursor_in_rect(y1, x1, y2, x2)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]

    return row >= y1 and row <= y2 and col >= x1 and col <= x2
end

--- Logs the treesitter nodes under the cursor.
--- @param max_depth? number The maximum parent depth to log. Default = 5
local function log_ts_nodes_under_cursor(max_depth)
    local utils = require('utils')
    Snacks.notifier.hide()

    max_depth = max_depth or 5

    -- Get the treesitter node under the cursor.
    local cursor_node = vim.treesitter.get_node({ lang = "svelte", ignore_injections = false })
    if cursor_node == nil then
        utils.log("No treesitter node found under the  cursor.",
            { title = 'No TS Node', level = vim.log.levels.ERROR, timeout = 0 })
        return
    end

    -- Get the root node
    -- Uneccessary but sometimes usefull.
    local root_node = cursor_node:root()
    if root_node == nil then
        utils.log("No treesitter root node found under the cursor.",
            { title = 'No TS Root Node', level = vim.log.levels.ERROR, timeout = 0 })
        return
    end

    -- Get treesitter nodes up to a max depth.
    local nodes = {}
    local iter_node = cursor_node
    for _ = 1, max_depth do
        table.insert(nodes, iter_node)

        local success, parent_node = pcall(iter_node.parent, iter_node)
        if not success or parent_node == nil then
            break
        end

        iter_node = parent_node
    end

    -- Construct the print string.
    local print_str = 'ROOT: ' .. root_node:type() .. '\n'
    for i = #nodes, 1, -1 do
        local node = nodes[i]

        print_str = print_str .. '\nNODE ' .. i .. ": " .. node:type()
    end

    utils.log(print_str, { title = 'Nodes under cursor', timeout = 0 })
end

-- Return the module.
return {
    tostr = tostr,
    log = log,
    flog = flog,
    is_cursor_in_rect = is_cursor_in_rect,
    log_ts_nodes_under_cursor = log_ts_nodes_under_cursor,
    table = require('utils.table')
}
