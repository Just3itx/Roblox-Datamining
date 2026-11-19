-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T12:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CrossExperience = script:FindFirstAncestor("CrossExperience")

local Constants = require(CrossExperience.Constants)

local var1 = nil
local bool1 = false
local function func1() -- Luacid: Inlined by compiler; 1 call site recovered
    if not bool1 then
        local success, result = pcall(function(): AudioFocusService
            return game:GetService("AudioFocusService")
        end)
        if success and result then
            var1 = result
        end
        bool1 = true
    end
    return var1
end

return function(): boolean
    local var2 = func1()
    return if var2 then var2:GetFocusedContextId() == Constants.AUDIO_FOCUS_MANAGEMENT.CEV.CONTEXT_ID else false
end
