-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local makeActionCreator = require(AuthCommonParent.Rodux).makeActionCreator
local ArgCheck = require(AuthCommonParent.ArgCheck)

return makeActionCreator(script.Name, function(arg1)
    return {
        disabled = ArgCheck.isType(arg1, "boolean", "disabled")
    }
end)
