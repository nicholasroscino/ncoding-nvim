vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a"

vim.o.showmode = false

vim.opt.spell = true
vim.opt.spelllang = "en"

-- TODO: For SSH-tmux copy the link: https://github.com/nicholasroscino/neovim-config/blob/main/lua/ncoding/options.lua#L31
-- make the clipboard strategy as a choice?
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- NOTE: The following is intended to be used with SSH-TMUX Setup
local copy_cmd = {
	"bash",
	"-c",
	[[
    # 1. Capture the entire input piped from Neovim into a variable.
    CONTENT_WITH_GUARD=$(cat; printf "X");
    CONTENT="${CONTENT_WITH_GUARD%X}";

    # 2. Sync the tmux buffer: Send the captured content to tmux.
    #    This makes Neovim's 'p' command work correctly.
    printf "%s" "$CONTENT" | tmux load-buffer -;

    # Get the correct TTY device for the client from tmux itself
    TTY_DEVICE=$(tmux display-message -p '#{client_tty}');
    # Base64 encode the content
    B64_PAYLOAD=$(echo -n "$CONTENT" | base64 | tr -d '\n');
    # Construct the full wrapped sequence
    OSC52_SEQUENCE=$(printf '\033Ptmux;\033\033]52;c;%s\x07\033\\' "$B64_PAYLOAD");
    # Write the sequence DIRECTLY to the correct TTY device
    printf "%s" "$OSC52_SEQUENCE" > "$TTY_DEVICE";
  ]],
}

-- local paste_cmd = { "tmux", "save-buffer", "-" }
--
-- vim.opt.clipboard = "unnamedplus"
-- vim.g.clipboard = {
-- 	name = "tmux_clipboard_osc52_bridge",
-- 	copy = {
-- 		["+"] = copy_cmd,
-- 		["*"] = copy_cmd,
-- 	},
-- 	paste = {
-- 		["+"] = paste_cmd,
-- 		--	["*"] = paste_cmd,
-- 	},
-- }
--

vim.o.breakindent = true
vim.o.undofile = true

-- NOTE: Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.o.cursorline = true
vim.o.scrolloff = 15
vim.o.confirm = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99 -- :h foldlevelstart -- 99 -> no folds closed
vim.opt.foldnestmax = 4

local virt_lines_ns = vim.api.nvim_create_namespace("on_diagnostic_jump")

local function on_jump(diagnostic, bufnr)
	if not diagnostic then
		return
	end

	vim.diagnostic.show(
		virt_lines_ns,
		bufnr,
		{ diagnostic },
		{ virtual_lines = { current_line = true }, virtual_text = false }
	)
end

vim.diagnostic.config({
	jump = {
		on_jump = on_jump,
	},
})
