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
	config = true,
	cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionAdd", "CodeCompanionChat" },

	keys = {
		{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Action Palette" },
		{ "<leader>cc", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "New Chat" },
		{ "<leader>cA", "<cmd>CodeCompanionAdd<cr>", mode = "v", desc = "Add Code" },
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
					schema = {
						model = {
							default = "deepseek-coder:6.7b",
						},
					},
				})
			end,
			["ollama-deepseek-13b"] = function()
				return require("codecompanion.adapters").extend("ollama", {
					schema = {
						model = {
							default = "deepseek-coder:13b",
						},
					},
				})
			end,
		},
		strategies = {
			chat = {
				adapter = "anthropic",
				roles = {
					llm = "  CodeCompanion",
					user = " " .. user:sub(1, 1):upper() .. user:sub(2),
				},
			},
			inline = {
				adapter = "anthropic",
			},
			agent = {
				adapter = "anthropic",
			},
		},
		display = {
			chat = {
				show_settings = true,
				render_headers = true,
				show_references = true,
				show_header_separator = true,
				-- start_in_insert_mode = true,
			},
			diff = {
				provider = "mini_diff",
			},
		},
		prompt_library = {
			["Generate Types"] = {
				strategy = "chat",
				description = "Generate TypeScript types/interfaces for your code",
				opts = {
					is_slash_cmd = true,
					auto_submit = true,
					short_name = "types",
					modes = { "v" },
					condition = function(context)
						return vim.tbl_contains(
							{ "typescript", "typescriptreact", "javascript", "javascriptreact" },
							context.filetype
						)
					end,
				},
				prompts = {
					{
						role = "system",
						content = "You are an expert TypeScript developer focused on creating precise, well-documented types and interfaces.",
					},
					{
						role = "user",
						content = function(context)
							local text =
								require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
							return "Generate TypeScript types or interfaces for the following code. Make them strict and well-documented. If there are any potential improvements for type safety, suggest them:\n\n```"
								.. context.filetype
								.. "\n"
								.. text
								.. "\n```"
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
			["New React Component"] = {
				strategy = "chat",
				description = "Create a new React component with TypeScript",
				opts = {
					is_slash_cmd = true,
					auto_submit = false,
					short_name = "comp",
					condition = function(context)
						return vim.tbl_contains({ "typescript", "typescriptreact" }, context.filetype)
					end,
				},
				prompts = {
					{
						role = "system",
						content = "You are an expert React and TypeScript developer who specializes in creating well-structured, accessible, and performant components.",
					},
					{
						role = "user",
						content = "Create a new React component with TypeScript. Consider these requirements:\n- Use functional components\n- Include proper TypeScript interfaces\n- Add JSDoc documentation\n- Follow React best practices\n- Consider accessibility\n- Add proper prop validation\n\nComponent description:",
					},
				},
			},
			["Code Review"] = {
				strategy = "chat",
				description = "Review code for best practices and improvements",
				opts = {
					is_slash_cmd = true,
					auto_submit = true,
					short_name = "review",
					modes = { "n", "v" },
				},
				prompts = {
					{
						role = "system",
						content = function(context)
							return "You are a senior "
								.. context.filetype
								.. " developer performing a thorough code review. Focus on best practices, security, and performance."
						end,
					},
					{
						role = "user",
						content = function(context)
							local text
							if context.mode == "v" then
								text = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
							else
								local buf_utils = require("codecompanion.utils.buffers")
								text = buf_utils.get_content(context.bufnr)
							end
							return "Review this code and provide feedback on:\n- Code quality and best practices\n- Performance considerations\n- Potential bugs\n- Code organization\n- Error handling\n- Security concerns\n\n```"
								.. context.filetype
								.. "\n"
								.. text
								.. "\n```"
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
			["Optimize Component"] = {
				strategy = "chat",
				description = "Optimize React component performance",
				opts = {
					is_slash_cmd = true,
					auto_submit = true,
					short_name = "opt",
					modes = { "n", "v" },
					condition = function(context)
						return vim.tbl_contains(
							{ "typescript", "typescriptreact", "javascript", "javascriptreact" },
							context.filetype
						)
					end,
				},
				prompts = {
					{
						role = "system",
						content = "You are a React performance optimization expert who specializes in identifying and fixing performance bottlenecks.",
					},
					{
						role = "user",
						content = function(context)
							local text
							if context.mode == "v" then
								text = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
							else
								local buf_utils = require("codecompanion.utils.buffers")
								text = buf_utils.get_content(context.bufnr)
							end
							return "Analyze this React component and suggest optimizations for:\n- Render performance\n- Memoization opportunities\n- State management\n- Effect cleanup\n- Event handler optimization\n\n```"
								.. context.filetype
								.. "\n"
								.. text
								.. "\n```"
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
			["A11y Check"] = {
				strategy = "chat",
				description = "Check and fix accessibility issues",
				opts = {
					is_slash_cmd = true,
					auto_submit = true,
					short_name = "a11y",
					modes = { "n", "v" },
					condition = function(context)
						return vim.tbl_contains(
							{ "typescript", "typescriptreact", "javascript", "javascriptreact", "html" },
							context.filetype
						)
					end,
				},
				prompts = {
					{
						role = "system",
						content = "You are an accessibility expert who specializes in WCAG guidelines and web accessibility best practices.",
					},
					{
						role = "user",
						content = function(context)
							local text
							if context.mode == "v" then
								text = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
							else
								local buf_utils = require("codecompanion.utils.buffers")
								text = buf_utils.get_content(context.bufnr)
							end
							return "Review this code for accessibility issues and provide fixes for:\n- ARIA attributes\n- Keyboard navigation\n- Screen reader compatibility\n- Color contrast\n- Semantic HTML\n- Focus management\n\n```"
								.. context.filetype
								.. "\n"
								.. text
								.. "\n```"
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
			["Create Hook"] = {
				strategy = "chat",
				description = "Create a custom React hook",
				opts = {
					is_slash_cmd = true,
					auto_submit = false,
					short_name = "hook",
					condition = function(context)
						return vim.tbl_contains({ "typescript", "typescriptreact" }, context.filetype)
					end,
				},
				prompts = {
					{
						role = "system",
						content = "You are an expert React developer who specializes in creating custom hooks with TypeScript.",
					},
					{
						role = "user",
						content = "Create a custom React hook with TypeScript. Include:\n- Proper TypeScript types\n- JSDoc documentation\n- Usage example\n- Error handling\n- Cleanup if needed\n\nHook description:",
					},
				},
			},
			["State Management"] = {
				strategy = "chat",
				description = "Help with React state management",
				opts = {
					is_slash_cmd = true,
					auto_submit = false,
					short_name = "state",
					modes = { "n", "v" },
					condition = function(context)
						return vim.tbl_contains(
							{ "typescript", "typescriptreact", "javascript", "javascriptreact" },
							context.filetype
						)
					end,
				},
				prompts = {
					{
						role = "system",
						content = "You are an expert in React state management patterns and best practices.",
					},
					{
						role = "user",
						content = function(context)
							local text
							if context.mode == "v" then
								text = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
							else
								local buf_utils = require("codecompanion.utils.buffers")
								text = buf_utils.get_content(context.bufnr)
							end
							return "Help me implement state management for this component/feature. Consider:\n- Local vs global state\n- State structure\n- Performance implications\n- TypeScript types\n- State updates and side effects\n\n```"
								.. context.filetype
								.. "\n"
								.. text
								.. "\n```"
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
			["Code Expert"] = {
				strategy = "chat",
				description = "Get expert advice for your code",
				opts = {
					mapping = "<LocalLeader>ce",
					modes = { "n", "v" },
					short_name = "expert",
					auto_submit = true,
					stop_context_insertion = true,
					user_prompt = true,
				},
				prompts = {
					{
						role = "system",
						content = function(context)
							return "I want you to act as a senior "
								.. context.filetype
								.. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
						end,
					},
					{
						role = "user",
						content = function(context)
							local text
							if context.mode == "v" then
								text = require("codecompanion.helpers.actions").get_code(
									context.start_line,
									context.end_line
								)
							else
								local buf_utils = require("codecompanion.utils.buffers")
								text = buf_utils.get_content(context.bufnr)
							end
							return "I have the following code:\n\n```"
								.. context.filetype
								.. "\n"
								.. text
								.. "\n```\n\n"
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
		},
	},
}
