return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	---@type snacks.Config
	opts = {
		bigfile = {
			notify = true,
			size = 1.5 * 1024 * 1024, -- 1.5 MB

			-- Enable or disable features when big file is detected
			---@param ctx {buf: number, ft: string}
			setup = function(ctx)
				vim.schedule(function()
					vim.bo[ctx.buf].syntax = ctx.ft
				end)
			end,
		},
		notifier = { enabled = true },
		words = { enabled = true },
		quickfile = { enabled = true },
		indent = { enabled = true },
		scroll = { enabled = true },
		scope = { enabled = true },
		input = { enabled = true },
		picker = {
			previewers = {
				diff = {
					native = true,
				},
				git = {
					native = true,
				},
			},
			layout = {
				preset = "ivy",
			},
		},
		explorer = {
			replace_netrw = true,
		},
		statuscolumn = {
			folds = {
				open = true,
				git_hl = true,
			},
		},
		terminal = {
			win = { style = "terminal" },
		},
		dashboard = {
			preset = {
                keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", padding = 1 },
				{ section = "projects", title = "Projects" },
				{ section = "startup" },
			},
		},
		styles = {},
	},
	init = function()
		---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
		local progress = vim.defaulttable()
		vim.api.nvim_create_autocmd("LspProgress", {
			---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
				if not client or type(value) ~= "table" then
					return
				end
				local p = progress[client.id]

				for i = 1, #p + 1 do
					if i == #p + 1 or p[i].token == ev.data.params.token then
						p[i] = {
							token = ev.data.params.token,
							msg = ("[%3d%%] %s%s"):format(
								value.kind == "end" and 100 or value.percentage or 100,
								value.title or "",
								value.message and (" **%s**"):format(value.message) or ""
							),
							done = value.kind == "end",
						}
						break
					end
				end

				local msg = {} ---@type string[]
				progress[client.id] = vim.tbl_filter(function(v)
					return table.insert(msg, v.msg) or not v.done
				end, p)

				local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
				vim.notify(table.concat(msg, "\n"), "info", {
					id = "lsp_progress",
					title = client.name,
					opts = function(notif)
						notif.icon = #progress[client.id] == 0 and " "
							or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
					end,
				})
			end,
		})
	end,
    -- stylua: ignore
	keys = {
		{ "<leader>T",  function() Snacks.terminal.toggle() end, "Open Terminal" },
		{ "<leader>pe", function() Snacks.explorer() end, "Open Explorer" },
		{ "<leader>bd", function() Snacks.bufdelete() end, "Delete current buffer" },
		{ "<leader>ff", function() Snacks.picker.files() end, "Find Files" },
		{ "<leader>fr", function() Snacks.picker.recent() end, "Recent" },
	},
}
