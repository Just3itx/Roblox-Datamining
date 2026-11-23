-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:50:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local useNavigation = require(AppChatParent.Navigation).useNavigation

local SquadExternalContractContext = require(AppChatParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local EventNames = require(AppChatParent.SquadsCore.EventNames)
local useCurrentSquadId = require(AppChatParent.SquadsCore.Hooks).useCurrentSquadId
local SquadButtonClickIntentionEnum = require(AppChatParent.Squads.Enums).SquadButtonClickIntentionEnum
local SquadButtonSourceEnum = require(AppChatParent.Squads.Enums).SquadButtonSourceEnum

local EnumScreens = require(AppChat.EnumScreens)

local function useStartPartySuggestion(str1: string, bool1: boolean)
    local var1 = useNavigation()
    local var2 = useCurrentSquadId()
    local var3 = React.useContext(SquadExternalContractContext)
    local fireSquadAnalytics = var3.fireSquadAnalytics
    local var4 = var3.useParentChannelHasGroupUp(str1)
    local squadLocation = var3.squadLocation
    local canStartParty = bool1 and var2 == nil

    return {
        canStartParty = canStartParty,
        startParty = React.useCallback(function(conversationId: string)
            if not canStartParty then
                return
            end

            fireSquadAnalytics(EventNames.EnterSquadButtonPressed, {
                conversationId = conversationId,
                squadButtonSource = SquadButtonSourceEnum.ChatConversationSmartSuggestion,
                squadLocation = squadLocation,
                userIntention = if var4 then SquadButtonClickIntentionEnum.Join else SquadButtonClickIntentionEnum.Create
            })

            var1.navigate(EnumScreens.SquadLobby, { conversationId = conversationId })
        end, {
            canStartParty,
            fireSquadAnalytics,
            var4,
            var1,
            squadLocation
        })
    }
end
return useStartPartySuggestion
