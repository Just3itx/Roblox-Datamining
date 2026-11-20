-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FoundationParent = script:FindFirstAncestor("Foundation").Parent
local BuilderIcons = require(FoundationParent.BuilderIcons)
local Font = BuilderIcons.Font
local IconVariant = BuilderIcons.IconVariant

local function getIconRichText(str1: string, arg1): string
    local var1 = arg1 or IconVariant.Regular
    local var2 = Font[var1]

    return `<font family="{var2.Family}" weight="{var2.Weight.Value}">{str1}</font>`
end

return getIconRichText
