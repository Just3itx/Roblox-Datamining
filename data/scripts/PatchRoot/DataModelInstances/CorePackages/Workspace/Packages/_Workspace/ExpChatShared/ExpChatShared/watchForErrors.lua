-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local Analytics = require(ExpChatShared.Analytics)

return function(arg1, arg2, arg3)
    arg1.Error:Connect(function(_, arg4, arg5)
        if arg5 == arg2 or arg4 and string.find(arg4, "ExpChat") then
            Analytics.reportCounter(if arg3 then "expChatErrorCountServer" else "expChatErrorCountClient")
        end
    end)
end
