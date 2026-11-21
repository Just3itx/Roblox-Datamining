-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local _Signals = require(AuthCommonParent.Signals)
local createSessionScopedSignal = require(AuthCommonParent.SignalsUtils).createSessionScopedSignal
local _Types = require(AuthCommon.Common.Types)

return function()
    local getCountryCodeList, var2 = createSessionScopedSignal({})

    return {
        getCountryCodeList = getCountryCodeList,
        setCountryCodeList = function(arg1)
            var2(arg1)
        end,
        reset = function()
            var2({})
        end
    }
end
