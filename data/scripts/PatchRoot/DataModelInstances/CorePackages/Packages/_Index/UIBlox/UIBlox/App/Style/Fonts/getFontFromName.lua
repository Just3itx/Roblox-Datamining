-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local validateFont = require(scriptParentParent.Validator.validateFont)
local FontLoader = require(script.Parent.FontLoader)
local _StyleTypes = require(scriptParentParent.StyleTypes)

return function(arg1, arg2)
    local fontLoader = FontLoader.new(arg2)
    local tbl1 = {
        [Constants.FontName.Gotham:lower()] = fontLoader:loadFont(),
        [Constants.FontName.Classic:lower()] = fontLoader:loadFont(Enum.Font.Cartoon)
    }
    local var1 = if arg1 == nil or not (#arg1 > 0) then nil else tbl1[arg1:lower()]

    if var1 == nil then
        var1 = tbl1[Constants.DefaultFontName:lower()]
    end

    assert(validateFont(var1))
    return var1
end
