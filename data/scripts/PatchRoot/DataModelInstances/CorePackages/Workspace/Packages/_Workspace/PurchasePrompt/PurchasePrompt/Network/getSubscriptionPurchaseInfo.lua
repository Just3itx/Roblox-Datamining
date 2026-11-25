-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Promise = require(scriptParentParent.Promise)
local parseSubscriptionError = require(scriptParentParent.Utils.parseSubscriptionError)

local function getSubscriptionPurchaseInfo(arg1, arg2)
    return arg1.getSubscriptionPurchaseInfo(arg2):catch(function(arg3)
        return Promise.reject(parseSubscriptionError(arg3))
    end)
end

return getSubscriptionPurchaseInfo
