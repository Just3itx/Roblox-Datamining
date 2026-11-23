-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:40:55Z
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
local selectErrorCode = require(BulkPurchaseApp.Store.Selectors.selectErrorCode)
local selectErrorMetadata = require(BulkPurchaseApp.Store.Selectors.selectErrorMetadata)
local _ErrorCodeEnum = require(BulkPurchaseApp.Enums.ErrorCodeEnum)

local _BulkPurchaseError = require(script.Parent.BulkPurchaseError)

local function useBulkPurchaseErrorProps()
    local var1 = useSelector(selectPurchaseResults)
    local errorCode = useSelector(selectErrorCode)
    local errorMetadata = useSelector(selectErrorMetadata)
    local var4 = useDispatch()

    return {
        onDismiss = React.useCallback(function()
            MarketplaceService:signalPromptBulkPurchaseFinished(3, var1)
            var4(BulkPurchaseEnded())
        end, { var1, var4 }),
        errorCode = errorCode,
        errorMetadata = errorMetadata
    }
end

return useBulkPurchaseErrorProps
