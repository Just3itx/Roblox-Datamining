-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local AvatarExperienceAnalytics = require(InExperienceShopParent.AvatarExperienceAnalytics)
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local MarketplaceUnifiedActionNumbers = UnifiedEventLogEnums.MarketplaceUnifiedActionNumbers
local MarketplaceUnifiedItemType = UnifiedEventLogEnums.MarketplaceUnifiedItemType
local sendPassthroughUnifiedEventLog = AvatarExperienceAnalytics.sendPassthroughUnifiedEventLog
local sendUnifiedEventLog = AvatarExperienceAnalytics.sendUnifiedEventLog

local getShopUnifiedLoggingSurface = require(script.Parent.getShopUnifiedLoggingSurface)

return {
    send = function(tbl1)
        local tbl2 = {
            action = tbl1.action,
            surface = getShopUnifiedLoggingSurface(tbl1.shopPageType),
            itemId = tbl1.itemId,
            itemType = MarketplaceUnifiedItemType.GAME_PASS,
            elementName = tbl1.elementName,
            universeId = if tbl1.universeId ~= nil then tbl1.universeId else game.GameId
        }
        if tbl1.trialStatus ~= nil then
            tbl2.trialStatus = tbl1.trialStatus
        end
        if tbl1.metadata ~= nil then
            tbl2.elementMetadata = HttpService:JSONEncode(tbl1.metadata)
        end

        if AvatarExperienceAnalytics.Flags.FFlagAXUnifiedEventStrictPayloads then
            sendPassthroughUnifiedEventLog(tbl2)
            return
        end
        sendUnifiedEventLog(tbl2)
    end,
    clickAction = MarketplaceUnifiedActionNumbers.UI_ELEMENT_CLICK,
    impressionAction = MarketplaceUnifiedActionNumbers.UI_ELEMENT_IMPRESSION,
    successAction = 12,
    failureAction = 13,
    trialElement = "GAME_PASS_TRIAL"
}
