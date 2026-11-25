-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _UserInputService = game:GetService("UserInputService")

local SetButtonState = require(scriptParentParent.Actions.SetButtonState)
local PurchaseWarning = require(scriptParentParent.Enums.PurchaseWarning)
local ButtonState = require(scriptParentParent.Enums.ButtonState)
local UpsellFlow = require(scriptParentParent.Enums.UpsellFlow)
local Network = require(scriptParentParent.Services.Network)
local getPurchaseWarning = require(scriptParentParent.Network.getPurchaseWarning)
local getUpsellFlow = require(scriptParentParent.NativeUpsell.getUpsellFlow)
local Analytics = require(scriptParentParent.Services.Analytics)
local ExternalSettings = require(scriptParentParent.Services.ExternalSettings)
local Thunk = require(scriptParentParent.Thunk)

local SelectedRobuxPackage = require(scriptParentParent.Utils.SelectedRobuxPackage)

local resolvePurchasePrecheck = require(script.Parent.resolvePurchasePrecheck)
local _SetPromptState = require(scriptParentParent.Actions.SetPromptState)
local _PromptState = require(scriptParentParent.Enums.PromptState)

local tbl1 = { Analytics, Network, ExternalSettings }

local function initiatePurchasePrecheck()
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local state = arg1:getState()
        local var1 = arg2[Analytics]
        local var2 = arg2[Network]
        local var3 = arg2[ExternalSettings]

        if var3.isStudio() then
            return resolvePurchasePrecheck(PurchaseWarning.NoAction)
        end

        local upsellFlow = getUpsellFlow(var3.getPlatform())

        local productId = state.productInfo.productId
        local robuxProductId = SelectedRobuxPackage.getRobuxProductId(state)

        local bool1 = state.accountInfo.membershipType == 4
        local productId2

        if upsellFlow == UpsellFlow.Web then
            productId2 = SelectedRobuxPackage.getProductId(state)
            robuxProductId = nil
        else
            productId2 = nil
        end

        arg1:dispatch(SetButtonState(ButtonState.Disabled))
        return getPurchaseWarning(var2, robuxProductId, productId2, bool1):andThen(function(arg3)
            arg1:dispatch(SetButtonState(ButtonState.Enabled))

            if arg3 then
                if arg3.action == "U13PaymentModal" then
                    var1.signalScaryModalShown(productId, "U13PaymentModal", robuxProductId or productId2)
                    return arg1:dispatch(resolvePurchasePrecheck(PurchaseWarning.U13PaymentModal))
                elseif arg3.action == "U13MonthlyThreshold1Modal" then
                    var1.signalScaryModalShown(productId, "U13MonthlyThreshold1Modal", robuxProductId or productId2)

                    return arg1:dispatch(resolvePurchasePrecheck(PurchaseWarning.U13MonthlyThreshold1Modal))
                elseif arg3.action == "U13MonthlyThreshold2Modal" then
                    var1.signalScaryModalShown(productId, "U13MonthlyThreshold2Modal", robuxProductId or productId2)

                    return arg1:dispatch(resolvePurchasePrecheck(PurchaseWarning.U13MonthlyThreshold2Modal))
                elseif arg3.action == "ParentalConsentWarningPaymentModal13To17" then
                    var1.signalScaryModalShown(productId, "ParentalConsentWarningPaymentModal13To17", robuxProductId or productId2)

                    return arg1:dispatch(resolvePurchasePrecheck(PurchaseWarning.ParentalConsentWarningPaymentModal13To17))
                end
            end

            arg1:dispatch(resolvePurchasePrecheck(PurchaseWarning.NoAction))
        end):catch(function(_)
            arg1:dispatch(SetButtonState(ButtonState.Enabled))
            arg1:dispatch(resolvePurchasePrecheck(PurchaseWarning.NoAction))
        end)
    end)
end

return initiatePurchasePrecheck
