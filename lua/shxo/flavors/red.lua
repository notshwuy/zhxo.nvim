local shade = require("shxo.utils").shade

return {
	-- background colors
	bg = shade("#343434", 0.5),
	bgDark = shade("#343434", 0.4),
	bgDarker = shade("#343434", 0.6),
	bgFloat = shade("#343434", 0.7),
	bgOption = "#343434",

	-- foreground colors
	fg = "#fefefe",
	fgAlt = "#f7eae2",
	fgCommand = "#fefefe",
	fgInactive = shade("#fefefe", 0.6),
	fgDisabled = shade("#fefefe", 0.4),
	fgLineNr = shade("#858585", 0.7),
	fgSelection = shade("#ffffff", 0.9),
	fgSelectionInactive = shade("#ffffff", 0.3),

	-- border colors
	border = shade("#858585", 0.7),
	borderFocus = shade("#858585", 0.9),
	borderDarker = shade("#858585", 0.6),

	-- ui colors
	red = "#e08282",
	blue = "#7577ff",
	orange = "#e29a5b",
	purple = "#cbbce6",
	blueLight = "#7577ff",
	orangeLight = "#f47771",
	yellow = "#f7eae2",
  redDark = shade("#f41777", 0.9),
	green = "#6ff2ae",
	purpleDark = "#7577ff",
	comment = "#9a9ea3",
	symbol = "#ababab",
	primary = "#e08282",
	terminalBrightBlack = "#414141",
}
