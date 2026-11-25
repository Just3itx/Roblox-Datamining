-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)

local FFlagAddPurchaseOptionForProvidingBalance = require(scriptParentParent.Parent.SharedFlags).FFlagAddPurchaseOptionForProvidingBalance

local function getBalanceInfo(arg1, arg2, arg3, bool1: boolean?, robux: number?)
    if FFlagAddPurchaseOptionForProvidingBalance and robux ~= nil then
        return Promise.resolve({ robux = robux, hasFailed = false })
    end

    return arg1.getBalanceInfo():andThen(function(arg4)
        if arg2.isStudio() and not arg3 then
            arg4.robux = 2147483647
        end
        arg4.hasFailed = false
        return Promise.resolve(arg4)
    end):catch(function(_)
        if bool1 then
            return Promise.resolve({ robux = 0, hasFailed = true })
        end
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return getBalanceInfo
