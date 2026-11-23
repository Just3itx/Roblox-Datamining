-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

return Signals.createComputed(function() -- name: createCreatorAgentResumeStore
    local getActiveTarget, setActiveTarget = Signals.createSignal(nil)

    return {
        getActiveTarget = getActiveTarget,
        useActiveTarget = function()
            return SignalsReact.useSignalState(getActiveTarget)
        end,
        setActiveTarget = setActiveTarget
    }
end)
