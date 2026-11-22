-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent
local CrossExperienceVoice = require(SquadsParent.CrossExperienceVoice)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId
local dependencies = require(Squads.dependencies)

local React = dependencies.React
local SharedFlags = dependencies.SharedFlags
local isPresenceJoinable = require(Squads.Common.isPresenceJoinable)

local FFlagSquadsPresenceStoreMigration = require(SquadsParent.SquadsCore.Flags).FFlagSquadsPresenceStoreMigration
local useGetPresenceByUserId = if FFlagSquadsPresenceStoreMigration then require(SquadsParent.FriendsCommon).Hooks.useGetPresenceByUserId else nil
local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local Constants = require(SquadsParent.SquadsCore.Constants)
local Hooks = require(SquadsParent.SquadsCore.Hooks)

local useIsLocalPlayerPartyVoiceEligible = Hooks.useIsLocalPlayerPartyVoiceEligible
local useIsUserPartyVoiceEligible = Hooks.useIsUserPartyVoiceEligible
local useIsCurrentSquadPartyVoiceEligible = Hooks.useIsCurrentSquadPartyVoiceEligible
local useBackgroundExperience = CrossExperienceVoice.Hooks.useBackgroundExperience
local useCurrentSquadParentChannelId = Hooks.useCurrentSquadParentChannelId
local useSelector = dependencies.Hooks.useSelector

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice

local function useSquadUserDropdownMenuButtons(arg1, bool1: boolean)
    local var1 = useLocalUserId()
    local bool2 = tostring(var1) == tostring(arg1)

    local var2 = nil
    local var3 = nil
    local bool3 = false
    local bool4 = false

    if GetFFlagEnableCrossExpVoice() then
        local var4 = if arg1 then tonumber(arg1) else nil
        var2 = useBackgroundExperience()
        var3 = React.useMemo(function()
            return if var2 then var2.voiceChannelId else nil
        end, { var2 })

        if var4 then
            local var5 = useIsLocalPlayerPartyVoiceEligible()
            local var6 = useIsUserPartyVoiceEligible(var4)
            local bool5 = useIsCurrentSquadPartyVoiceEligible() == true

            bool3 = bool5 and var5 and not var6

            bool4 = var5 and bool5 and var6 and not bool2
        end
    end

    local var4 = React.useContext(SquadExternalContractContext)
    local var5 = useCurrentSquadParentChannelId()
    local var6 = var4.useGetConversationFromId(var5 or "")
    local var7 = React.useCallback(function(arg2)
        return arg2.Squad.Presence.byUserId[tostring(arg1)]
    end, { arg1 })

    local var8 = if FFlagSquadsPresenceStoreMigration then useGetPresenceByUserId(tostring(arg1)) else useSelector(var7)

    return React.useMemo(function()
        local tbl1 = {
            VoiceIneligibleButton = bool3,
            JoinButton = isPresenceJoinable(var8),
            RemoveUserButton = 0,
            ViewProfileButton = 0,
            ReportButton = 0,
            MuteVoiceButton = 0
        }
        local bool5 = var6

        if bool5 then
            if var6.type == Constants.CONVERSATION_CHANNEL_GROUP_TYPE then
                bool5 = var6.initiator == var1
            else
                bool5 = false
            end
        end

        tbl1.RemoveUserButton = bool5

        tbl1.ViewProfileButton = not bool1
        tbl1.ReportButton = var3 and not bool2
        tbl1.MuteVoiceButton = bool4

        local result = {}

        for value, value2 in tbl1 do
            if value2 then
                table.insert(result, value)
            end
        end

        return result
    end, {
        bool3,
        bool1,
        var3,
        bool2,
        var8,
        var6,
        var1,
        bool4
    })
end

return useSquadUserDropdownMenuButtons
