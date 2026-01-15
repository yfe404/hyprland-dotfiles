local opt = vim.opt

opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true

vim.g.mapleader = " "


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

opt.rtp:prepend(lazypath)

local plugins = {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.8', 
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
}

require("lazy").setup({plugins, {}})

local builtin = require("telescope.builtin")


require("nvim-treesitter.configs").setup({
	ensure_installed = {"lua", "c"},
	highlight = {enable = true},
	indent = {enable = true},
})

require("catppuccin").setup({
	flavour = "mocha",
	color_overrides = {
		mocha = {
			base = "#1a1025",
			mantle = "#150a1a",
			crust = "#0f0815",
			surface0 = "#2a1f35",
			surface1 = "#3a2f45",
			surface2 = "#4a3f55",
			overlay0 = "#685878",
			overlay1 = "#807090",
			overlay2 = "#9890a8",
			text = "#e8e0f0",
			subtext0 = "#b8b0c8",
			subtext1 = "#d0c8e0",
			pink = "#e84a9c",
			mauve = "#bb7dcf",
			red = "#ff6b9d",
			maroon = "#e87090",
			peach = "#f0a080",
			yellow = "#ffe066",
			green = "#7de8b0",
			teal = "#70d8d0",
			sky = "#7dcfff",
			sapphire = "#70b8f0",
			blue = "#7db8ff",
			lavender = "#c8a0f0",
		},
	},
})	
vim.cmd.colorscheme  "catppuccin"


vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

