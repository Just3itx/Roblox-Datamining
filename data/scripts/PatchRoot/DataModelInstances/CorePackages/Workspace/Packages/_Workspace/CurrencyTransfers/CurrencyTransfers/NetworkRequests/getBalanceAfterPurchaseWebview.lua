-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local Promise = require(CurrencyTransfersParent.Promise)
local getBalanceRequest = require(CurrencyTransfers.NetworkRequests.getBalanceRequest)

local function getBalanceAfterPurchaseWebview(tbl1, arg1)
    local var1 = if not tbl1 or tbl1.refetchDelaySeconds == nil then 0.45 else tbl1.refetchDelaySeconds

    return getBalanceRequest(nil, arg1):andThen(function(num1: number)
        if var1 <= 0 then
            return num1
        end
        return Promise.delay(var1):andThen(function()
            return getBalanceRequest(nil, arg1):andThen(function(num2: number): number
                return math.max(num1, num2)
            end):catch(function()
                return num1
            end)
        end)
    end)
end

return getBalanceAfterPurchaseWebview
