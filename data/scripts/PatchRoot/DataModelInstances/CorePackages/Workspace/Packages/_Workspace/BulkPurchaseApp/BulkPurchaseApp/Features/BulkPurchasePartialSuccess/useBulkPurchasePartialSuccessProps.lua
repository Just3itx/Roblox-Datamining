-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarketplaceService = game:GetService("MarketplaceService")
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)
local useDispatch = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(BulkPurchaseAppParent.RoactUtils).Hooks.RoactRodux.useSelector

local BulkPurchaseEnded = require(BulkPurchaseApp.Store.Actions.BulkPurchaseEnded)
local selectPurchaseResults = require(BulkPurchaseApp.Store.Selectors.selectPurchaseResults)
local getThumbnailUrl = require(BulkPurchaseApp.Utils.getThumbnailUrl)
local _Types = require(BulkPurchaseApp.Store.Types)

local _BulkPurchasePartialSuccess = require(script.Parent.BulkPurchasePartialSuccess)

local function createBulkPurchasePartialSuccessItem(arg1, status) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        id = arg1.id,
        image = getThumbnailUrl(arg1.id, arg1.type),
        name = arg1.name,
        status = status
    }
end

local function selectBulkPurchasePartialSuccessState(arg1)
    local successfulItems = {}
    local unsuccessfulItems = {}
    local num1 = 0
    if arg1.itemData and arg1.itemStatuses then
        for _, value in arg1.itemData do
            local status = arg1.itemStatuses[value.id]
            local tbl3 = createBulkPurchasePartialSuccessItem(value, status)

            if status == Enum.MarketplaceItemPurchaseStatus.Success then
                num1 += value.priceRobux
                table.insert(successfulItems, tbl3)
            elseif status then
                table.insert(unsuccessfulItems, tbl3)
            end
        end
    end
    return {
        robuxSpent = num1,
        currentBalance = arg1.balance or 0,
        unsuccessfulItems = unsuccessfulItems,
        successfulItems = successfulItems
    }
end

local function useBulkPurchasePartialSuccessProps()
    local var1 = useSelector(selectPurchaseResults)
    local var2 = useSelector(selectBulkPurchasePartialSuccessState)
    local var3 = useDispatch()

    return {
        onDismiss = React.useCallback(function()
            MarketplaceService:signalPromptBulkPurchaseFinished(1, var1)
            var3(BulkPurchaseEnded())
        end, { var1, var3 }),
        successfulItems = var2.successfulItems,
        unsuccessfulItems = var2.unsuccessfulItems,
        robuxSpent = var2.robuxSpent,
        currentBalance = var2.currentBalance
    }
end

return useBulkPurchasePartialSuccessProps
