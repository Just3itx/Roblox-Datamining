-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Cryo = require(AppChatParent.Cryo)

return function(tbl1, arg1)
    if tbl1 and tbl1.participants then
        return Cryo.List.filter(tbl1.participants, function(arg2): boolean
            return tostring(arg2) ~= tostring(arg1)
        end)
    end
    return {}
end
