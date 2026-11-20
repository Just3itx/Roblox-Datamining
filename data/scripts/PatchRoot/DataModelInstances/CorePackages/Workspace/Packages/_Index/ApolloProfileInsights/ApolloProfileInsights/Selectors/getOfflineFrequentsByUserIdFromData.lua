-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local getProfileInsightsByUserIdFromData = require(script.Parent.getProfileInsightsByUserIdFromData)

return function(arg1, arg2)
    local profileInsightsByUserIdFromData = getProfileInsightsByUserIdFromData(arg1, arg2)

    return if profileInsightsByUserIdFromData then profileInsightsByUserIdFromData.isOfflineFrequents or false else false
end
