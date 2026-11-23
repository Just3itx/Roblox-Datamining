-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:20:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)

local ResponseIndicator = require(AppChat.SocialLibraries).Components.ResponseIndicator

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo
local Promise = require(AppChatParent.Promise)
local useCallback = React.useCallback
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useEffect = React.useEffect
local useIsGroupChatEnabled = require(AppChat.Hooks.useIsGroupChatEnabled)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local useState = React.useState
local useRef = React.useRef
local AppNavBar = require(AppChatParent.AppNavBar)
local UniversalAppPolicy = require(AppChatParent.UniversalAppPolicy)

local Conversation = require(AppChat.Models.Conversation)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local parseCreateConversationErrors = require(AppChat.Conversations.Thunks.parseCreateConversationErrors)
local SelectChatMembersContainer = require(AppChat.Components.SelectChatMembers.SelectChatMembersContainer)

local EventNames = require(AppChat.Analytics.EventNames)
local useAnalytics = require(AppChat.Analytics.useAnalytics)
local CreateConversationError = require(AppChat.Analytics.Enums.CreateConversationError)
local SharedFlags = require(AppChatParent.SharedFlags)
local FFlagAppIaScrollAway = SharedFlags.FFlagAppIaScrollAway
local FFlagAppIaScrollAwayFixSocial = SharedFlags.FFlagAppIaScrollAwayFixSocial
local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled
local FFlagFixPaginatedChatMembersCutoff = require(AppChat.Flags.FFlagFixPaginatedChatMembersCutoff)

local tbl1 = {
    systemButtonText = if GetFFlagIsSquadEnabled() then "Feature.Chat.Action.Create" else "Feature.Chat.Action.StartChatWithFriends",
    pageHeaderText = if GetFFlagIsSquadEnabled() then if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "Feature.Chat.Title.NewChat" else "Feature.Chat.Heading.PartyWithFriends" else "Feature.Chat.Heading.ChatWithConnections",
    topBarHeight = nil,
    minSelections = 1,
    maxSelections = 5,
    maxConversationSize = 5,
    conversation = Conversation.empty(),
    setSystemButtonActivated = function(_) end,
    setSystemButtonEnabled = function(_) end
}

function CreateNewChatContainer(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useRef({})
    local var3 = useRef(false)
    local var4, var5 = useState(false)
    local var6 = if FFlagAppIaScrollAway and not FFlagAppIaScrollAwayFixSocial then useIsInExperience() else nil
    local maxSelections = var1.maxSelections
    local maxConversationSize = var1.maxConversationSize
    local bool1

    if useIsGroupChatEnabled() then
        bool1 = false
    else
        maxSelections = 1
        maxConversationSize = 1
        bool1 = true
    end

    local var7 = useDispatch()

    local var8 = useCallback(function(toastTitle)
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

    local var9 = useAnalytics()

    local var10 = useCallback(function(arg1)
        if var4 or not var2.current then
            return Promise.resolve()
        end

        var5(true)

        local str1 = if #var2.current == 1 then "one_to_one" else "group"

        return var7(createConversation(str1, var2.current, var9, "userCreatedNewConversation")):andThen(function(arg2)
            var1.navigateToConversation(arg2.id)
        end):catch(function(arg2)
            local var10 = if parseCreateConversationErrors(arg2) == "participant_chat_disabled" then arg1.invalidParticipantText else arg1.networkErrorText
            var8(var10)
            var5(false)

            if var9 then
                var9.fireAnalyticsEvent(
                    EventNames.NewConversationCreated,
                    {
                        createConversationResult = CreateConversationError.FetchConversationError
                    }
                )
            end
        end)
    end, {
        var7,
        var4,
        var5,
        var2,
        var1.navigateToConversation,
        var8,
        var9
    })

    useEffect(function()
        var1.setSystemButtonActivated(var10)
    end, { var1.setSystemButtonActivated, var10 })

    return React.createElement("ImageButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Active = true,
        AutoButtonColor = false,
        Selectable = not FFlagFixPaginatedChatMembersCutoff and nil
    }, {
        UIPadding = if FFlagAppIaScrollAway
            and not FFlagAppIaScrollAwayFixSocial
            and not var6
            and AppNavBar.getScrollAwayEnabled()
            and var1.topBarHeight ~= nil then React.createElement("UIPadding", { PaddingTop = UDim.new(0, var1.topBarHeight) }) else nil,
        responseIndicator = var4
            and React.createElement(ResponseIndicator, { soakAreaColor3 = Color3.fromRGB(25, 25, 25), soakAreaTransparency = 0.8 }),
        selectChatMembers = React.createElement(
            SelectChatMembersContainer,
            Cryo.Dictionary.join(var1, {
                selectedUsersChanged = selectedUsersChanged,
                maxSelections = maxSelections,
                maxConversationSize = maxConversationSize,
                canOnlyCreateOneToOneChat = bool1
            })
        )
    })
end

return memo(CreateNewChatContainer)
