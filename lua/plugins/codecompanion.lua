local user = vim.env.USER or "User"

local adapters = {
	"ollama-deepseek-13b",
	"ollama-deepseek-6b",
	"anthropic",
}
local function switch_adapter()
	local Plugin = require("lazy.core.config").plugins["codecompanion.nvim"]
	if not Plugin then
		print("CodeCompanion is not loaded!")
		return
	end
	local Snacks = require("snacks")
	Snacks.picker({
		finder = function()
			local items = {}
			for i, item in ipairs(adapters) do
				table.insert(items, {
					idx = i,
					file = item,
					text = item,
				})
			end
			return items
		end,
		format = function(item, _)
			local file = item.file
			local ret = {}
			local a = Snacks.picker.util.align
			if file == Plugin.opts.strategies.chat.adapter then
				ret[#ret + 1] = { "", "SnacksPickerIconEvent" }
			else
				ret[#ret + 1] = { "󰧑", "SnacksPickerIconFile" }
			end
			ret[#ret + 1] = { " " }
			ret[#ret + 1] = { a(file, 20) }

			return ret
		end,
		layout = { preset = "select" },
		confirm = function(picker, item)
			local new_adapter = item.text
			Plugin.opts.strategies.chat.adapter = new_adapter
			Plugin.opts.strategies.inline.adapter = new_adapter
			Plugin.opts.strategies.agent.adapter = new_adapter

			print("🔄 Switching CodeCompanion adapter to: " .. new_adapter)
			require("lazy.core.loader").reload("codecompanion.nvim")

			picker:close()
		end,
	})
	-- Snacks.picker.pick({
	-- 	prompt = "Select Adapter", -- The prompt message
	-- 	items = adapters, -- The list of available adapters
	-- 	on_select = function(new_adapter)
	-- 		-- local new_adapter = Plugin.opts.strategies.chat.adapter == "anthropic" and "ollama" or "anthropic"
	-- 		Plugin.opts.strategies.chat.adapter = new_adapter
	-- 		Plugin.opts.strategies.inline.adapter = new_adapter
	-- 		Plugin.opts.strategies.agent.adapter = new_adapter
	--
	-- 		print("🔄 Switching CodeCompanion adapter to: " .. new_adapter)
	-- 		require("lazy.core.loader").reload("codecompanion.nvim")
	-- 		-- require("codecompanion").setup(Plugin.opts)
	-- 	end,
	-- })
end

vim.api.nvim_create_user_command("CodeCompanionSwitch", switch_adapter, {})

vim.keymap.set("n", "<leader>cx", switch_adapter, { desc = "Switch CodeCompanion adapter" })

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = {
		"CodeCompanion",
		"CodeCompanionChat",
		"CodeCompanionToggle",
		"CodeCompanionActions",
	},
	keys = {
		{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Action Palette" },
		{ "<leader>cc", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "New Chat" },
		{ "<leader>ci", "<cmd>CodeCompanion<cr>", mode = "n", desc = "Inline Prompt" },
	},
	init = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>c", group = "󰚩 CodeCompanion" },
			{ "<leader>ca", desc = "󰘳 Action Palette" },
			{ "<leader>cc", desc = " New Chat" },
			{ "<leader>cA", desc = "󰐕 Add Code" },
			{ "<leader>ci", desc = " Inline Prompt" },
		})
		vim.cmd([[cab cc CodeCompanion]])
	end,
	opts = {
		debug = true,
		auto_focus = true,
		window = {
			border = "rounded",
			width = 0.6,
			height = 0.8,
			position = "right",
		},
		adapters = {
			["ollama-deepseek-6b"] = function()
				return require("codecompanion.adapters").extend("ollama", {
					model = "deepseek-coder:6.7b",
				})
			end,
			["ollama-deepseek-13b"] = function()
				return require("codecompanion.adapters").extend("ollama", {
					model = "deepseek-coder:13b",
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "anthropic",
			},
			agent = {
				adapter = "anthropic",
			},
			inline = {
				adapter = "anthropic",
			},
		},
		display = {
			provider = "mini_diff",
			chat = {
				show_header_separator = true,
				show_settings = true,
				show_token_count = true,
			},
		},

		prompts = {
			["Generate Types"] = {
				type = "chat",
				description = "Generate TypeScript types/interfaces for your code",
				command = "types",
				mode = "v",
				filter = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				system = "You are an expert TypeScript developer focused on creating precise, well-documented types and interfaces.",
				prompt = function(ctx)
					return "Generate TypeScript types or interfaces for the following code. Make them strict and well-documented. If there are any potential improvements for type safety, suggest them:\n\n```"
						.. ctx.filetype
						.. "\n"
						.. ctx.selection
						.. "\n```"
				end,
			},
			["Code Review"] = {
				type = "chat",
				description = "Review code for best practices and improvements",
				command = "review",
				mode = { "n", "v" },
				system = function(ctx)
					return "You are a senior "
						.. ctx.filetype
						.. " developer performing a thorough code review. Focus on best practices, security, and performance."
				end,
				prompt = function(ctx)
					return "Review this code and provide feedback on:\n- Code quality and best practices\n- Performance considerations\n- Potential bugs\n- Code organization\n- Error handling\n- Security concerns\n\n```"
						.. ctx.filetype
						.. "\n"
						.. (ctx.selection or ctx.buffer_content)
						.. "\n```"
				end,
			},
		},
	},
}
