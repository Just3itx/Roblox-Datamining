-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)

local function getAccountInfo(arg1, _)
    return arg1.getAccountInfo():andThen(function(arg2)
        return Promise.resolve(arg2)
    end):catch(function(_)
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return getAccountInfo
