-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Promise = require(scriptParentParent.Promise)
local parseSubscriptionError = require(scriptParentParent.Utils.parseSubscriptionError)

local function performSubscriptionPurchase(arg1, arg2, arg3)
    return arg1.performSubscriptionPurchase(arg2, arg3):catch(function(arg4)
        return Promise.reject(parseSubscriptionError(arg4))
    end)
end

return performSubscriptionPurchase
