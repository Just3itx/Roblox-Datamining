-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local SocialLibraries = require(AppChat.SocialLibraries)

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local Promise = require(AppChatParent.Promise)
local memo = React.memo
local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useState = React.useState
local useRef = React.useRef

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local parseCreateConversationErrors = require(AppChat.Conversations.Thunks.parseCreateConversationErrors)
local expandToGroupConversation = require(AppChat.Conversations.Thunks.expandToGroupConversation)
local useAnalytics = require(AppChat.Analytics.useAnalytics)

local ResponseIndicator = SocialLibraries.Components.ResponseIndicator
local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local SelectChatMembersContainer = require(AppChat.Components.SelectChatMembers.SelectChatMembersContainer)

local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)

local tbl1 = {
    systemButtonText = if GetFFlagIsSquadEnabled() then "Feature.Chat.Action.Create" else "Feature.Chat.Action.StartChatWithFriends",
    pageHeaderText = if GetFFlagIsSquadEnabled() then "Feature.Chat.Heading.PartyWithConnections" else "Feature.Chat.Heading.ChatWithConnections",
    minSelections = 1,
    maxSelections = 5,
    maxConversationSize = 5,
    topBarHeight = nil,
    conversation = nil,
    setSystemButtonActivated = function(_) end,
    setSystemButtonEnabled = function(_) end
}

return memo(function(tbl2) -- name: EditChatMembersContainer
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useRef({})
    local var3 = useRef(false)
    local var4, var5 = useState(false)
    local var6 = useAnalytics()

    local localUserId = useSelector(useCallback(function(arg1)
        return arg1.LocalUserId
    end, {}))

    local var8 = useDispatch()

    local var9 = useCallback(function(arg1, arg2)
        return var8(AppChatNetworking.rodux.AddUserToConversation.API(arg2, arg1))
    end, { var8 })

    local var10 = useCallback(function(arg1)
        return var8(createConversation("group", arg1, var6, "userAddedParticipantToOneToOne"))
    end, { var8 })

    local var11 = useCallback(function(toastTitle)
        var1.navigateToToast({ toastProps = { toastContent = { toastTitle = toastTitle } } })
    end, { var1.navigateToToast })

    local function selectedUsersChanged(arg1, arg2)
        var2.current = Cryo.List.map(arg1, function(arg3)
            return arg3.id
        end)

        local current = arg2 <= #arg1
        if var3.current ~= current then
            var3.current = current
            var1.setSystemButtonEnabled(current)
        end
    end

    local var12 = useCallback(function(arg1)
        if var4 then
            return Promise.resolve()
        end
        local id = var1.conversation.id
        local conversationType = var1.conversation.conversationType
        local function func2(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
            local var12 = if parseCreateConversationErrors(arg2) == "participant_chat_disabled" then arg1.invalidParticipantText else arg1.networkErrorText
            var11(var12)
            var5(false)
        end

        var5(true)

        if conversationType == Conversation.Type.MULTI_USER_CONVERSATION then
            return var9(var2.current, id):andThen(function()
                var1.navigateToConversation(id)
            end, func2)
        elseif conversationType == Conversation.Type.ONE_TO_ONE_CONVERSATION then
            if var1.conversation.hasGroupUp and var1.conversation.moderationType == ConversationChannels.ModerationType.TrustedComms then
                var11(arg1.cannotExpandToGroupChatActivePartyText)
                var5(false)
                return Promise.reject("Cannot expand to group chat while there is an active party if the chat has expanded chat features")
            end

            local var12 = Cryo.List.filter(Cryo.List.join(var2.current, var1.conversation.participants), function(arg2): boolean
                return arg2 ~= localUserId
            end)

            if var1.conversation.source == "channels" or var1.conversation.source == "chat" then
                return var8(expandToGroupConversation(id, var12, var6)):andThen(function(arg2)
                    var1.navigateToConversation(arg2.id)
                end, func2)
            end

            return var10(var12):andThen(function(arg2)
                var1.navigateToConversation(arg2.id)
            end, func2)
        else
            func2({ Body = "conversationType not supported", StatusCode = 400 })
            return Promise.reject(string.format("conversationType not supported: %q", tostring(conversationType)))
        end
    end, {
        var8,
        var4,
        var5,
        var2,
        var1.navigateToConversation,
        var1.conversation.id,
        var1.conversation.conversationType,
        var1.conversation.participants,
        var1.conversation.source,
        var11,
        var6
    })

    useEffect(function()
        var1.setSystemButtonActivated(var12)
    end, { var1.setSystemButtonActivated, var12 })

    return React.createElement(
        "ImageButton",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Active = true,
            AutoButtonColor = false
        },
        {
            responseIndicator = var4
                and React.createElement(ResponseIndicator, { soakAreaColor3 = Color3.fromRGB(25, 25, 25), soakAreaTransparency = 0.8 }),
            selectChatMembers = React.createElement(
                SelectChatMembersContainer,
                Cryo.Dictionary.join(var1, {
                    maxSelections = var1.maxSelections - #var1.conversation.participants + 1,
                    selectedUsersChanged = selectedUsersChanged,
                    localUserId = localUserId
                })
            )
        }
    )
end)
