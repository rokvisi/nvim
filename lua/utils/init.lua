--- Convienience function to convert a message (table or string) to a string.
--- @param msg string | table The message
--- @return string result
local function to_str(msg)
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

--- Logs a string or table to vim.notify.
--- @param msg string | table The message
--- @param opts? log_OPTS The options
local function log(msg, opts)
    opts = opts or {}
    msg = to_str(msg)

    vim.notify(msg, opts.level, opts)
end

--- @class flog_OPTS
--- @field dest? string The log file directory. Default = 'vim.fn.stdpath("config")'
--- @field filename? string The log file filename. Default = 'log.txt'
--- @field mode? string The write mode. Default = 'a'

--- Logs a string or table to a file.
--- @param msg string | table The message
--- @param opts? flog_OPTS The options
local function f_log(msg, opts)
    opts = opts or {}
    opts.dest = opts.dest or vim.fn.stdpath("config")
    opts.mode = opts.mode or "a"
    opts.filename = opts.filename or "log.txt"

    msg = to_str(msg)

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
--- @return boolean result
local function is_cursor_in_rect(y1, x1, y2, x2)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1] - 1, cursor[2]

    return row >= y1 and row <= y2 and col >= x1 and col <= x2
end

--- Logs the treesitter nodes under the cursor.
--- @param max_depth? number The maximum parent depth to log. Default = 5
local function log_ts_nodes_under_cursor(max_depth)
    Snacks.notifier.hide()

    max_depth = max_depth or 5

    -- Get the treesitter node under the cursor.
    local cursor_node = vim.treesitter.get_node({ lang = "svelte", ignore_injections = false })
    if cursor_node == nil then
        log("No treesitter node found under the  cursor.",
            { title = 'No TS Node', level = vim.log.levels.ERROR, timeout = 0 })
        return
    end

    -- Get the root node
    -- Uneccessary but sometimes usefull.
    local root_node = cursor_node:root()
    if root_node == nil then
        log("No treesitter root node found under the cursor.",
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

    log(print_str, { title = 'Nodes under cursor', timeout = 0 })
end

--- Split a string by a pattern.
--- @param str string The string to split.
--- @param pattern string The pattern to split by.
--- @return table tokens The tokens.
local function split(str, pattern)
    local result = {} -- NOTE: use {n = 0} in Lua-5.0

    local fpat = "(.-)" .. pattern
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)

    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(result, cap)
        end
        last_end = e + 1
        s, e, cap = str:find(fpat, last_end)
    end

    if last_end <= #str then
        cap = str:sub(last_end)
        table.insert(result, cap)
    end

    return result
end

--- Get the filename from a path (or the last folder if no trailing '/' exists).
--- @param path string The path.
--- @return string filename The filename.
local function get_filename(path)
    local parts = split(path, "/")
    return parts[#parts]
end

--- Get the last directory in the path.
--- @param path string The path.
--- @return string last_dir The last directory in the path.
local function get_last_dir_in_path(path)
    local parts = split(path, "/")
    return parts[#parts - 1]
end

--- Exclude keys from a table.
--- @param src_table table The source table.
--- @param keys table The keys to exclude.
--- @return table result The table with the keys excluded.
local function exclude(src_table, keys)
    return vim.iter(src_table):filter(function(k)
        for _, key in pairs(keys) do
            if k == key then
                return false
            end
        end

        return true
    end):totable()
end


--- Map each element in a table.
--- @generic K, V, Res
--- @param src_table table<K, V> The source table.
--- @param map_fn fun(value: V): Res The map function.
--- @return Res[] result The mapped table.
local function map(src_table, map_fn)
    return vim.iter(src_table):map(map_fn):totable()
end

--- Map each (index, element) in a table.
--- @generic K, V, Res
--- @param src_table table<K, V> The source table.
--- @param map_fn fun(i: number, value: V): Res The map function.
--- @return Res[] result The mapped table.
local function map_ipairs(src_table, map_fn)
    return vim.iter(ipairs(src_table)):map(map_fn):totable()
end

--- Format the current buffer with the language server.
local function lsp_format()
    vim.lsp.buf.format({
        filter = function(ls_client)
            -- Format only using null-ls.
            -- TODO: If null-ls can't format or is not available, use the first available formatter.
            return ls_client.name == "null-ls"

            -- if ls_client.name == "eslint" then return false end
            -- if ls_client.name == "tailwindcss" then return false end
            -- if ls_client.name == "svelte" then return false end
            -- if ls_client.name == "lua_ls" then return false end

            -- return true
        end
    })
end


--- Check if the current project is a svelte project.
--- @return boolean result
local function is_svelte_project()
    local project_root = vim.fs.root(0, { "svelte.config.js", "svelte.config.ts" })
    return project_root ~= nil
end

--- Get the language (typescript or javascript) of the current web project.
--- @return "javascript"|"typescript"|nil result
local function get_web_project_lang()
    if vim.fs.root(0, { "tsconfig.json" }) ~= nil then
        return "typescript"
    end
    if vim.fs.root(0, { "jsconfig.json" }) ~= nil then
        return "javascript"
    end

    return nil -- Can't figure out priject type.
end

-- Get the possible svelte route files based on the project language.
--- @param project_lang "javascript"|"typescript" The project language.
--- @return string[] result The possible svelte route files.
local function get_possible_svelte_route_files(project_lang)
    -- Imply the default language as javascript.
    local possible_route_files = {
        "+page.svelte",
        "+page.js",
        "+page.server.js",
        "+layout.svelte",
        "+layout.js",
        "+layout.server.js",
        "+error.svelte",
        "+server.js"
    }

    -- Transform the file extensions to typescript if the project language is typescript.
    if project_lang == "typescript" then
        possible_route_files = map(possible_route_files, function(route_file)
            local transformed, _ = route_file:gsub("%.js", ".ts")
            return transformed
        end)
    end

    return possible_route_files
end

--- Get the files in the current buffer's directory.
--- @return string[] result The files in the buffer's directory.
local function get_files_in_buf_dir()
    -- Get the path and the directory of the current buffer.
    local filepath = vim.fn.expand("%")
    local filedir = vim.fs.dirname(filepath)

    -- Filter out non-files.
    return vim.iter(vim.fs.dir(filedir)):filter(function(_, type)
        return type == "file"
    end):map(function(name, _)
        return name
    end):totable()
end

--- Prompt the user with a question and a list of answers.
--- @param question string The question to ask.
--- @param answers string[] The answers to choose from. Answers can contain a '&' character to denote a shortcut key.
--- @return string|nil choice The Lowercase answer chosen by the user.
local function confirm(question, answers)
    local answer = vim.iter(answers):join('\n')
    local choice = vim.fn.confirm(question, answer, "Question")

    -- If the user cancels the prompt.
    if choice == 0 then
        return nil
    end

    -- Transform the choice to remove the '&' character (denotes shortcut key).
    local transformed_choice, _ = answers[choice]:gsub("%&", "")

    return transformed_choice:lower()
end

-- Return the module.
return {
    lua = {
        to_str = to_str,
        split = split,
    },
    paths = {
        get_filename = get_filename,
        get_last_dir_in_path = get_last_dir_in_path,
    },
    table = {
        exclude = exclude,
        map = map,
        map_ipairs = map_ipairs,
    },
    log = log,
    f_log = f_log,
    confirm = confirm,
    is_cursor_in_rect = is_cursor_in_rect,
    log_ts_nodes_under_cursor = log_ts_nodes_under_cursor,
    is_svelte_project = is_svelte_project,
    get_web_project_lang = get_web_project_lang,
    get_files_in_buf_dir = get_files_in_buf_dir,
    get_possible_svelte_route_files = get_possible_svelte_route_files,
    lsp_format = lsp_format,
}
