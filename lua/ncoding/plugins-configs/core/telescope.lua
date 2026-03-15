return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- ADD THESE TWO LINES HERE
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				file_ignore_patterns = {
					"node_modules%/.*",
					"package%-lock.json",
					"lazy%-lock.json",
				},
				defaults = {
					case_mode = "smart_case",
				},
				pickers = {
					buffers = {
						sort_mru = true,
						mappings = {
							i = {
								["<M-d>"] = false,
							},
							n = {
								["<M-d>"] = false,
								["dd"] = actions.delete_buffer,
							},
						},
					},
					colorscheme = {
						enable_preview = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable extensions
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- Keymaps
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files" })

			-- Your custom buffer searcher function
			-- Defined as a local so it can call itself recursively
			local buffer_searcher
			buffer_searcher = function()
				builtin.buffers({
					sort_mru = true,
					ignore_current_buffer = true,
					show_all_buffers = false,
					attach_mappings = function(prompt_bufnr, map)
						local refresh_buffer_searcher = function()
							actions.close(prompt_bufnr)
							vim.schedule(buffer_searcher)
						end

						local delete_buf = function()
							local selection = action_state.get_selected_entry()
							vim.api.nvim_buf_delete(selection.bufnr, { force = true })
							refresh_buffer_searcher()
						end

						local delete_multiple_buf = function()
							local picker = action_state.get_current_picker(prompt_bufnr)
							local selection = picker:get_multi_selection()
							for _, entry in ipairs(selection) do
								vim.api.nvim_buf_delete(entry.bufnr, { force = true })
							end
							refresh_buffer_searcher()
						end

						map("n", "dd", delete_buf)
						map("n", "<C-d>", delete_multiple_buf)
						map("i", "<C-d>", delete_multiple_buf)

						return true
					end,
				})
			end

			vim.keymap.set("n", "<leader>fb", buffer_searcher, { desc = "Custom Buffer Searcher" })

			-- Other Search functions...
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
		end,
	},
}
