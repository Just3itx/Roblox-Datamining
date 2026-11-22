-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local MomentsCommon = require(MomentsCreationParent.MomentsCommon)

local hostAnalyticsListener = require(MomentsCreation.Analytics.hostAnalyticsListener)

local fireAnalyticsEvent = MomentsCommon.Analytics.fireAnalyticsEvent

return function(arg1, arg2)
    fireAnalyticsEvent(arg1, arg2)

    local var1 = hostAnalyticsListener.get()
    if var1 ~= nil then
        var1(arg1, arg2)
    end
end
