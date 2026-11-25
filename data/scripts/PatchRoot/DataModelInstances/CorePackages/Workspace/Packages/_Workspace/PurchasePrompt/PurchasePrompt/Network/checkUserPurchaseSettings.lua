-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)

local function checkUserPurchaseSettings(arg1)
    return arg1.checkUserPurchaseSettings():andThen(function(arg2)
        return Promise.resolve(arg2)
    end):catch(function(_)
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return checkUserPurchaseSettings
