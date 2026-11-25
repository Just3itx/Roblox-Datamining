-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local ItemType = require(scriptParentParent.Enums.ItemType)
local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Symbol = require(scriptParentParent.Symbols.Symbol)

local KeyMappings = require(script.Parent.KeyMappings)

local FormattedParam = Symbol.named("FormattedParam")

local function isFormattedParam(arg1): boolean -- Luacid: unused: defined but never referenced
    return typeof(arg1) == "table" and arg1[FormattedParam] == true
end

local function createFormattedParam(format) -- Luacid: unused: defined but never referenced
    return {
        [FormattedParam] = true,
        format = format
    }
end

local function getLocalizedString(arg1, arg2) -- Luacid: unused: defined but never referenced
    local translations = arg1.translations
    local fallbackTranslations = arg1.fallbackTranslations

    return if fallbackTranslations == nil or translations[arg2] ~= nil then translations[arg2] else fallbackTranslations[arg2]
end

local function addGroupDelimiters(arg1, arg2) -- Luacid: unused: defined but never referenced
    local str1 = string.format("%%1%s%%2", arg2)

    repeat
        local var1
        arg1, var1 = string.gsub(arg1, "^(-?%d+)(%d%d%d)", str1)
    until var1 == 0

    return arg1
end

local module = {}

function module.getKeyFromItemType(bundle)
    assert(
        ItemType.isMember(bundle) or typeof(bundle) == "number" or typeof(bundle) == "string",
        "provided item type " .. tostring(bundle) .. " must be a number, string, or ItemType enum"
    )

    if bundle == ItemType.Bundle then
        return "CoreScripts.PurchasePrompt.ItemType.Bundle"
    end

    return KeyMappings.AssetTypeById[tostring(bundle)]
end

function module.getErrorKey(arg1)
    assert(PurchaseError.isMember(arg1), "provided value " .. tostring(arg1) .. " is not a member of PurchaseError enum")

    return KeyMappings.PurchaseErrorKey[arg1]
end

return module
