-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")

local isMakeupAssetType = require(AvatarExperienceCommon.Utils.isMakeupAssetType)
local selectTryOnItems = require(script.Parent.selectTryOnItems)

local function selectHasMakeupTryOn(arg1)
    for _, value in selectTryOnItems(arg1) do
        if value.selectedInTryOnManager and value.itemType and isMakeupAssetType(value.itemSubType) then
            return true
        end
    end
    return false
end

return selectHasMakeupTryOn
