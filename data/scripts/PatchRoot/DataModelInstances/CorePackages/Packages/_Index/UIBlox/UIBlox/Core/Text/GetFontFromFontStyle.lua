-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local _validateFontInfo = require(scriptParentParentParent.Core.Style.Validator.validateFontInfo)
local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)

local function getFontFromFontStyle(arg1)
    return arg1.FontFace or arg1.Font
end

return getFontFromFontStyle
