-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreScriptsPlayerFeedback = script:FindFirstAncestor("CoreScriptsPlayerFeedback")
local _CaptureTypes = require(CoreScriptsPlayerFeedback.CaptureTypes)

return function(arg1): string
    if arg1.CaptureTime ~= nil then
        return `{arg1.LocalId}_{arg1.CaptureTime.UnixTimestampMillis}`
    end
    if arg1.LocalId == nil then
        return tostring(arg1)
    end

    return tostring(arg1.LocalId)
end
