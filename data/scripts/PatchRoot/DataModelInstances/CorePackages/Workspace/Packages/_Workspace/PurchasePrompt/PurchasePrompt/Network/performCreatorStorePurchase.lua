-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local _Constants = require(scriptParentParent.Misc.Constants)
local Promise = require(scriptParentParent.Promise)

local function performCreatorStorePurchase(arg1, arg2, arg3)
    return arg1.performCreatorStorePurchase(arg2, arg3):andThen(function(arg4)
        if arg4.purchaseTransactionStatus == "PURCHASE_TRANSACTION_STATUS_ALREADY_OWNED"
            or arg4.purchaseTransactionStatus == "PURCHASE_TRANSACTION_STATUS_SUCCESS"
        then
            return Promise.resolve(arg4)
        end
        return Promise.reject(PurchaseError.UnknownFailure)
    end, function(_)
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return performCreatorStorePurchase
