-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local AvatarExperienceSaveParent = AvatarExperienceSave.Parent
local tutils = require(AvatarExperienceSaveParent.tutils)

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)

local function checkCharacterDataHasTryOnItems(arg1): boolean
    local var1 = arg1.tryOn.OutfitTryOn and arg1.tryOn.OutfitTryOn.TryOnItems or {}
    return tutils.fieldCount(var1) > 0
end

return checkCharacterDataHasTryOnItems
