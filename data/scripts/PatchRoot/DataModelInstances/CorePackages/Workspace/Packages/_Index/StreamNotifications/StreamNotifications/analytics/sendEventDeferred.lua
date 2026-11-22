-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StreamNotificationsParent = script:FindFirstAncestor("StreamNotifications").Parent
local getPlatformTarget = require(StreamNotificationsParent.Analytics).getPlatformTarget

return function(arg1)
    return function(str1: string, str2: string, tbl1)
        arg1:SendEventDeferred(getPlatformTarget(), str1, str2, tbl1)
    end
end
