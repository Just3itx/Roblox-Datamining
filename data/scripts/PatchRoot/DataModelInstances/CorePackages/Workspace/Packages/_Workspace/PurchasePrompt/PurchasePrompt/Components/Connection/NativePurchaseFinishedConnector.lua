-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact

local retryAfterUpsell = require(PurchasePrompt.Thunks.retryAfterUpsell)
local connectToStore = require(PurchasePrompt.connectToStore)

local handleNativePurchaseFailureOrCancel = require(PurchasePrompt.Thunks.handleNativePurchaseFailureOrCancel)
local ExternalEventConnection = require(script.Parent.ExternalEventConnection)

local FFlagLuaAppEnableNativePurchaseFinishedV2Signals = require(PurchasePrompt.Parent.SharedFlags).FFlagLuaAppEnableNativePurchaseFinishedV2Signals

return (connectToStore(nil, function(callback) -- name: mapDispatchToProps
    return {
        nativePurchaseFinished = function(_, _, arg1, _)
            if arg1 then
                callback(retryAfterUpsell())
                return
            end
            callback(handleNativePurchaseFailureOrCancel())
        end,
        nativePurchaseFinishedWithLocalPlayer = function(_, arg1, _)
            if arg1 then
                callback(retryAfterUpsell())
                return
            end
            callback(handleNativePurchaseFailureOrCancel())
        end
    }
end)(function(arg1) -- name: NativePurchaseFinishedConnector
    local nativePurchaseFinished = arg1.nativePurchaseFinished
    local nativePurchaseFinishedWithLocalPlayer = arg1.nativePurchaseFinishedWithLocalPlayer

    if game:GetEngineFeature("NativePurchaseWithLocalPlayer") then
        return Roact.createFragment({
            NativePurchase = Roact.createElement(
                ExternalEventConnection,
                {
                    event = MarketplaceService.NativePurchaseFinished,
                    callback = nativePurchaseFinished
                }
            ),
            NativePurchaseWithLocalPlayer = Roact.createElement(
                ExternalEventConnection,
                {
                    event = MarketplaceService.NativePurchaseFinishedWithLocalPlayer,
                    callback = nativePurchaseFinishedWithLocalPlayer
                }
            ),
            NativePurchaseV2 = if FFlagLuaAppEnableNativePurchaseFinishedV2Signals then Roact.createElement(
                ExternalEventConnection,
                {
                    event = MarketplaceService.NativePurchaseFinishedV2,
                    callback = nativePurchaseFinished
                }
            ) else nil,
            NativePurchaseWithLocalPlayerV2 = if FFlagLuaAppEnableNativePurchaseFinishedV2Signals then Roact.createElement(
                ExternalEventConnection,
                {
                    event = MarketplaceService.NativePurchaseFinishedWithLocalPlayerV2,
                    callback = nativePurchaseFinishedWithLocalPlayer
                }
            ) else nil
        })
    elseif FFlagLuaAppEnableNativePurchaseFinishedV2Signals then
        return Roact.createFragment({
            NativePurchase = Roact.createElement(
                ExternalEventConnection,
                {
                    event = MarketplaceService.NativePurchaseFinished,
                    callback = nativePurchaseFinished
                }
            ),
            NativePurchaseV2 = Roact.createElement(
                ExternalEventConnection,
                {
                    event = MarketplaceService.NativePurchaseFinishedV2,
                    callback = nativePurchaseFinished
                }
            )
        })
    end

    return Roact.createElement(
        ExternalEventConnection,
        {
            event = MarketplaceService.NativePurchaseFinished,
            callback = nativePurchaseFinished
        }
    )
end))
