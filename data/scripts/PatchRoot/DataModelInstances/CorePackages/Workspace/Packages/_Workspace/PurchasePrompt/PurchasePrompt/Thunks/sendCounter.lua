-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Counter = require(scriptParentParent.Enums.Counter)
local PurchaseFlow = require(scriptParentParent.Enums.PurchaseFlow)
local PaymentPlatform = require(scriptParentParent.Enums.PaymentPlatform)

local Analytics = require(scriptParentParent.Services.Analytics)
local ExternalSettings = require(scriptParentParent.Services.ExternalSettings)

local getPaymentPlatform = require(scriptParentParent.Utils.getPaymentPlatform)
local getCounterCombinations = require(scriptParentParent.Utils.getCounterCombinations)
local SelectedRobuxPackage = require(scriptParentParent.Utils.SelectedRobuxPackage)

local Thunk = require(scriptParentParent.Thunk)

local tbl1 = { Analytics, ExternalSettings }

local function sendCounter(arg1)
    return Thunk.new(script.Name, tbl1, function(arg2, arg3)
        local var1 = arg3[Analytics]
        local var2 = arg3[ExternalSettings]

        local var3 = Counter.toRawValue(arg1)

        local state = arg2:getState()

        local purchaseFlow = state.purchaseFlow
        local var4 = if purchaseFlow == nil then nil else PurchaseFlow.toRawValue(purchaseFlow)
        local robuxPurchaseAmount = SelectedRobuxPackage.getRobuxPurchaseAmount(state)

        local platform = var2.getPlatform()
        local paymentPlatform = getPaymentPlatform(platform)
        local var5 = PaymentPlatform.toRawValue(paymentPlatform)

        for _, value in (getCounterCombinations("PurchasePrompt", var3, var5, var4, robuxPurchaseAmount)) do
            var1.sendCounter(value)
        end
    end)
end

return sendCounter
