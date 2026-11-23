-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local getItemThumbnailUrl = require(AvatarExperienceInspectAndBuy.Utils.getItemThumbnailUrl)

local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum
local AvatarBackground = AXCommon.Constants.ASSET_TYPE_NAME_TO_ID_STRING.AvatarBackground

local function getTryOnBackgroundImage(arg1)
    if arg1 == nil or arg1.itemType ~= ItemTypeEnum.Asset or arg1.itemSubType ~= AvatarBackground then
        return nil
    end
    return getItemThumbnailUrl({ itemType = arg1.itemType, id = arg1.itemId })
end

return getTryOnBackgroundImage
