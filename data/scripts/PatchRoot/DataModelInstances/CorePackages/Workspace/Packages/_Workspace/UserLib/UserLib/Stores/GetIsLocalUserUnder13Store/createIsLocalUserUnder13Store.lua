-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLibParent = script:FindFirstAncestor("UserLib").Parent

local _Signals = require(UserLibParent.Signals)
local createSessionScopedSignal = require(UserLibParent.SignalsUtils).createSessionScopedSignal

return function()
    local getIsLocalUserUnder13, setIsLocalUserUnder13 = createSessionScopedSignal(false)

    return {
        getIsLocalUserUnder13 = getIsLocalUserUnder13,
        setIsLocalUserUnder13 = setIsLocalUserUnder13,
        reset = function()
            setIsLocalUserUnder13(false)
        end
    }
end
