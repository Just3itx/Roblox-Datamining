-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommonParent = script:FindFirstAncestor("AuthCommon").Parent
local ArgCheck = require(AuthCommonParent.ArgCheck)

return function(arg1, arg2)
    ArgCheck.isNotNil(arg1, "linking")
    ArgCheck.isType(arg2, "string", "url")

    arg1:openURL(arg2)
end
