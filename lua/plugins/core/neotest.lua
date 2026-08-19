return {
	"nvim-neotest/neotest",
	ft = { "go", "python" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",
		"nvim-neotest/neotest-python",
	},
	keys = {
		{
			"<leader>Tt",
			function()
				require("neotest").run.run()
			end,
			ft = { "go", "python" },
			desc = "Run nearest test",
		},
		{
			"<leader>Tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			ft = { "go", "python" },
			desc = "Run file tests",
		},
		{
			"<leader>Td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			ft = { "go", "python" },
			desc = "Debug nearest test",
		},
		{
			"<leader>Tl",
			function()
				require("neotest").run.run_last()
			end,
			ft = { "go", "python" },
			desc = "Run last test",
		},
		{
			"<leader>Ts",
			function()
				require("neotest").summary.toggle()
			end,
			ft = { "go", "python" },
			desc = "Toggle test summary",
		},
		{
			"<leader>To",
			function()
				require("neotest").output.open({ enter = true })
			end,
			ft = { "go", "python" },
			desc = "Show test output",
		},
		{
			"<leader>TO",
			function()
				require("neotest").output_panel.toggle()
			end,
			ft = { "go", "python" },
			desc = "Toggle output panel",
		},
		{
			"<leader>TS",
			function()
				require("neotest").run.stop()
			end,
			ft = { "go", "python" },
			desc = "Stop test",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-go"),
				require("neotest-python")({
					runner = "pytest",
					dap = { justMyCode = false },
				}),
			},
		})
	end,
}
