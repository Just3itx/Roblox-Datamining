-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent

local React = require(SquadsCoreParent.React)
local CrossExperienceVoice = require(SquadsCoreParent.CrossExperienceVoice)

local useIsLocalPlayerPartyVoiceEligible = require(script.Parent.Parent.Hooks.useIsLocalPlayerPartyVoiceEligible)
local useIsBackgroundDMActive = CrossExperienceVoice.Hooks.useIsBackgroundDMActive

return function(tbl1)
    local var1 = useIsLocalPlayerPartyVoiceEligible()
    local var2 = useIsBackgroundDMActive()

    React.useEffect(function()
        tbl1.onChange(var1 and var2)
    end, { var1, var2 })

    return nil
end
