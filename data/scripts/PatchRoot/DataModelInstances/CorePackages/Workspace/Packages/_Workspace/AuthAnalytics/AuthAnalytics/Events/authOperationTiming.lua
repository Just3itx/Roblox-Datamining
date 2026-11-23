-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthAnalytics = script:FindFirstAncestor("AuthAnalytics")
local checkAndSendEvent = require(AuthAnalytics.Utils.checkAndSendEvent)

return function(str1: string, elapsedTime: number, state: string)
    checkAndSendEvent(str1, "authOperationTiming", { elapsedTime = elapsedTime, state = state })
end
