-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)

local function getUniversePrivateServerSettings(arg1, num1: number)
    return arg1.getUniversePrivateServerSettings(num1):andThen(function(arg2)
        local privateServerData = arg2.privateServerData
        if privateServerData == nil then
            return Promise.reject(PurchaseError.UnknownFailureNoItemName)
        elseif privateServerData.isAvailable == false then
            return Promise.reject(PurchaseError.VIPServerUnavailable)
        end
        return Promise.resolve(arg2)
    end, function()
        return Promise.reject(PurchaseError.UnknownFailureNoItemName)
    end)
end

return getUniversePrivateServerSettings
