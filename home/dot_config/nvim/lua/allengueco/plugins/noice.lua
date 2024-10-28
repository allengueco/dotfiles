return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				signature = {
					enabled = false,
				},
				hover = {
					enabled = false,
				},
			},
			presets = {
				long_message_to_split = true,
				inc_rename = false,
                lsp_doc_border = false,
			},
			routes = {
				{
					filter = {
						event = "lsp",
						kind = "progress",
                        cond = function (message)
                            local client = vim.tbl_get(message.opts, "progress", "client")
                            return client == "jdtls"
                        end
					},
					opts = { skip = true },
				},
			},
			views = {
				cmdline_popup = {
					position = {
						row = 5,
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
		},
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			render = "wrapped-compact",
		},
		init = function()
			-- Utility functions shared between progress reports for LSP and DAP

			local client_notifs = {}

			local function get_notif_data(client_id, token)
				if not client_notifs[client_id] then
					client_notifs[client_id] = {}
				end

				if not client_notifs[client_id][token] then
					client_notifs[client_id][token] = {}
				end

				return client_notifs[client_id][token]
			end

			local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

			local function update_spinner(client_id, token)
				local notif_data = get_notif_data(client_id, token)

				if notif_data.spinner then
					local new_spinner = (notif_data.spinner + 1) % #spinner_frames
					notif_data.spinner = new_spinner

					notif_data.notification = vim.notify(nil, nil, {
						hide_from_history = true,
						icon = spinner_frames[new_spinner],
						replace = notif_data.notification,
					})

					vim.defer_fn(function()
						update_spinner(client_id, token)
					end, 100)
				end
			end

			local function format_title(title, client_name)
				return client_name .. (#title > 0 and ": " .. title or "")
			end

			local function format_message(message, percentage)
				return (percentage and percentage .. "%\t" or "") .. (message or "")
			end

			-- LSP integration

			vim.lsp.handlers["$/progress"] = function(_, result, ctx)
				local client_id = ctx.client_id

				local val = result.value

				if not val.kind then
					return
				end

				local notif_data = get_notif_data(client_id, result.token)

				if val.kind == "begin" then
					local message = format_message(val.message, val.percentage)

					notif_data.notification = vim.notify(message, "info", {
						title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
						icon = spinner_frames[1],
						timeout = false,
						hide_from_history = false,
					})

					notif_data.spinner = 1
					update_spinner(client_id, result.token)
				elseif val.kind == "report" and notif_data then
					notif_data.notification = vim.notify(format_message(val.message, val.percentage), "info", {
						replace = notif_data.notification,
						hide_from_history = false,
					})
				elseif val.kind == "end" and notif_data then
					notif_data.notification =
						vim.notify(val.message and format_message(val.message) or "Complete", "info", {
							icon = "",
							replace = notif_data.notification,
							timeout = 3000,
						})

					notif_data.spinner = nil
				end
			end

			-- table from lsp severity to vim severity.
			local severity = {
				"error",
				"warn",
				"info",
				"info", -- map both hint and info to info?
			}

			vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
				vim.notify(method.message, severity[params.type])
			end
		end,
	},
}
