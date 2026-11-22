-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local dependencies = require(Squads.dependencies)
local SquadButtonSourceEnum = require(Squads.Enums.SquadButtonSourceEnum)
local SquadButtonClickIntentionEnum = require(Squads.Enums.SquadButtonClickIntentionEnum)

local SharedFlags = require(SquadsParent.SharedFlags)
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local Cryo = dependencies.Cryo
local createConversation = require(SquadsParent.SquadsCore.Thunks).createConversation
local leaveSquad = require(SquadsParent.SquadsCore.Thunks).leaveSquad
local React = dependencies.React

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local useCurrentSquadParentChannelId = require(SquadsParent.SquadsCore.Hooks).useCurrentSquadParentChannelId
local useCurrentSquadSelector = dependencies.Hooks.useCurrentSquadSelector
local useDispatch = dependencies.Hooks.useDispatch
local useLocalization = dependencies.Hooks.useLocalization
local useStore = dependencies.Hooks.useStore

local SquadInviteFriends = require(script.Parent.SquadInviteFriends)

local FFlagPartyDevAPIToRespectThirdPartySettingsEnabled = SharedFlags.FFlagPartyDevAPIToRespectThirdPartySettingsEnabled

local EventNames = require(SquadsParent.SquadsCore.EventNames)

local function QuickStartSquadInviteFriendsContainer(tbl1)
    local squadContext = React.useContext(SquadExternalContractContext)
    local var2 = useDispatch()
    local var3 = useStore()

    local var4 = useCurrentSquadSelector()
    local var5 = useCurrentSquadParentChannelId()
    local var6 = squadContext.useGetConversationFromId(var5)
    local var7 = not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or squadContext.useIsChatEnabled()

    local var8 = useLocalUserId()

    local var9 = useLocalization({ startPartyText = "Feature.Squads.Action.Start" })

    local partyStartedRef = React.useRef(false)

    local var11 = React.useCallback(function(arg1)
        partyStartedRef.current = true
        tbl1.navigateIntoSquadLobby(arg1)
    end, { tbl1.navigateIntoSquadLobby })

    local var12 = React.useCallback(function(userIds)
        local conversationType = if #userIds == 1 then "one_to_one" else "group"

        squadContext.fireSquadAnalytics(EventNames.EnterSquadButtonPressed, {
            partyAttemptId = tbl1.partyAttemptId,
            squadButtonSource = SquadButtonSourceEnum.PartyQuickStartButton,
            squadLocation = squadContext.squadLocation,
            userIntention = SquadButtonClickIntentionEnum.Create
        })

        var2(
            createConversation({
                conversationType = conversationType,
                userIds = userIds,
                source = "conversationCreatedFromPartyQuickStart",
                onSuccessCallback = function(arg1)
                    var11(arg1)
                end,
                squadContext = squadContext
            })
        )
    end, {
        var2,
        tbl1.partyAttemptId,
        tbl1.navigateIntoSquadLobby,
        squadContext.createConversation,
        squadContext.setSquadPrompt,
        squadContext.squadLocation,
        squadContext.fireSquadAnalytics,
        var3
    })

    local useCallback = React.useCallback

    local function func1(arg1)
        local var13 = Cryo.Dictionary.keys(arg1)

        if var4 and var6.type == "one_to_one" and #var13 == 1 then
            local var14 = var13[1]
            local participants = var6.participants

            for _, participant in ipairs(participants) do
                if participant == var14 then
                    var11(var5)
                    return
                end
            end
        end

        if var4 then
            var2(leaveSquad(SquadPromptType.JoinAnotherSquad, squadContext.setSquadPrompt, function()
                var12(var13)
            end, squadContext.squadLocation, not FFlagPartyDevAPIToRespectThirdPartySettingsEnabled or var7))

            return
        end

        var12(var13)
    end

    local navigateIntoSquadLobby = tbl1.navigateIntoSquadLobby
    local setSquadPrompt = squadContext.setSquadPrompt
    local squadLocation = squadContext.squadLocation
    local var13 = if FFlagPartyDevAPIToRespectThirdPartySettingsEnabled then var7 else nil
    local onMultiInvite = useCallback(func1, { var4, var2, var12, var6, var5, navigateIntoSquadLobby, setSquadPrompt, squadLocation, var13 })

    return React.createElement(SquadInviteFriends, {
        onMultiInvite = onMultiInvite,
        buttonText = var9.startPartyText,
        participants = var8 and var8 ~= "" and { var8 } or nil,
        partyStartedRef = partyStartedRef,
        analyticsInfo = React.useMemo(function()
            return {
                partyAttemptId = tbl1.partyAttemptId,
                selectionPageType = "QuickStartInvite"
            }
        end, { tbl1.partyAttemptId }),
        onSelectedFriendsChanged = tbl1.onSelectedFriendsChanged,
        shouldHideFooterButton = tbl1.shouldHideFooterButton
    })
end

return QuickStartSquadInviteFriendsContainer
