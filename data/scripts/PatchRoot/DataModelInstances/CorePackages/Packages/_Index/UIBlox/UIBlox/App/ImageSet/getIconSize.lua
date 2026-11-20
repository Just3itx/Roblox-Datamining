-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local scriptParentParentParent = scriptParent.Parent.Parent
local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)

local IconSize = require(scriptParent.Enum.IconSize)

local tbl1 = {
    [IconSize.Small] = 16,
    [IconSize.Medium] = 36,
    [IconSize.Large] = 48,
    [IconSize.XLarge] = 96,
    [IconSize.XXLarge] = 192
}

return function(num1: number, arg1)
    assert(IconSize.isEnumValue(num1))

    if arg1 == nil or arg1.Tokens == nil then
        return tbl1[num1]
    end

    if num1 == IconSize.Small then
        return arg1.Tokens.Size.Size_400
    end

    if num1 == IconSize.Medium then
        return arg1.Tokens.Size.Size_900
    end

    if num1 == IconSize.Large then
        return arg1.Tokens.Size.Size_1200
    end

    if num1 == IconSize.XLarge then
        return arg1.Tokens.Size.Size_2400
    end

    if num1 == IconSize.XXLarge then
        return 192
    end

    return nil
end
