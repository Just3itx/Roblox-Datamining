-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SquadsCore = script:FindFirstAncestor("SquadsCore")
local SquadsCoreParent = SquadsCore.Parent

local SquadExternalContractContext = require(SquadsCore.Components.SquadExternalContractProvider.SquadExternalContractContext)
local useCurrentSquadParentChannelId = require(SquadsCore.Hooks.useCurrentSquadParentChannelId)

local React = require(SquadsCoreParent.React)

local GetFFlagEnablePartyVoiceOnlyForUnfilteredThreads = require(SquadsCore.Flags.GetFFlagEnablePartyVoiceOnlyForUnfilteredThreads)

function useIsCurrentSquadPartyVoiceEligible()
    local var1 = React.useContext(SquadExternalContractContext)
    local var2 = useCurrentSquadParentChannelId() or ""

    return var1.useParentChannelIsPartyVoiceEligible(var2)
end

return if GetFFlagEnablePartyVoiceOnlyForUnfilteredThreads() then useIsCurrentSquadPartyVoiceEligible else function(): boolean
    return true
end
