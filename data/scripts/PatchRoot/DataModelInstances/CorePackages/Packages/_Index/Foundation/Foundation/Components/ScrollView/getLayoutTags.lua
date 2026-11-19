-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:41:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local Tokens = require(Foundation.Providers.Style.Tokens)
local attributeRules = require(Foundation.StyleSheet.Rules.attributeRules)
local formatTokens = require(Foundation.StyleSheet.formatTokens)

local function getLayoutTags()
    local layoutTags = {}

    local defaultTokens = Tokens.defaultTokens
    local var1 = formatTokens(defaultTokens)

    local _, var2 = attributeRules.rulesGenerator(defaultTokens, var1)

    for _, value in var2 do
        if value.pseudo == "UIListLayout" and value.tag then
            layoutTags[value.tag] = true
        end
    end

    return layoutTags
end

return getLayoutTags
