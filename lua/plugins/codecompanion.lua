local adapters = {
	"ollama-deepseek-13b",
	"ollama-deepseek-6b",
	"anthropic",
}

local function switch_adapter()
	local Plugin = require("lazy.core.config").plugins["codecompanion.nvim"]
	if not Plugin then
		vim.notify("CodeCompanion is not loaded!", vim.log.levels.ERROR)
		return
	end

	local Snacks = require("snacks")
	if not Snacks then
		vim.notify("Snacks plugin is required for adapter switching", vim.log.levels.ERROR)
		return
	end

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
				ret[#ret + 1] = { "", "SnacksPickerIconEvent" }
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

			vim.notify("🔄 Switching CodeCompanion adapter to: " .. new_adapter, vim.log.levels.INFO)
			require("lazy.core.loader").reload("codecompanion.nvim")

			picker:close()
		end,
	})
end

vim.keymap.set("n", "<leader>cx", switch_adapter, { desc = "Switch CodeCompanion adapter" })

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/noice.nvim",
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
		vim.g.codecompanion_auto_tool_mode = true
		require("config.companion-extension").init()
		local wk = require("which-key")
		wk.add({
			{ "<leader>c", group = "󰚩 CodeCompanion" },
			{ "<leader>ca", desc = "󰘳 Action Palette" },
			{ "<leader>cc", desc = " New Chat" },
			{ "<leader>cA", desc = "󰐕 Add Code" },
			{ "<leader>ci", desc = " Inline Prompt" },
			{ "<leader>cx", desc = "🔄 Switch Adapter" },
		})
	end,
	opts = {
		-- Enable debug logging to troubleshoot action errors
		log_level = "DEBUG",

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
			diff = { provider = "mini_diff" },
			chat = {
				show_settings = true,
				show_token_count = true,
				token_count = function(tokens, adapter)
					local input_ratio = 0.8
					local output_ratio = 0.2

					local input_tokens = tokens * input_ratio
					local output_tokens = tokens * output_ratio

					local input_cost = (input_tokens / 1000000) * 3 -- $3 / 1M
					local output_cost = (output_tokens / 1000000) * 15 -- $15 / 1M

					local total_cost = input_cost + output_cost
					return string.format(" (%d tokenů, odhad: $%.4f)", tokens, total_cost)
				end,
			},
		},

		prompt_library = {
			["Generate Types"] = {
				strategy = "chat",
				description = "Generate TypeScript types/interfaces for your code",
				command = "types",
				modes = { "v" },
				prompts = {
					{
						role = "system",
						content = "You are an expert TypeScript developer focused on creating precise, well-documented types and interfaces.",
					},
					{
						role = "user",
						content = function(ctx)
							return string.format(
								[[Generate TypeScript types or interfaces for the following code. Make them strict and well-documented. If there are any potential improvements for type safety, suggest them:

```%s
%s
```]],
								ctx.filetype,
								ctx.selection
							)
						end,
					},
				},
			},
			["Code Review"] = {
				strategy = "chat",
				description = "Review code for best practices and improvements",
				command = "review",
				modes = { "n", "v" },
				prompts = {
					{
						role = "system",
						content = function(ctx)
							return string.format(
								"You are a senior %s developer performing a thorough code review. Focus on best practices, security, and performance.",
								ctx.filetype
							)
						end,
					},
					{
						role = "user",
						content = function(ctx)
							return string.format(
								[[Review this code and provide feedback on:
- Code quality and best practices
- Performance considerations
- Potential bugs
- Code organization
- Error handling
- Security concerns

```%s
%s
```]],
								ctx.filetype,
								ctx.selection or ctx.buffer_content
							)
						end,
					},
				},
			},
		},
	},
}
