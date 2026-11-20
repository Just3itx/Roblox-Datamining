-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UtilsParent = script:FindFirstAncestor("Utils").Parent
local _Types = require(UtilsParent.Types)
local Utility = require(script.Utility)
local Theme = require(script.Theme)
local defaultTokenColors = require(script.Theme.defaultTokenColors)

local module = {
    defaultLexer = require(script.Lexer)
}

function module.highlight(str1: string, arg1)
    if arg1 then
        Theme.setColors(arg1)
    else
        Theme.setColors(defaultTokenColors)
    end
    str1 = Utility.convertTabsToSpaces(Utility.removeControlChars(str1))
    local defaultLexer = module.defaultLexer
    local color = Theme.getColor("iden")
    local str2 = ""
    for value, value2 in defaultLexer.scan(str1) do
        local var1 = Theme.getColor(value) or color
        str2 ..= Theme.getColoredRichText(var1, Utility.sanitizeRichText(value2))
    end
    return str2
end

function module.getTokenColor(arg1)
    return Theme.getColor(arg1)
end

return module
