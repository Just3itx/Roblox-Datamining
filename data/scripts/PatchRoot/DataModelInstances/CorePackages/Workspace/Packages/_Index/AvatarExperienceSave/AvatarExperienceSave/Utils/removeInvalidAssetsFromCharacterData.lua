-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")

local AvatarExperienceSaveParent = AvatarExperienceSave.Parent
local tutils = require(AvatarExperienceSaveParent.tutils)

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)

local function removeInvalidAssetsFromCharacterData(arg1, tbl1)
    local bool1 = false
    for value, value2 in tbl1 do
        if not (arg1.equipped.EquippedAssets[value2] and arg1.equipped.EquippedAssets[value2][value]) then
            continue
        end
        bool1 = true
        arg1.equipped.EquippedAssets[value2][value] = nil

        if tutils.fieldCount(arg1.equipped.EquippedAssets[value2]) == 0 then
            arg1.equipped.EquippedAssets[value2] = nil
        end
    end

    return arg1, bool1
end

return removeInvalidAssetsFromCharacterData
