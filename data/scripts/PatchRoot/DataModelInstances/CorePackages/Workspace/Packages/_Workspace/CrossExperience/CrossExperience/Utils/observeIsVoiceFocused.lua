-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")

local Constants = require(CrossExperience.Constants)
local observeCurrentContextId = require(CrossExperience.Utils.observeCurrentContextId)

return function(callback: (...any) -> (...any))
    local var1 = nil
    observeCurrentContextId(function(contextId)
        local bool1 = contextId == Constants.AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID
        if bool1 ~= var1 then
            var1 = bool1
            callback(var1)
        end
    end)
end
