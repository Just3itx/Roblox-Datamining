-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local mergeLists = require(script.Parent.utils.mergeLists)

return {
    fields = {
        profileInsights = {
            merge = function(_, arg1, arg2)
                return mergeLists(arg1, arg2)
            end
        }
    }
}
