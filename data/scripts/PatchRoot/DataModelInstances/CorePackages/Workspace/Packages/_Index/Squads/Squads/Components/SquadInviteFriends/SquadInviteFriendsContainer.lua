-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local dependencies = require(Squads.dependencies)

local SquadInviteSourceEnum = require(Squads.Enums.SquadInviteSourceEnum)
local inviteToSquad = require(Squads.Thunks.inviteToSquad)
local InviteToParentChannel = require(Squads.Thunks.InviteToParentChannel)

local NotificationModalsManager = require(SquadsParent.NotificationModalsManager)
local Promise = require(SquadsParent.Promise)
local UIBlox = require(SquadsParent.UIBlox)
local useAppPolicy = require(SquadsParent.UniversalAppPolicy).useAppPolicy
local useLocalUserId = require(SquadsParent.RobloxAppHooks).useLocalUserId

local Cryo = dependencies.Cryo
local React = dependencies.React
local useCurrentSquadSelector = dependencies.Hooks.useCurrentSquadSelector
local useDispatch = dependencies.Hooks.useDispatch
local useLocalization = dependencies.Hooks.useLocalization
local Constants = require(SquadsParent.SquadsCore.Constants)

local SquadExternalContractContext = require(SquadsParent.SquadsCore.SquadExternalContractProvider).SquadExternalContractContext
local EventNames = require(SquadsParent.SquadsCore.EventNames)
local SquadPromptType = require(SquadsParent.SquadsCore.Enums).SquadPromptType
local useNavigation = dependencies.useNavigation
local useStore = dependencies.Hooks.useStore

local Images = UIBlox.App.ImageSet.Images

local SquadInviteFriends = require(script.Parent.SquadInviteFriends)

local function SquadInviteFriendsContainer(arg1)
    local squadExternalContext = React.useContext(SquadExternalContractContext)
    local var2 = useNavigation()
    local dispatch = useDispatch()
    local var4 = useStore()

    local var5 = useLocalization({
        addText = "Feature.Squads.Action.Add",
        user = "Feature.Squads.Description.User",
        youAddedMoreThanTwoToChat = "Feature.Squads.Description.YouAddedMoreThanTwoToChat",
        youAddedToChat = "Feature.Squads.Description.YouAddedToChat",
        youAddedTwoToChat = "Feature.Squads.Description.YouAddedTwoToChat"
    })

    local partyStartedRef = React.useRef(false)

    local var7 = useCurrentSquadSelector()
    local parentChannelId = if var7 and var7.parentChannelId then var7.parentChannelId else ""

    local parentChannel = squadExternalContext.useGetConversationFromId(parentChannelId)

    local var10 = useLocalUserId()

    local var11 = React.useCallback(function(arg2)
        return arg2.getCanUsePlatformChat()
    end, {})
    local var12 = useAppPolicy(var11)

    local var13 = React.useCallback(function(arg2)
        local var13 = Cryo.Dictionary.keys(arg2)

        local displayName = arg2[var13[1]].displayName
        local var14

        if #var13 > 2 then
            var14 = var5.youAddedMoreThanTwoToChat:gsub("{(.-)}", { username = displayName, userCountMinusOne = tostring(#var13 - 1) })
        elseif #var13 == 2 then
            local displayName2 = arg2[var13[2]].displayName
            var14 = var5.youAddedTwoToChat:gsub("{(.-)}", { username1 = displayName, username2 = displayName2 })
        else
            var14 = var5.youAddedToChat:gsub("{(.-)}", { username = displayName })
        end

        NotificationModalsManager.SetUIBloxToast({ iconImage = Images["icons/actions/friends/friendAdd"], toastTitle = var14 })
    end, { var5.youAddedMoreThanTwoToChat, var5.youAddedToChat, var5.youAddedTwoToChat })

    local var14 = React.useCallback(function(arg2)
        local var14 = Cryo.Dictionary.union({ parentChannelId = parentChannelId, source = SquadInviteSourceEnum.SourceSquadInvitePage }, arg2)

        squadExternalContext.fireSquadAnalytics(EventNames.SquadInvite, var14)
    end, { parentChannelId, squadExternalContext.fireSquadAnalytics })

    local onMultiInvite = React.useCallback(function(arg2)
        if not (var7 and parentChannel) then
            return
        end

        local var15 = Cryo.Dictionary.keys(arg2)

        local var16 = Cryo.List.toSet(parentChannel.participants)

        local userIds = Cryo.List.filter(var15, function(arg3): boolean
            return var16[arg3] == nil
        end)

        local function onConfirm()
            local var18 = Cryo.List.filter(parentChannel.participants, function(arg3): boolean
                return Cryo.List.find(var15, tostring(arg3)) == nil and arg3 ~= var10
            end)

            local tbl1 = {}
            if #var18 > 0 then
                for _, value in ipairs(var18) do
                    table.insert(tbl1, squadExternalContext.removeUserFromParentChannel(dispatch, parentChannel.id, value))
                end
            end

            Promise.all(tbl1):andThen(function()
                if not (#userIds > 0) then
                    var2.pop()

                    return
                end

                dispatch(
                    InviteToParentChannel({
                        dispatch = dispatch,
                        onErrorCallback = function()
                            if #var18 > 0 then
                                var2.pop()
                            end
                        end,
                        onSuccessCallback = function(id: string)
                            local bool1 = id ~= parentChannel.id
                            dispatch(inviteToSquad(var7.squadId, id, var10, userIds, var14, bool1))

                            var13(arg2)
                            var2.pop()
                        end,
                        parentChannel = parentChannel,
                        userIds = userIds,
                        squadExternalContext = squadExternalContext
                    })
                )
            end)
        end

        if parentChannel.type == Constants.CONVERSATION_CHANNEL_ONE_TO_ONE_TYPE
            and parentChannel.moderationType == Constants.TRUSTED_COMM_MODERATION_TYPE
        then
            squadExternalContext.setSquadPrompt(var4, {
                hideCancelButton = true,
                promptType = SquadPromptType.CannotExpandToGroupChatActiveParty,
                onConfirm = function()
                    var2.pop()
                end
            })

            return
        end

        if parentChannel.type ~= Constants.CONVERSATION_CHANNEL_GROUP_TYPE or not var12 or not (#userIds > 0) then
            onConfirm()
            return
        end

        squadExternalContext.setSquadPrompt(var4, {
            hideCancelButton = false,
            promptType = SquadPromptType.ConfirmInviteToSquad,
            onConfirm = function()
                onConfirm()
            end
        })
    end, {
        var7,
        dispatch,
        var2,
        parentChannel,
        var14,
        var13,
        squadExternalContext.setSquadPrompt,
        squadExternalContext.inviteToParentChannel,
        var4,
        var12,
        var10,
        squadExternalContext
    })

    return React.createElement(SquadInviteFriends, {
        participants = arg1.participants,
        onMultiInvite = onMultiInvite,
        buttonText = var5.addText,
        analyticsInfo = { selectionPageType = "SquadInvite" },
        partyStartedRef = partyStartedRef,
        onRemoveCallback = parentChannel and function(arg2, displayName)
            if not Cryo.List.find(parentChannel.participants, arg2) then
                return
            end

            squadExternalContext.setSquadPrompt(var4, {
                bodyTextLocalizationProps = {
                    displayName = displayName or var5.user
                },
                hideCancelButton = true,
                promptType = SquadPromptType.RemoveFromParty
            })
        end or nil,
        preselectedUsers = parentChannel and parentChannel.participants and Cryo.List.filter(parentChannel.participants, function(arg2): boolean
            return arg2 ~= var10
        end),
        preselectedUsersUnremovable = if parentChannel then parentChannel.type == Constants.CONVERSATION_CHANNEL_ONE_TO_ONE_TYPE or parentChannel.initiator ~= tostring(var10) else nil,
        onSelectedFriendsChanged = arg1.onSelectedFriendsChanged,
        shouldHideFooterButton = arg1.shouldHideFooterButton
    })
end

return SquadInviteFriendsContainer
