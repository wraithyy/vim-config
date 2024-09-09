vim.diagnostic.config({
	severity_sort = true,
	signs = {
		severity_sort = true,
	}
})
vim.fn.sign_define(
	'DiagnosticSignError',
	{ text = '', texthl = 'LspDiagnosticsDefaultError' }
)

vim.fn.sign_define(
	'DiagnosticSignWarn',
	{ text = '', texthl = 'LspDiagnosticsDefaultWarning' }
)

vim.fn.sign_define(
	'DiagnosticSignInfo',
	{ text = '', texthl = 'LspDiagnosticsDefaultInformation' }
)


vim.fn.sign_define(
	'DiagnosticSignHint',
	{ text = '', texthl = 'LspDiagnosticsDefaultHint' }
)
