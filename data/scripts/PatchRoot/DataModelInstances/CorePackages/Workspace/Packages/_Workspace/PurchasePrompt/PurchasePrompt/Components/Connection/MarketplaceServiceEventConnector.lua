-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local completePurchase = require(PurchasePrompt.Thunks.completePurchase)
local initiatePurchase = require(PurchasePrompt.Thunks.initiatePurchase)
local initiateBundlePurchase = require(PurchasePrompt.Thunks.initiateBundlePurchase)
local initiateSubscriptionPurchase = require(PurchasePrompt.Thunks.initiateSubscriptionPurchase)
local connectToStore = require(PurchasePrompt.connectToStore)

local ExternalEventConnection = require(script.Parent.ExternalEventConnection)

local GetFFlagEnablePromptPurchaseRequestedV2 = require(PurchasePrompt.Flags.GetFFlagEnablePromptPurchaseRequestedV2)
local GetFFlagEnablePromptPurchaseRequestedV2Take2 = require(PurchasePrompt.Flags.GetFFlagEnablePromptPurchaseRequestedV2Take2)
local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePromptParent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum

local FFlagEnablePromptRobloxSubscriptionPurchaseBinding = require(PurchasePrompt.Flags.FFlagEnablePromptRobloxSubscriptionPurchaseBinding)

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePrompt.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local RobloxSubscriptionPurchaseApp = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp)
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName

return (connectToStore(nil, function(callback)
    return {
        onPurchaseRequest = function(localPlayer, arg1, arg2, _)
            if localPlayer == Players.LocalPlayer then
                callback(initiatePurchase(arg1, Enum.InfoType.Asset, arg2, false, "", ""))
            end
        end,
        onPurchaseRequestV2 = function(localPlayer, arg1, arg2, _, arg3, arg4)
            if localPlayer == Players.LocalPlayer then
                callback(initiatePurchase(arg1, Enum.InfoType.Asset, arg2, false, arg3, arg4))
            end
        end,
        onRobloxPurchaseRequest = function(arg1, arg2)
            callback(initiatePurchase(arg1, Enum.InfoType.Asset, arg2, true))
        end,
        onProductPurchaseRequest = function(localPlayer, arg1, arg2, _)
            if localPlayer == Players.LocalPlayer then
                callback(initiatePurchase(arg1, Enum.InfoType.Product, arg2))
            end
        end,
        onPurchaseGamePassRequest = function(localPlayer, arg1)
            if localPlayer == Players.LocalPlayer then
                callback(initiatePurchase(arg1, Enum.InfoType.GamePass, false))
            end
        end,
        onServerPurchaseVerification = function(arg1)
            if not arg1 then
                callback(ErrorOccurred(PurchaseError.UnknownFailure))
                return
            end
            local playerId = arg1.playerId
            if playerId ~= nil then
                playerId = tonumber(arg1.playerId)
            end
            if playerId == Players.LocalPlayer.UserId then
                callback(completePurchase())
            end
        end,
        onBundlePurchaseRequest = function(localPlayer, arg1)
            if localPlayer == Players.LocalPlayer then
                callback(initiateBundlePurchase(arg1))
            end
        end,
        onPremiumPurchaseRequest = function(localPlayer)
            if localPlayer == Players.LocalPlayer then
                RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
                    {},
                    nil,
                    nil,
                    SurfaceName.PromptSubscriptionPurchase,
                    SurfaceContext.InGame,
                    { skipWaitingForPurchaseResult = true }
                )
            end
        end,
        onPromptCollectiblesPurchaseRequest = function(localPlayer, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
            if localPlayer == Players.LocalPlayer then
                callback(initiatePurchase(arg1, Enum.InfoType.Asset, false, true, arg6, arg7, arg2, arg3, arg4, arg5))
            end
        end,
        onSubscriptionPurchaseRequest = function(arg1)
            if FFlagEnableUnifiedPurchaseFlowForDevSubs then
                callback(initiatePurchase(arg1, ProductTypeEnum.DeveloperSubscription))
                return
            end
            callback(initiateSubscriptionPurchase(arg1))
        end,
        onCollectibleBundlePurchaseRequest = function(localPlayer, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
            if localPlayer == Players.LocalPlayer then
                callback(initiateBundlePurchase(arg1, arg6, arg7, arg2, arg3, arg4, arg5))
            end
        end,
        onRobloxSubscriptionPurchaseRequest = function()
            if FFlagEnablePromptRobloxSubscriptionPurchaseBinding then
                RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
                    {},
                    nil,
                    nil,
                    SurfaceName.PromptSubscriptionPurchase,
                    SurfaceContext.InGame,
                    { skipWaitingForPurchaseResult = true }
                )
            end
        end,
        onVIPServerPurchaseRequest = function(_)
            callback(initiatePurchase(game.GameId, ProductTypeEnum.VIPServer))
        end
    }
end)(function(arg1) -- name: MarketplaceServiceEventConnector
    local onPurchaseRequest = arg1.onPurchaseRequest
    local onPurchaseRequestV2 = arg1.onPurchaseRequestV2
    local onProductPurchaseRequest = arg1.onProductPurchaseRequest
    local onPurchaseGamePassRequest = arg1.onPurchaseGamePassRequest
    local onServerPurchaseVerification = arg1.onServerPurchaseVerification
    local onBundlePurchaseRequest = arg1.onBundlePurchaseRequest
    local onPremiumPurchaseRequest = arg1.onPremiumPurchaseRequest
    local onRobloxPurchaseRequest = arg1.onRobloxPurchaseRequest
    local onPromptCollectiblesPurchaseRequest = arg1.onPromptCollectiblesPurchaseRequest
    local onSubscriptionPurchaseRequest = arg1.onSubscriptionPurchaseRequest
    local onCollectibleBundlePurchaseRequest = arg1.onCollectibleBundlePurchaseRequest
    local onRobloxSubscriptionPurchaseRequest = arg1.onRobloxSubscriptionPurchaseRequest
    local onVipServerPurchaseRequest = arg1.onVIPServerPurchaseRequest

    local function checkNewEventExists(): RBXScriptSignal
        return MarketplaceService.PromptPurchaseRequestedV2
    end

    local element = if GetFFlagEnablePromptPurchaseRequestedV2()
        or GetFFlagEnablePromptPurchaseRequestedV2Take2() and pcall(checkNewEventExists) then Roact.createElement(
        ExternalEventConnection,
        {
            event = MarketplaceService.PromptPurchaseRequestedV2,
            callback = onPurchaseRequestV2
        }
    ) else Roact.createElement(
        ExternalEventConnection,
        {
            event = MarketplaceService.PromptPurchaseRequested,
            callback = onPurchaseRequest
        }
    )

    local element2 = if pcall(function(): RBXScriptSignal -- name: checkPromptCollectiblesPurchaseRequestedEventExists
        return MarketplaceService.PromptCollectiblesPurchaseRequested
    end) then Roact.createElement(
        ExternalEventConnection,
        {
            event = MarketplaceService.PromptCollectiblesPurchaseRequested,
            callback = onPromptCollectiblesPurchaseRequest
        }
    ) else nil

    local element3 = if pcall(function(): RBXScriptSignal -- name: checkCollectibleBundlePurchaseEventExists
        return MarketplaceService.PromptCollectibleBundlePurchaseRequested
    end) then Roact.createElement(
        ExternalEventConnection,
        {
            event = MarketplaceService.PromptCollectibleBundlePurchaseRequested,
            callback = onCollectibleBundlePurchaseRequest
        }
    ) else nil

    local element4 = if FFlagLuaAppsEnablePromptVIPServerPurchase then Roact.createElement(
        ExternalEventConnection,
        {
            event = MarketplaceService.PromptVIPServerPurchaseRequested,
            callback = onVipServerPurchaseRequest
        }
    ) else nil
    return Roact.createFragment({
        element,
        element2,
        element3,
        element4,
        RobloxPurchase = Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.PromptRobloxPurchaseRequested,
                callback = onRobloxPurchaseRequest
            }
        ),
        Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.PromptProductPurchaseRequested,
                callback = onProductPurchaseRequest
            }
        ),
        Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.PromptGamePassPurchaseRequested,
                callback = onPurchaseGamePassRequest
            }
        ),
        Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.ServerPurchaseVerification,
                callback = onServerPurchaseVerification
            }
        ),
        Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.PromptBundlePurchaseRequested,
                callback = onBundlePurchaseRequest
            }
        ),
        Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.PromptPremiumPurchaseRequested,
                callback = onPremiumPurchaseRequest
            }
        ),
        Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.PromptSubscriptionPurchaseRequested,
                callback = onSubscriptionPurchaseRequest
            }
        ),
        if FFlagEnablePromptRobloxSubscriptionPurchaseBinding then Roact.createElement(
            ExternalEventConnection,
            {
                event = MarketplaceService.PromptRobloxSubscriptionPurchaseRequested,
                callback = onRobloxSubscriptionPurchaseRequest
            }
        ) else nil
    })
end))
