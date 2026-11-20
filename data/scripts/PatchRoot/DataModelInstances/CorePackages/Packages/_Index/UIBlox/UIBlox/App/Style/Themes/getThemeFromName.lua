-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local Constants = require(scriptParentParent.Constants)
local validateTheme = require(scriptParentParent.Validator.validateTheme)

local tbl1 = {
    [Constants.ThemeName.Dark:lower()] = require(scriptParent.DarkTheme),
    [Constants.ThemeName.Light:lower()] = require(scriptParent.LightTheme)
}

return function(str1: string)
    local var1 = if str1 == nil or not (#str1 > 0) then nil else tbl1[str1:lower()]

    if var1 == nil then
        var1 = tbl1[Constants.DefaultThemeName:lower()]
    end
    assert(validateTheme(var1))
    return var1
end
