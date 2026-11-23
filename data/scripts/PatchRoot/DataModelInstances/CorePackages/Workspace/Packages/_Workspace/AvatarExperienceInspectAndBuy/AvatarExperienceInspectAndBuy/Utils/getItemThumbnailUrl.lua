-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel)
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum

local function getItemThumbnailUrl(arg1)
    if arg1.itemType == ItemTypeEnum.Bundle then
        return "rbxthumb://type=BundleThumbnail&id=" .. arg1.id .. "&w=420&h=420"
    end

    if arg1.itemType == ItemTypeEnum.Asset then
        return "rbxthumb://type=Asset&id=" .. arg1.id .. "&w=420&h=420"
    end

    return nil
end

return getItemThumbnailUrl
