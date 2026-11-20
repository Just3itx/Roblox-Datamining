-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Constants = require(script.Parent.Constants)
local _StyleTypes = require(script.Parent.StyleTypes)

return function(tbl1)
    local var1 = tbl1 and tbl1.nameTopPadding or Constants.NAME_TOP_PADDING
    local var2 = tbl1 and tbl1.contextualTopPadding or Constants.CONTEXTUAL_TOP_PADDING
    local var3 = tbl1 and tbl1.maxLinesNumber or Constants.LINES_MAX

    local font = tbl1.font
    local var4 = font.BaseSize * font.CaptionHeader.RelativeSize
    local var5 = font.BaseSize * font.CaptionBody.RelativeSize * var3

    return var1 + var4 + var2 + var5
end
