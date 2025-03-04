local function find_harpoon_marks()
    local harpoon = require("harpoon")
    local harpoon_items = harpoon:list().items

    local picker_items = require("utils").table.map_ipairs(harpoon_items, function(i, item)
        ---@type snacks.picker.Item
        return {
            idx = i,
            score = i,
            text = item.value,
            file = item.value,
            pos = { item.context.row, item.context.col }
        }
    end)

    Snacks.picker({
        title = "Harpoon Marks",
        items = picker_items,
        focus = "list", -- can be "input" or "list",
        confirm = function(picker, item)
            -- Use the harpoon API to select the mark.
            -- This forces the mark to be updated in the case of an invalid row or column.
            harpoon:list():select(item.idx)
            picker:close()
        end
    })
end

local function find_git_diff_files()
    local files = vim.fn.systemlist('git diff --name-only')
    local picker_items = require("utils").table.map_ipairs(files, function(i, file)
        ---@type snacks.picker.Item
        return {
            idx = i,
            score = i,
            text = file,
            file = file,
        }
    end)

    -- TODO: Untracked files (freshly created files) are not shown in the picker.
    Snacks.picker({
        title = "Git Diff Files",
        items = picker_items,
        focus = "input", -- can be "input" or "list"
    })
end

local function find_svelte_route_files()
    local utils = require("utils")

    -- Abort if the current buffer is not a part of a svelte project.
    if not utils.is_svelte_project() then return end

    -- Get the language of the current project.
    -- Abort if the project language is not known.
    local project_language = utils.get_web_project_lang()
    if not project_language then return end

    -- Get all possible svelte files in a route.
    local possible_svelte_route_files = utils.get_possible_svelte_route_files(project_language)

    -- Get the current buffer's path, directory and the files in it.
    local buf_path = vim.fn.expand("%")
    local buf_dir = vim.fs.dirname(buf_path)
    local buf_dir_files = utils.get_files_in_buf_dir()

    local items = utils.table.map_ipairs(possible_svelte_route_files, function(i, route_file)
        local file_exists = vim.iter(buf_dir_files):find(route_file) ~= nil
        local file_path = vim.fs.joinpath(buf_dir, route_file)

        ---@type snacks.picker.Item
        return {
            idx = i,
            score = 1,
            text = route_file,
            file = file_path,
            score_mul = file_exists and 100 or 1,
            exists = file_exists,
        }
    end)

    -- TODO: Would be nice to separate existing files from non-existing files in the picker UI using a custom layout (probably need to modify builtin "list" window).
    Snacks.picker({
        title = "Svelte Page Files",
        items = items,
        matcher = { sort_empty = true },             -- Sort the list without a search term.
        sort = { fields = { "score:desc", "idx" } }, -- Only sort by score and then by index to preserve order.
        focus = "list",                              -- Focus on the list and not the input.
        confirm = function(picker, item)
            if item.exists == false then
                local question = '"' .. item.file .. "\" doesn't exist.\nCreate it?"
                local choice = vim.fn.confirm(question, "&Yes\n&No", "Question")

                if choice ~= 1 then return end
            end

            Snacks.picker.actions.jump(picker, _, { cmd = "buffer" })
        end,
        layout = {
            layout = {
                box = "vertical",
                backdrop = false,
                row = -1,
                width = 0,
                height = 0.4,
                border = "none",
                title = " {title} {live} {flags}",
                title_pos = "left",
                { win = "input", height = 1, border = "rounded" },
                {
                    box = "horizontal",
                    { win = "list",    border = "rounded", },
                    { win = "preview", title = "{preview}", width = 0.6, border = "rounded" },
                },
            },
        }
    })
end

return {
    find_harpoon_marks = find_harpoon_marks,
    find_git_diff_files = find_git_diff_files,
    find_svelte_route_files = find_svelte_route_files,
}
