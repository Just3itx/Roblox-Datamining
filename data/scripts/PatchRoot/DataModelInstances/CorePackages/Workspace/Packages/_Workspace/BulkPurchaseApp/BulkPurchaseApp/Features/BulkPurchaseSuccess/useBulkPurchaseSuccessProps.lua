-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local useDispatch = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local BulkPurchaseEnded = require(BulkPurchaseApp.Store.Actions.BulkPurchaseEnded)
local selectPurchaseResults = require(BulkPurchaseApp.Store.Selectors.selectPurchaseResults)

local _BulkPurchaseSuccess = require(script.Parent.BulkPurchaseSuccess)

local function useBulkPurchaseSuccessProps()
    local var1 = useDispatch()
    local var2 = useSelector(selectPurchaseResults)

    local num1 = 0
    for _, item in var2.Items do
        if item.status == Enum.MarketplaceItemPurchaseStatus.Success then
            num1 += 1
        end
    end

    return {
        onDismiss = function()
            MarketplaceService:signalPromptBulkPurchaseFinished(1, var2)
            var1(BulkPurchaseEnded())
        end,
        itemCount = num1
    }
end

return useBulkPurchaseSuccessProps
