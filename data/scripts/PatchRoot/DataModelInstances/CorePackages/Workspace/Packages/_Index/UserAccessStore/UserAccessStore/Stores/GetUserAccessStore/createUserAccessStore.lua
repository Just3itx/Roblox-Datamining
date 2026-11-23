-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserAccessStoreParent = script:FindFirstAncestor("UserAccessStore").Parent

local _Signals = require(UserAccessStoreParent.Signals)
local createSessionScopedSignal = require(UserAccessStoreParent.SignalsUtils).createSessionScopedSignal

return function()
    local getUserAccessRestrictionDetail, setUserAccessRestrictionDetail = createSessionScopedSignal(nil)

    return {
        getUserAccessRestrictionDetail = getUserAccessRestrictionDetail,
        setUserAccessRestrictionDetail = setUserAccessRestrictionDetail,
        reset = function()
            setUserAccessRestrictionDetail(nil)
        end
    }
end
