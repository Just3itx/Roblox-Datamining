-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:11:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoverabilityModalParent = script:FindFirstAncestor("DiscoverabilityModal").Parent
local getPlatformTarget = require(DiscoverabilityModalParent.Analytics).getPlatformTarget

return function(arg1)
    return function(_, str1: string, str2: string, tbl1)
        arg1:setRBXEventStream(getPlatformTarget(), str1, str2, tbl1)
    end
end
