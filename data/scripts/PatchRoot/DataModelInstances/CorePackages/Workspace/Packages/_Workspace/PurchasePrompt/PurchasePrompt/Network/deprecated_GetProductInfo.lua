-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Promise = require(scriptParentParent.Promise)

local function deprecated_GetProductInfo(arg1, arg2, arg3)
    return arg1.getProductInfo(arg2, arg3):catch(function(_)
        return Promise.reject(PurchaseError.UnknownFailureNoItemName)
    end)
end

return deprecated_GetProductInfo
