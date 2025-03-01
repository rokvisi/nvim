-- Nothing yet
require("post-lazy.autoroot")

local function get_all_files_in_current_dir()
    -- Get the filepath and filedir of the current buffer.
    local current_filepath = vim.fn.expand("%")
    local current_filedir = vim.fs.dirname(current_filepath)


    local files_it = vim.iter(vim.fs.dir(current_filedir))

    -- Filter out everything except files.
    files_it = files_it:filter(function(_, type)
        return type == "file"
    end)

    -- Map to absolute path filenames.
    -- files_it = files_it:map(function (name, _)
    --     return vim.fs.joinpath(current_filedir, name)
    -- end)

    files_it = files_it:map(function(name, _)
        return name
    end)

    return files_it:totable()
end

local function foo() end

local function get_svelte_project_type()
    local is_ts = vim.fs.root(0, { "tsconfig.json" }) ~= nil
    local is_js = vim.fs.root(0, { "jsconfig.json" }) ~= nil

    if is_ts then
        return "ts"
    end
    if is_js then
        return "js"
    end

    -- Can't figure out priject type.
    return nil
end

local function get_possible_svelte_files()
    local project_type = get_svelte_project_type()

    local common = {
        "+page.svelte",
    }

    local typescript_files = {
        "+page.ts",
        "+page.server.ts",
    }

    for _, file in ipairs(typescript_files) do
        table.insert(common, file)
    end

    return common
end

local function svelte_select()
    local current_filepath = vim.fn.expand("%")
    local current_filedir = vim.fs.dirname(current_filepath)

    local files = get_all_files_in_current_dir()
    local svelte_page_files = get_possible_svelte_files()

    local mapped = vim.iter(svelte_page_files)
        :map(function(file)
            return {
                name = file,
                exists = vim.iter(files):find(file) ~= nil,
            }
        end)
        :totable()

    local picker_items = require("utils").table.map_ipairs(mapped, function(i, file)
        ---@type snacks.picker.Item
        return {
            idx = i,
            score = i,
            text = file.name,
            file = vim.fs.joinpath(current_filedir, file.name),
        }
    end)
    local choice = vim.fn.confirm("What do you want?", "&Apples\n&Oranges\n&Bananas", 2)

    -- Picker correctly handles non_existant_files, but it'd be nice to have a confirm window to create them
    -- Also would be nice to separate existing files from non existing files in the picker UI using custom layouts. IDK if possible tho.
    Snacks.picker({
        title = "Svelte Page Files",
        items = picker_items,
    })

    dd(mapped)
    -- Check for each possilbe svelte file type
    -- dd("existant_files: ", existant_files)
    -- dd("non_existant_files: ", non_existant_files)
end

vim.api.nvim_create_user_command("SvelteSelect", svelte_select, {})
vim.keymap.set("n", "<leader>ts", "<cmd>SvelteSelect<CR>", { desc = "[t]est SvelteSelect" })
