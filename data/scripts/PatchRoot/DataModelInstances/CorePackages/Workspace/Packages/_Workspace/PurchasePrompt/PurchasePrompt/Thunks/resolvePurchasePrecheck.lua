-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local SetPromptState = require(scriptParentParent.Actions.SetPromptState)
local PromptState = require(scriptParentParent.Enums.PromptState)
local PurchaseWarning = require(scriptParentParent.Enums.PurchaseWarning)
local launchRobuxUpsell = require(scriptParentParent.Thunks.launchRobuxUpsell)
local Thunk = require(scriptParentParent.Thunk)

local function resolvePurchasePrecheck(arg1)
    return Thunk.new(script.Name, {}, function(arg2, _)
        if arg1 == PurchaseWarning.U13PaymentModal then
            return arg2:dispatch(SetPromptState(PromptState.U13PaymentModal))
        elseif arg1 == PurchaseWarning.U13MonthlyThreshold1Modal then
            return arg2:dispatch(SetPromptState(PromptState.U13MonthlyThreshold1Modal))
        elseif arg1 == PurchaseWarning.RequireEmailVerification then
            return arg2:dispatch(SetPromptState(PromptState.RequireEmailVerification))
        elseif arg1 == PurchaseWarning.U13MonthlyThreshold2Modal then
            return arg2:dispatch(SetPromptState(PromptState.U13MonthlyThreshold2Modal))
        elseif arg1 == PurchaseWarning.ParentalConsentWarningPaymentModal13To17 then
            return arg2:dispatch(SetPromptState(PromptState.ParentalConsentWarningPaymentModal13To17))
        end

        return arg2:dispatch(launchRobuxUpsell())
    end)
end

return resolvePurchasePrecheck
