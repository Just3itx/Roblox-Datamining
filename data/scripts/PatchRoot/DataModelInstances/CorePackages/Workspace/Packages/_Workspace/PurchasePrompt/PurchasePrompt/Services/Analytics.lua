-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local _getPaymentPlatform = require(scriptParentParent.Utils.getPaymentPlatform)

local GetFFlagEnableLuobuInGameUpsell = require(scriptParentParent.Flags.GetFFlagEnableLuobuInGameUpsell)
local GetFFlagUsePlatformNameForUnknown = require(scriptParentParent.Flags.GetFFlagUsePlatformNameForUnknown)
local GetFFlagEnableQuestIAPAnalytics = require(scriptParentParent.Flags.GetFFlagEnableQuestIAPAnalytics)

local module = {}

function module.new()
    local module2 = {}

    setmetatable(module2, {
        __tostring = function(): string
            return "Service(Analytics)"
        end
    })

    local function GetPlatformString()
        local platform = UserInputService:GetPlatform()

        local str1 = if GetFFlagUsePlatformNameForUnknown() then tostring(platform) else "UNKNOWN"
        local var1

        if platform == Enum.Platform.Windows then
            var1 = "Windows"
        elseif platform == Enum.Platform.OSX then
            var1 = "OSX"
        elseif platform == Enum.Platform.IOS then
            var1 = "IOS"
        elseif platform == Enum.Platform.Android then
            local userAgent = HttpService:GetUserAgent()
            local str2 = if string.find(userAgent, "AmazonAppStore") then "Amazon" else "Android"

            var1 = if GetFFlagEnableQuestIAPAnalytics() and string.find(userAgent, "OculusQuest3Store") then "Quest" else str2
        else
            var1 = if platform == Enum.Platform.XBoxOne then "XBoxOne" elseif platform == Enum.Platform.UWP then "UWP" elseif platform == Enum.Platform.PS4 then "PlayStation" else str1
        end

        if GetFFlagEnableLuobuInGameUpsell() then
            var1 += "-Luobu"
        end

        return var1
    end

    local function ReportPlatformCounter(arg1) -- Luacid: Inlined by compiler; 13 call sites recovered
        if RunService:IsStudio() then
            return
        end
        RbxAnalyticsService:ReportCounter(arg1 .. GetPlatformString())
    end

    function module2.sendCounter(counterName: string)
        if RunService:IsStudio() then
            return
        end
        RbxAnalyticsService:ReportCounter(counterName)
    end

    local function ReportEvent(eventName: string, arg1) -- Luacid: Inlined by compiler; 16 call sites recovered
        if RunService:IsStudio() then
            return
        end
        RbxAnalyticsService:SetRBXEvent("client", "InGamePrompt", eventName, arg1 or {})
    end

    function module2.signalEvent(eventName, arg1)
        ReportEvent(eventName, arg1)
    end

    function module2.reportRobuxUpsellStarted()
        return MarketplaceService:ReportRobuxUpsellStarted()
    end

    function module2.signalPurchaseSuccess(arg1, infoType, robuxAmount: number, arg2)
        if infoType == Enum.InfoType.Product then
            MarketplaceService:SignalClientPurchaseSuccess(arg2.receipt, Players.LocalPlayer.UserId, arg1)
            return
        end
        MarketplaceService:ReportAssetSale(arg1, robuxAmount)
    end

    function module2.signalAdultLegalTextShown()
        RbxAnalyticsService:SetRBXEvent("client", "InGamePrompt", "AdultLegalTextShown", { gameID = game.GameId })
    end

    function module2.signalFailedPurchasePostUpsell()
        ReportPlatformCounter("FailedBalanceCheckPostUpsell")
    end

    function module2.signalProductPurchaseShown(productId, arg1)
        ReportEvent("ProductPurchaseShown", { gameID = game.GameId, productId = productId, requestType = tostring(arg1) })
        ReportPlatformCounter("ProductPurchaseShown")
    end

    function module2.signalProductPurchaseUpsellShown(productId, arg1, iapProductId)
        ReportEvent(
            "ProductPurchaseUpsellShown",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = tostring(arg1),
                iapProductId = iapProductId
            }
        )
        ReportPlatformCounter("ProductPurchaseUpsellShown")
    end

    function module2.signalProductPurchaseConfirmed(productId, arg1)
        ReportEvent("ProductPurchaseConfirmed", { gameID = game.GameId, productId = productId, requestType = tostring(arg1) })
        ReportPlatformCounter("ProductPurchaseConfirmed")
    end

    function module2.signalProductPurchaseUpsellConfirmed(productId, arg1, iapProductId)
        ReportEvent(
            "ProductPurchaseUpsellConfirmed",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = tostring(arg1),
                iapProductId = iapProductId
            }
        )
        ReportPlatformCounter("ProductPurchaseUpsellConfirmed")
    end

    function module2.signalScaryModalShown(productId, requestType, iapProductId)
        ReportEvent(
            "ScaryModalShown",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = requestType,
                iapProductId = iapProductId or ""
            }
        )
        ReportPlatformCounter("ScaryModalShown" .. requestType)
    end

    function module2.signalScaryModalConfirmed(productId, requestType, iapProductId)
        ReportEvent(
            "ScaryModalConfirmed",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = requestType,
                iapProductId = iapProductId or ""
            }
        )
        ReportPlatformCounter("ScaryModalConfirmed" .. requestType)
    end

    function module2.signalScaryModalCanceled(productId, requestType, iapProductId)
        ReportEvent(
            "ScaryModalCanceled",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = requestType,
                iapProductId = iapProductId or ""
            }
        )
        ReportPlatformCounter("ScaryModalCanceled" .. requestType)
    end

    function module2.signalXboxInGamePurchaseCanceled(productId, requestType, iapProductId)
        ReportEvent(
            "XboxPaymentsInGamePurchaseCanceled",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = requestType,
                iapProductId = iapProductId or ""
            }
        )

        if not RunService:IsStudio() then
            RbxAnalyticsService:ReportCounter("XboxPaymentsInGamePurchaseCanceled")
        end
    end

    function module2.signalXboxInGamePurchaseSuccess(productId, requestType, iapProductId)
        ReportEvent(
            "XboxPaymentsInGamePurchaseSuccess",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = requestType,
                iapProductId = iapProductId or ""
            }
        )

        if not RunService:IsStudio() then
            RbxAnalyticsService:ReportCounter("XboxPaymentsInGamePurchaseSuccess")
        end
    end

    function module2.signalXboxInGamePurchaseFailure(productId, requestType, iapProductId)
        ReportEvent(
            "XboxPaymentsInGamePurchaseFailure",
            {
                gameID = game.GameId,
                productId = productId,
                requestType = requestType,
                iapProductId = iapProductId or ""
            }
        )

        if not RunService:IsStudio() then
            RbxAnalyticsService:ReportCounter("XboxPaymentsInGamePurchaseFailure")
        end
    end

    function module2.signalTwoSVSettingsErrorShown(productId, requestType)
        ReportEvent("2SVSettingsErrorShown", { gameID = game.GameId, productId = productId, requestType = requestType })
        ReportPlatformCounter("2SVSettingsErrorShown")
    end

    function module2.signalTwoSVSettingsErrorConfirmed(productId, requestType)
        ReportEvent("2SVSettingsErrorConfirmed", { gameID = game.GameId, productId = productId, requestType = requestType })
        ReportPlatformCounter("2SVSettingsErrorConfirmed")
    end

    function module2.signalRobuxUpsellInGameIXP(arg1)
        ReportEvent("RobuxUpsellInGameIXP", {})
        if arg1 then
            ReportPlatformCounter("RobuxUpsellInGameIXP")
        end
    end

    function module2.signalAvatarCreationPurchaseSubmit()
        RbxAnalyticsService:SetRBXEvent("client", "InGamePrompt", "AvatarCreationPurchaseSubmit", { gameID = game.GameId })
        ReportPlatformCounter("AvatarCreationPurchaseSubmit")
    end

    function module2.signalUserSettingEligibilityModal(requestType)
        ReportEvent("UserSettingEligibilityModalShown", { gameID = game.GameId, requestType = requestType })

        ReportPlatformCounter("UserSettingEligibilityModalShown" .. requestType)
    end

    function module2.signalEconomicRestrictionError(violationType, timeoutMinutes)
        ReportEvent(
            "EconomicRestrictionErrorShown",
            {
                gameID = game.GameId,
                violationType = violationType,
                timeoutMinutes = timeoutMinutes
            }
        )
    end
    return module2
end

return module
