-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:01:27Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local _ColorMode = require(Foundation.Enums.ColorMode)
local _Device = require(Foundation.Enums.Device)
local _ThemeName = require(Foundation.Enums.ThemeName)
local TokenProcessingUtilities = require(Foundation.Providers.Style.Tokens.TokenProcessingUtilities)
local Tokens = require(Foundation.Providers.Style.Tokens)

local function tokenPathToAttributeBase(str1: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return str1:gsub("%.", ""):gsub("_", "")
end

local function emitLeafAttributes(tbl1, str1: string, arg1)
    if type(arg1) == "table" then
        for value, value2 in arg1 do
            emitLeafAttributes(tbl1, str1 .. tostring(value), value2)
        end

        return
    end

    tbl1[str1] = arg1
end

local function getOverrideAttributes(arg1, arg2, arg3, arg4)
    local overrideAttributes = {}

    if not (arg4 and next(arg4)) then
        return overrideAttributes
    end

    local tokens = Tokens.getTokens(arg2, arg3, 1, nil, arg1)

    for value, value2 in arg4 do
        local var1 = TokenProcessingUtilities.resolveTokenOverride(tokens, value, value2)
        if var1 ~= nil then
            emitLeafAttributes(overrideAttributes, tokenPathToAttributeBase(value), var1)
        end
    end

    return overrideAttributes
end

return getOverrideAttributes
