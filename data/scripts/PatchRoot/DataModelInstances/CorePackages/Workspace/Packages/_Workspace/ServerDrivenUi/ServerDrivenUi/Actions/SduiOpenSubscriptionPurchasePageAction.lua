-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent

local AppPage = require(ServerDrivenUiParent.RobloxAppEnums).AppPage

local DataHydration = require(ServerDrivenUiParent.DataHydration)

local FFlagSduiSubscriptionCellPostPurchaseSync = require(ServerDrivenUiParent.SharedFlags).FFlagSduiSubscriptionCellPostPurchaseSync

local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local function buildSubscriptionProductInfo(arg1)
    return {
        name = arg1.name or "",
        description = arg1.description or "",
        iconImageAssetId = tonumber(arg1.imageAssetId) or 0,
        subscriptionPeriod = arg1.periodType or "",
        displayPrice = arg1.priceDisplay or "",
        priceInRobux = tonumber(arg1.priceInRobux),
        priceTier = tonumber(arg1.priceTier) or 0,
        subscriptionProviderName = arg1.creatorName or "",
        subscriptionProviderId = arg1.universeId,
        isForSale = true,
        subscriptionTargetKey = arg1.subscriptionId
    }
end

return function(arg1, _, arg2)
    local logger = arg2.dependencies.logger
    local appPage = arg2.appPage

    local actionParams = arg1 and arg1.actionParams
    if actionParams == nil then
        logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenSubscriptionPurchasePage,
                message = "Missing actionParams"
            },
            appPage
        )

        return
    end

    local subscriptionId = actionParams.subscriptionId
    local universeId = actionParams.universeId

    if typeof(subscriptionId) ~= "string" or subscriptionId == "" then
        logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenSubscriptionPurchasePage,
            message = "Missing or invalid subscriptionId",
            propName = "subscriptionId"
        }, appPage)
        return
    end

    if typeof(universeId) ~= "string" or universeId == "" then
        logger.reportError(SduiErrorType.InvalidActionParams, {
            name = SduiActionType.OpenSubscriptionPurchasePage,
            message = "Missing or invalid universeId",
            propName = "universeId"
        }, appPage)
        return
    end

    local thumbnailString = actionParams.thumbnailString or ""
    local bool1 = actionParams.isSubscribed == true
    local extraProps = {
        subscriptionPurchaseProductInfo = buildSubscriptionProductInfo(actionParams),
        thumbnailString = thumbnailString,
        isSubScribed = bool1,
        isSubscribed = bool1,
        creatorName = actionParams.creatorName,
        creatorVerified = actionParams.creatorVerified,
        onPurchaseSuccess = FFlagSduiSubscriptionCellPostPurchaseSync and function()
            DataHydration.Game.getGameSubscriptionStore(false).updateGameSubscriptionInfo(subscriptionId, { isSubscribed = true })
        end or nil
    }

    arg2.dependencies.getNavigation().push(AppPage.SubscriptionPurchase, { extraProps = extraProps })
end
