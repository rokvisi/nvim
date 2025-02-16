-- utils.table module

return {
    exclude = function(srcTable, items)
        return vim.iter(srcTable):filter(function(s)
            for _, item in pairs(items) do
                if s == item then
                    return false
                end
            end

            return true
        end):totable()
    end
}
