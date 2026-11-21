-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)
local _Categories = require(script.Parent.Parent.Enums.Categories)

local function buildSlotCategoryLocalizationKeys(tbl1)
    local slotCategoryLocalizationKeys = {}
    for _, value in tbl1 do
        if not value.hide then
            slotCategoryLocalizationKeys[value.nameTranslationKey] = value.nameTranslationKey
        end
    end
    return slotCategoryLocalizationKeys
end

return buildSlotCategoryLocalizationKeys
