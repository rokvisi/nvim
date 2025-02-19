-- Nothing yet

-- Running 'zR' and 'zM' normal commands changes the foldlevel,
-- ufo provide the APIs openAllFolds/closeAllFolds to open/close all folds
-- but keep foldlevel value. Need to remap.
vim.keymap.set('n', 'zR', function() require('ufo').openAllFolds() end)
vim.keymap.set('n', 'zM', function() require('ufo').closeAllFolds() end)
