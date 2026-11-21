-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:30:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceSave = script:FindFirstAncestor("AvatarExperienceSave")
local AvatarExperienceSaveParent = AvatarExperienceSave.Parent

local tutils = require(AvatarExperienceSaveParent.tutils)

local _AvatarSaveContext = require(AvatarExperienceSave.Context.AvatarSaveContext)
local FFlagAXBackgroundsPersistence = require(AvatarExperienceSaveParent.AvatarExperienceFlags).FFlagAXBackgroundsPersistence

local bool1 = game:DefineFastFlag("AXFixEmptyDictionaryKeysForSaveDict2", false)

local function filterEmptyDicts(tbl1)
    local var1 = table.clone(tbl1)
    for value, value2 in var1 do
        if type(value2) == "table" and next(value2) == nil then
            var1[value] = nil
        end
    end
    return var1
end

local function deepEqualWithoutEmptyDicts(tbl1, tbl2) -- Luacid: unused: defined but never referenced
    local var1 = filterEmptyDicts(tbl1)
    local var2 = filterEmptyDicts(tbl2)
    return tutils.deepEqual(var1, var2)
end

local function getSaveDict(arg1, arg2)
    local equipped = arg1.equipped
    local equipped2 = arg2.equipped
    local background = if FFlagAXBackgroundsPersistence then equipped.BackgroundAssetId ~= equipped2.BackgroundAssetId else nil

    if not bool1 then
        return {
            BodyColors = not tutils.deepEqual(equipped.BodyColor3s, equipped2.BodyColor3s),
            AvatarType = equipped.AvatarType ~= equipped2.AvatarType,
            Scales = not tutils.deepEqual(equipped.AvatarScales, equipped2.AvatarScales),
            Assets = equipped.EquippedAssets and not tutils.deepEqual(equipped.EquippedAssets, equipped2.EquippedAssets),
            Emotes = not tutils.deepEqual(equipped.EquippedEmotes.slotInfo, equipped2.EquippedEmotes.slotInfo),
            Background = background
        }
    end

    local tbl1 = {
        BodyColors = 0,
        AvatarType = 0,
        Scales = 0,
        Assets = 0,
        Emotes = 0,
        Background = 0
    }
    local bodyColor3s = equipped.BodyColor3s
    local bodyColor3s2 = equipped2.BodyColor3s
    local var1 = filterEmptyDicts(bodyColor3s)
    local var2 = filterEmptyDicts(bodyColor3s2)
    tbl1.BodyColors = not tutils.deepEqual(var1, var2)
    tbl1.AvatarType = equipped.AvatarType ~= equipped2.AvatarType
    local avatarScales = equipped.AvatarScales
    local avatarScales2 = equipped2.AvatarScales
    local var3 = filterEmptyDicts(avatarScales)
    local var4 = filterEmptyDicts(avatarScales2)
    tbl1.Scales = not tutils.deepEqual(var3, var4)
    local equippedAssets = equipped.EquippedAssets

    if equippedAssets then
        local equippedAssets2 = equipped.EquippedAssets
        local equippedAssets3 = equipped2.EquippedAssets
        local var5 = filterEmptyDicts(equippedAssets2)
        local var6 = filterEmptyDicts(equippedAssets3)
        equippedAssets = not tutils.deepEqual(var5, var6)
    end

    tbl1.Assets = equippedAssets

    local slotInfo = equipped.EquippedEmotes.slotInfo
    local slotInfo2 = equipped2.EquippedEmotes.slotInfo
    local var5 = filterEmptyDicts(slotInfo)
    local var6 = filterEmptyDicts(slotInfo2)
    tbl1.Emotes = not tutils.deepEqual(var5, var6)

    tbl1.Background = background
    return tbl1
end

return getSaveDict
