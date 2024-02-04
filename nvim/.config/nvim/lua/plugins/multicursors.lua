-----------------------------------------------------------------------
-- [[ Multicursor config ]]
-----------------------------------------------------------------------

-- Set multicursor
-- See `:help multicursor.txt`
return {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
        'smoka7/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
		{ '<Leader>m', '<cmd>MCstart<cr>', desc = 'Create new selection for selected text/word',mode = { 'v', 'n' } },
	},
}

