-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local getPresetIconRichText = require(ExpChatParent.ExpChatShared).getPresetIconRichText

local function getIconSuffix(num1: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return ` {getPresetIconRichText(num1)}`
end

return {
    decorate = function(str1: string, num1: number): string
        return str1 .. getIconSuffix(num1)
    end,
    undecorate = function(str1: string, num1: number): string
        local iconSuffix = getIconSuffix(num1)

        if string.sub(str1, -#iconSuffix) ~= iconSuffix then
            return str1
        end

        return string.sub(str1, 1, #str1 - #iconSuffix)
    end
}
