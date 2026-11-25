-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local AvatarExperienceAnalytics = require(ProfilePlatformParent.AvatarExperienceAnalytics)
local AvatarExperienceNavigation = require(ProfilePlatformParent.AvatarExperienceNavigation)
local _AvatarExperienceModel = require(ProfilePlatformParent.AvatarExperienceModel)

local Enums = require(ProfilePlatform.Common.Enums)

local sendUnifiedEventLog = AvatarExperienceAnalytics.sendUnifiedEventLog
local sendPassthroughUnifiedEventLog = AvatarExperienceAnalytics.sendPassthroughUnifiedEventLog
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceAnalytics.Flags.FFlagAXUnifiedEventStrictPayloads
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local _MarketplaceUnifiedAction = UnifiedEventLogEnums.MarketplaceUnifiedAction
local UnifiedLoggingSurface = AvatarExperienceNavigation.Enums.UnifiedLoggingSurface

local function sendProfilePurchaseEvents(action, tbl1, community)
    local surface = if community == Enums.ProfileTypes.Community then UnifiedLoggingSurface.COMMUNITY_PROFILE else UnifiedLoggingSurface.USER_PROFILE

    for _, value in tbl1 do
        local bool1 = value.itemType == Enums.ItemTypes.Bundle

        if FFlagAXUnifiedEventStrictPayloads then
            sendPassthroughUnifiedEventLog({
                action = action,
                surface = surface,
                itemId = value.itemId,
                itemType = if bool1 then UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE else UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET,
                assetType = if bool1 then nil else value.itemSubType,
                bundleType = if bool1 then value.itemSubType else nil,
                organicItemPrice = value.priceInRobux
            })
        else
            sendUnifiedEventLog({
                action = action,
                surface = surface,
                itemId = value.itemId,
                itemType = if bool1 then UnifiedEventLogEnums.MarketplaceUnifiedItemType.BUNDLE else UnifiedEventLogEnums.MarketplaceUnifiedItemType.ASSET,
                assetType = if bool1 then nil else value.itemSubType,
                bundleType = if bool1 then value.itemSubType else nil,
                organicItemPrice = value.priceInRobux
            })
        end
    end
end

return sendProfilePurchaseEvents
