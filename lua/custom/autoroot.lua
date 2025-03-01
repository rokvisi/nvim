-- Taken from 'https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/'

local function set_root()
    -- Get the path of the current buffer.
    local buffer_path = vim.api.nvim_buf_get_name(0)
    if buffer_path == '' then return end

    -- Get the directory of the current buffer.
    local buffer_dir = vim.fs.dirname(buffer_path)

    -- Search upward for root the directory
    local root_marker_path = vim.fs.find({ '.git' }, { path = buffer_dir, upward = true })[1]
    if root_marker_path == nil then
        -- Fall back to buffer directory.
        vim.fn.chdir(buffer_dir)
        return
    end

    -- Set current directory.
    local root_dir = vim.fs.dirname(root_marker_path)
    vim.fn.chdir(root_dir)
end

local root_augroup = vim.api.nvim_create_augroup('AutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
