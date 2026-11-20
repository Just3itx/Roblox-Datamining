-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local Rodux = require(scriptParentParentParent.Rodux)

return function(arg1)
    local networkingAccountInformation = arg1.networkingAccountInformation

    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[networkingAccountInformation.GetPhoneInformation.Succeeded.name] = function(_, arg2)
        return arg2.responseBody and arg2.responseBody.isVerified
    end

    return createReducer(false, tbl1)
end
