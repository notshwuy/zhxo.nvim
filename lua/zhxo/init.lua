local colors = require("zhxo.colors")
local config = require("zhxo.config")
local utils = require("zhxo.utils")
local bufferline = require("zhxo.integrations.bufferline")
local cmp = require("zhxo.integrations.cmp")
local theme = {}

local function set_terminal_colors()
	vim.g.terminal_color_0 = colors.bg
	vim.g.terminal_color_1 = colors.red
	vim.g.terminal_color_2 = colors.green
	vim.g.terminal_color_3 = colors.yellow
	vim.g.terminal_color_4 = colors.blue
	vim.g.terminal_color_5 = colors.purple
	vim.g.terminal_color_6 = colors.blueLight
	vim.g.terminal_color_7 = colors.fg
	vim.g.terminal_color_8 = colors.fgInactive
	vim.g.terminal_color_9 = colors.error
	vim.g.terminal_color_10 = colors.orangeLight
	vim.g.terminal_color_11 = colors.orange
	vim.g.terminal_color_12 = colors.symbol
	vim.g.terminal_color_13 = colors.red
	vim.g.terminal_color_14 = colors.orangeLight
	vim.g.terminal_color_15 = colors.comment
	vim.g.terminal_color_background = colors.bg
	vim.g.terminal_color_foreground = colors.fg
end

local function set_groups()
	local bg = config.transparent and "NONE" or colors.bg
	local diff_add = utils.shade(colors.green, 0.5, colors.bg)
	local diff_delete = utils.shade(colors.red, 0.5, colors.bg)
	local diff_change = utils.shade(colors.blue, 0.5, colors.bg)
	local diff_text = utils.shade(colors.yellow, 0.5, colors.bg)

	local groups = {
		-- base
		Normal = { fg = colors.fg, bg = bg },
		LineNr = { fg = colors.fgLineNr },
		ColorColumn = { bg = utils.shade(colors.blueLight, 0.5, colors.bg) },
		Conceal = {},
		Cursor = { fg = colors.bg, bg = colors.fg },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },
		CursorLine = { bg = colors.bgOption },
		CursorColumn = { link = "CursorLine" },
		Directory = { fg = colors.blue },
		DiffAdd = { bg = bg, fg = diff_add },
		DiffChange = { bg = bg, fg = diff_change },
		DiffDelete = { bg = bg, fg = diff_delete },
		DiffText = { bg = bg, fg = diff_text },
		EndOfBuffer = { fg = colors.purple },
		TermCursor = { link = "Cursor" },
		TermCursorNC = { link = "Cursor" },
		ErrorMsg = { fg = colors.error },
		VertSplit = { fg = colors.border, bg = bg },
		Winseparator = { link = "VertSplit" },
		SignColumn = { link = "Normal" },
		Folded = { fg = colors.fg, bg = colors.bgDarker },
		FoldColumn = { link = "SignColumn" },
		IncSearch = { bg = utils.mix(colors.blue, colors.bg, math.abs(0.30)), fg = colors.bg },
		Substitute = { link = "IncSearch" },
		CursorLineNr = { fg = colors.fgSelection },
		MatchParen = { fg = colors.red, bg = bg },
		ModeMsg = { link = "Normal" },
		MsgArea = { link = "Normal" },
		-- MsgSeparator = {},
		MoreMsg = { fg = colors.blue },
		NonText = { fg = utils.shade(colors.bg, 0.30) },
		NormalFloat = { bg = colors.bgFloat },
		NormalNC = { link = "Normal" },
		Pmenu = { link = "NormalFloat" },
		PmenuSel = { bg = colors.bgOption },
		PmenuSbar = { bg = utils.shade(colors.blue, 0.5, colors.bg) },
		PmenuThumb = { bg = utils.shade(colors.bg, 0.20) },
		Question = { fg = colors.blue },
		QuickFixLine = { fg = colors.blue },
		SpecialKey = { fg = colors.symbol },
		StatusLine = { fg = colors.fg, bg = bg },
		StatusLineNC = { fg = colors.fgInactive, bg = colors.bgDark },
		TabLine = { bg = colors.bgDark, fg = colors.fgInactive },
		TabLineFill = { link = "TabLine" },
		TabLineSel = { bg = colors.bg, fg = colors.fgAlt },
		Search = { bg = utils.shade(colors.orangeLight, 0.40, colors.bg) },
		SpellBad = { undercurl = true, sp = colors.error },
		SpellCap = { undercurl = true, sp = colors.blue },
		SpellLocal = { undercurl = true, sp = colors.purple },
		SpellRare = { undercurl = true, sp = colors.yellow },
		Title = { fg = colors.blue },
		Visual = { bg = utils.shade(colors.blue, 0.40, colors.bg) },
		VisualNOS = { link = "Visual" },
		WarningMsg = { fg = colors.warn },
		Whitespace = { fg = colors.symbol },
		WildMenu = { bg = colors.bgOption },
		Comment = { fg = colors.comment, italic = config.italics.comments or false },

		Constant = { fg = colors.fg },
		String = { fg = colors.green, italic = config.italics.strings or false },
		Character = { fg = colors.fg },
		Number = { fg = colors.primary, bold = true },
		Boolean = { fg = colors.blue },
		Float = { link = "Number" },

		Identifier = { fg = colors.fg },
		Function = { fg = colors.fg },
		Method = { fg = colors.purple },
		Property = { fg = colors.yellow },
		Field = { link = "Property" },
		Parameter = { fg = colors.fg },
		Statement = { fg = colors.red },
		Conditional = { fg = colors.red },
		-- Repeat = {},
		Label = { fg = colors.yellow },
		Operator = { fg = colors.red },
		Keyword = { link = "Statement", italic = config.italics.keywords or false },
		Exception = { fg = colors.red },

		PreProc = { link = "Keyword" },
		-- Include = {},
		Define = { fg = colors.purple },
		Macro = { link = "Define" },
		PreCondit = { fg = colors.red },

		Type = { fg = colors.fg },
		Struct = { link = "Type" },
		Class = { link = "Type" },

		-- StorageClass = {},
		-- Structure = {},
		-- Typedef = {},

		Attribute = { link = "Character" },
		Punctuation = { fg = colors.symbol },
		Special = { fg = colors.symbol },

		SpecialChar = { fg = colors.red },
		Tag = { fg = colors.red },
		Delimiter = { fg = colors.symbol },
		-- SpecialComment = {},
		Debug = { fg = colors.purpleDark },

		Underlined = { underline = true },
		Bold = { bold = true },
		Italic = { italic = true },
		Ignore = { fg = colors.bg },
		Error = { link = "ErrorMsg" },
		Todo = { fg = colors.blue, bold = true },

		-- LspReferenceText = {},
		-- LspReferenceRead = {},
		-- LspReferenceWrite = {},
		-- LspCodeLens = {},
		-- LspCodeLensSeparator = {},
		-- LspSignatureActiveParameter = {},

		DiagnosticError = { link = "Error" },
		DiagnosticWarn = { link = "WarningMsg" },
		DiagnosticInfo = { fg = colors.info },
		DiagnosticHint = { fg = colors.hint },
		DiagnosticVirtualTextError = { link = "DiagnosticError" },
		DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
		DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
		DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
		DiagnosticUnderlineError = { undercurl = true, link = "DiagnosticError" },
		DiagnosticUnderlineWarn = { undercurl = true, link = "DiagnosticWarn" },
		DiagnosticUnderlineInfo = { undercurl = true, link = "DiagnosticInfo" },
		DiagnosticUnderlineHint = { undercurl = true, link = "DiagnosticHint" },
		-- DiagnosticFloatingError = {},
		-- DiagnosticFloatingWarn = {},
		-- DiagnosticFloatingInfo = {},
		-- DiagnosticFloatingHint = {},
		-- DiagnosticSignError = {},
		-- DiagnosticSignWarn = {},
		-- DiagnosticSignInfo = {},
		-- DiagnosticSignHint = {},

		["@text"] = { fg = colors.fg },
		["@texcolors.literal"] = { link = "Property" },
		-- ["@texcolors.reference"] = {},
		["@texcolors.strong"] = { link = "Bold" },
		["@texcolors.italic"] = { link = "Italic" },
		["@texcolors.title"] = { link = "Keyword" },
		["@texcolors.uri"] = { fg = colors.blue, sp = colors.blue, underline = true },
		["@texcolors.underline"] = { link = "Underlined" },
		["@symbol"] = { fg = colors.symbol },
		["@texcolors.todo"] = { link = "Todo" },
		["@comment"] = { link = "Comment" },
		["@punctuation"] = { link = "Punctuation" },
		["@punctuation.bracket"] = { fg = colors.symbol },
		["@punctuation.delimiter"] = { link = "Delimiter" },
		["@punctuation.separator.keyvalue"] = { fg = colors.symbol },

		["@texcolors.diff.add"] = { fg = colors.green },
		["@texcolors.diff.delete"] = { fg = colors.red },

		["@constant"] = { link = "Constant" },
		["@constancolors.builtin"] = { link = "Keyword" },
		-- ["@constancolors.macro"] = {},
		-- ["@define"] = {},
		-- ["@macro"] = {},
		["@string"] = { link = "String" },
		["@string.escape"] = { fg = utils.shade(colors.green, 0.75) },
		["@string.special"] = { fg = utils.shade(colors.green, 0.65) },
		-- ["@character"] = {},
		-- ["@character.special"] = {},
		["@number"] = { link = "Number" },
		["@boolean"] = { link = "Boolean" },
		-- ["@float"] = {},
		["@function"] = { link = "Function", italic = config.italics.functions or false },
		["@function.call"] = { fg = colors.purple },
		["@function.builtin"] = { fg = colors.purple },
		["@function.method.call"] = { fg = colors.purple },
		-- ["@function.macro"] = {},
		["@parameter"] = { link = "Parameter" },
		["@method"] = { link = "Method" },
		["@field"] = { link = "Property" },
		["@property"] = { link = "Property" },
		["@constructor"] = { fg = colors.purple },
		-- ["@conditional"] = {},
		-- ["@repeat"] = {},
		["@label"] = { link = "Label" },
		["@operator"] = { link = "Operator" },
		["@exception"] = { link = "Exception" },
		["@variable"] = { fg = colors.fg, italic = config.italics.variables or false },
		["@variable.builtin"] = { fg = colors.fg, italic = config.italics.variables or false },
		["@type"] = { link = "Type" },
		["@type.definition"] = { fg = colors.fg },
		["@type.builtin"] = { fg = colors.yellow },
		["@type.qualifier"] = { fg = colors.primary },
		["@keyword"] = { link = "Keyword" },
		-- ["@storageclass"] = {},
		-- ["@structure"] = {},
		["@namespace"] = { link = "Type" },
		["@annotation"] = { link = "Label" },
		-- ["@include"] = {},
		-- ["@preproc"] = {},
		["@debug"] = { fg = colors.purpleDark },
		["@tag"] = { link = "Tag" },
		["@tag.delimiter"] = { fg = colors.symbol },
		["@tag.attribute"] = { fg = colors.yellow },
		["@attribute"] = { link = "Attribute" },
		["@error"] = { link = "Error" },
		["@warning"] = { link = "WarningMsg" },
		["@info"] = { fg = colors.blue },

		-- Specific languages
		-- overrides
		["@label.json"] = { fg = colors.property }, -- For json
		["@label.help"] = { link = "@texcolors.uri" }, -- For help files
		["@texcolors.uri.html"] = { underline = true }, -- For html

		-- semantic highlighting
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.type"] = { link = "@type" },
		["@lsp.type.class"] = { link = "@method" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.interface"] = { link = "@type" },
		["@lsp.type.struct"] = { link = "@type" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.enumMember"] = { link = "@constant" },
		["@lsp.type.function"] = { fg = colors.purple },
		["@lsp.type.method"] = { link = "@method" },
		["@lsp.type.macro"] = { link = "@label" },
		["@lsp.type.decorator"] = { link = "@label" },
		["@lsp.typemod.function.declaration"] = { link = "@function" },
		["@lsp.typemod.function.readonly"] = { link = "@function" },
		["@lsp.typemod.class.declaration"] = { link = "@type" },
	}

  -- integrations
  groups = vim.tbl_extend("force", groups, cmp.highlights())

  -- overrides
	groups =
		vim.tbl_extend("force", groups, type(config.overrides) == "function" and config.overrides() or config.overrides)

	for group, parameters in pairs(groups) do
		vim.api.nvim_set_hl(0, group, parameters)
	end
end

function theme.setup(values)
	setmetatable(config, { __index = vim.tbl_extend("force", config.defaults, values) })

	theme.bufferline = { highlights = {} }
	theme.bufferline.highlights = bufferline.highlights(config)
end

function theme.colorscheme()
	if vim.version().minor < 8 then
		vim.notify("Neovim 0.8+ is required for zhxo colorscheme", vim.log.levels.ERROR, { title = "Min Theme" })
		return
	end

	vim.api.nvim_command("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.api.nvim_command("syntax reset")
	end

	vim.g.VM_theme_set_by_colorscheme = true -- Required for Visual Multi
	vim.o.termguicolors = true
	vim.g.colors_name = "zhxo"

	set_terminal_colors()
	set_groups()
end

return theme
