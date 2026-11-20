-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UtilsParent = script:FindFirstAncestor("Utils").Parent
local defaultTokenColors = require(script.defaultTokenColors)

local _Types = require(UtilsParent.Types)

local module = {
    tokenColors = {},
    defaultColors = defaultTokenColors
}

function module.setColors(arg1)
    assert(type(arg1) == "table", "Theme.updateColors expects a table")

    for value, value2 in arg1 do
        module.tokenColors[value] = value2
    end
end

function module.getColoredRichText(color3: Color3, str1: string): string
    return "<font color=\"#" .. color3:ToHex() .. "\">" .. str1 .. "</font>"
end

function module.getColor(arg1)
    return module.tokenColors[arg1]
end

module.setColors(defaultTokenColors)

return module
