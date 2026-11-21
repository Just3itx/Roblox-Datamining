-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent
local _AvatarExperienceUIKit = require(AvatarExperienceSlotBasedEditorParent.AvatarExperienceUIKit)

local _Types = require(script.Parent.Parent.Types)
local _Categories = require(script.Parent.Parent.Enums.Categories)

local function buildSlotCategoryTabItems(tbl1, tbl2)
    local slotCategoryTabItems = {}
    for id, value2 in tbl1 do
        if not value2.hide then
            table.insert(slotCategoryTabItems, { id = id, text = tbl2[value2.nameTranslationKey] or value2.nameTranslationKey })
        end
    end

    table.sort(slotCategoryTabItems, function(arg1, arg2): boolean
        return tbl1[arg1.id].index < tbl1[arg2.id].index
    end)
    return slotCategoryTabItems
end

return buildSlotCategoryTabItems
