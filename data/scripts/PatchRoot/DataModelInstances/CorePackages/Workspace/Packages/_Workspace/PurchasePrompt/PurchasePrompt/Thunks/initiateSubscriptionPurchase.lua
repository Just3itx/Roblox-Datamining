-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local HttpService = game:GetService("HttpService")
local _Promise = require(PurchasePrompt.Promise)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local SetPurchaseFlowUUID = require(PurchasePrompt.Actions.SetPurchaseFlowUUID)

local RequestSubscriptionPurchase = require(PurchasePrompt.Actions.RequestSubscriptionPurchase)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local getSubscriptionPurchaseInfo = require(PurchasePrompt.Network.getSubscriptionPurchaseInfo)
local Network = require(PurchasePrompt.Services.Network)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local resolveSubscriptionPromptState = require(PurchasePrompt.Thunks.resolveSubscriptionPromptState)
local hasPendingRequest = require(PurchasePrompt.Utils.hasPendingRequest)
local _Logging = require(PurchasePromptParent.AppCommonLib).Logging
local Thunk = require(PurchasePrompt.Thunk)
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

local FFlagEnablePurchaseFlowUUIDMigration = require(PurchasePrompt.Flags.FFlagEnablePurchaseFlowUUIDMigration)

local PurchaseFlowUUIDTelemetry = require(PurchasePrompt.Events.PurchaseFlowUUIDTelemetry)

local tbl1 = { Network, ExternalSettings }

local function initiateSubscriptionPurchase(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Network]
        local var2 = arg3[ExternalSettings]

        if FFlagEnablePurchaseFlowUUIDMigration then
            local str1 = HttpService:GenerateGUID(false)
            arg2:dispatch(SetPurchaseFlowUUID(str1))

            LoggingProtocol.default:logRobloxTelemetryCounter(
                PurchaseFlowUUIDTelemetry.InitiatePurchaseCounter,
                1,
                { method = "initiateSubscriptionPurchase" }
            )
        end

        if hasPendingRequest(arg2:getState()) then
            return nil
        end

        arg2:dispatch(RequestSubscriptionPurchase(arg1))

        if var2.getFlagOrder66() then
            arg2:dispatch(ErrorOccurred(PurchaseError.PurchaseDisabled))
            return nil
        end
        return getSubscriptionPurchaseInfo(var1, arg1):andThen(function(arg4)
            arg2:dispatch(resolveSubscriptionPromptState(arg4))
        end):catch(function(arg4)
            arg2:dispatch(ErrorOccurred(arg4))
        end)
    end)
end

return initiateSubscriptionPurchase
