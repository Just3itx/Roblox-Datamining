-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local scriptParentParentParent = script.Parent.Parent.Parent
local getPlatformTarget = require(scriptParentParentParent.Analytics).getPlatformTarget
local Cryo = require(scriptParentParentParent.Cryo)

return function(arg1)
    local playSessionId = RbxAnalyticsService:GetPlaySessionId()

    return function(str1: string, str2: string, tbl1)
        local var1 = Cryo.Dictionary.join(tbl1 or {}, { playSessionId = playSessionId })

        arg1:SendEventDeferred(getPlatformTarget(), str1, str2, var1)
    end
end
