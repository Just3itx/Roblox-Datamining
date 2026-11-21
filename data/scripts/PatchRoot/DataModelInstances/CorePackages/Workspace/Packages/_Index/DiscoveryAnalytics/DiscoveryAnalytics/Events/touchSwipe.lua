-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local ArgCheck = require(DiscoveryAnalyticsParent.ArgCheck)

local tbl1 = {
    [Enum.SwipeDirection.Up] = "up",
    [Enum.SwipeDirection.Right] = "right",
    [Enum.SwipeDirection.Down] = "down",
    [Enum.SwipeDirection.Left] = "left"
}

return function(arg1, arg2, elt, arg3, cstm)
    ArgCheck.isType(arg2, "string", "eventContext")
    ArgCheck.isType(elt, "string", "elementName")

    local tbl2 = {
        elt = elt,
        dir = tbl1[arg3]
    }

    if cstm ~= nil then
        ArgCheck.isType(cstm, "string", "extraData")
        tbl2.cstm = cstm
    end

    arg1:setRBXEventStream(arg2, "touchSwipe", tbl2)
end
