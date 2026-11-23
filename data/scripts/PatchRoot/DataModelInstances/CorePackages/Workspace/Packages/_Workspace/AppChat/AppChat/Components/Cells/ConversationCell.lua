-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local Images = require(AppChatParent.UIBlox).App.ImageSet.Images
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization

local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local useNavigation = require(AppChatParent.Navigation).useNavigation
local EnumScreens = require(AppChat.EnumScreens)
local TestStyle = require(AppChat.SocialLibraries).Components.TestStyle
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local useIsInExperience = require(AppChat.Hooks.useIsInExperience)
local getConversationTitle = require(AppChat.Conversations.getConversationTitle)

local usePageTracker = require(AppChatParent.PageLoadTracker).usePageTracker
local FFlagLuaAppEnableChatMilestones = require(AppChatParent.SharedFlags).FFlagLuaAppEnableChatMilestones
local FFlagLuaAppEnablePageLoadTracker = require(AppChatParent.SharedFlags).FFlagLuaAppEnablePageLoadTracker
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagEnableBlackbirdCheck = require(AppChatParent.SharedFlags).FFlagEnableBlackbirdCheck
local useIsRobloxSubscriber = require(AppChatParent.UserProfiles).Hooks.useIsRobloxSubscriber
local useGetOneToOneFriendIdFromConversationId = require(AppChat.Hooks.useGetOneToOneFriendIdFromConversationId)
local useConversationAvatarPresenceImage = require(AppChat.Hooks.useConversationAvatarPresenceImage)
local PresenceBubbleCellStyled = require(script.Parent.PresenceBubbleCellStyled)

local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)
local FFlagAppChatServerSideConversationSearch = require(AppChat.Flags.FFlagAppChatServerSideConversationSearch)

local tbl1 = {
    messageUnavailableKey = "Feature.Chat.Message.MessageUnavailable",
    boldTitle = true,
    childWidth = 0,
    isLoading = false,
    Size = UDim2.new(1, 0, 1, 0),
    hideLeftAvatarPadding = false,
    style = Cryo.Dictionary.join(TestStyle, { Tokens = { Color = { None = {} } } })
}

return React.memo(function(tbl2) -- name: ConversationCell
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local conversation = var1.conversation

    local var2 = useIsUserPending(conversation or {})
    local var3 = useIsInExperience()

    local var4 = useGetOneToOneFriendIdFromConversationId(conversation and conversation.id)

    local var5 = useIsRobloxSubscriber(if FFlagEnableBlackbirdCheck then var4 else nil)
    local var6 = if FFlagAppChatPresenceStoreMigration then useConversationAvatarPresenceImage(var4) else nil
    local var7 = FocusNavigationUtils.useLastInputMode()
    local var8 = useNavigation()
    local var9 = if FFlagLuaAppEnablePageLoadTracker and FFlagLuaAppEnableChatMilestones then usePageTracker() else nil

    React.useEffect(function()
        if FFlagLuaAppEnablePageLoadTracker and FFlagLuaAppEnableChatMilestones and not var3 then
            var9:sendMilestone("main_cta_interactable")
        end
    end, {})

    local bool1 = FFlagAppChatServerSideConversationSearch

    if bool1 then
        if var1.conversation.isSearchResult == true then
            bool1 = var1.onActivated ~= nil
        else
            bool1 = false
        end
    end

    local onActivated = React.useCallback(function()
        if var7 == "Focus" and var8 and not bool1 then
            var8.navigate(EnumScreens.ChatConversation, { conversationId = var1.conversation.id, navigatedWithFocus = true })
        elseif var1.onActivated then
            var1.onActivated(var1.conversation)
        end
    end, {
        var1.onActivated,
        var1.conversation,
        var7,
        var8,
        bool1
    })

    local titleText = getConversationTitle(conversation)
    local var11 = var1.subTitleText and var1.subTitleText:split("\n")
    local var12 = var11 and var11[1] or ""

    local var13 = useLocalization({ subTitleText = var1.messageUnavailableKey })

    if var2 then
        var12 = var13.subTitleText
    end

    local createElement = React.createElement
    local var14 = PresenceBubbleCellStyled
    local tbl3 = {
        boldTitle = var1.boldTitle,
        style = var1.style,
        childWidth = var1.childWidth,
        onActivated = onActivated,
        onCircleActivated = var1.onCircleActivated,
        subTitleText = var12,
        subTitleTimestamp = var1.subTitleTimestamp,
        subTitleIcon = if var2 then Images["icons/status/private_small"] or nil else nil,
        secondaryTitleText = var1.secondaryTitleText,
        testId = if FFlagDebugAppChatEnableDomLocators then var1.testId else nil,
        Size = var1.Size,
        isLoading = var1.isLoading,
        avatarCirclePresenceImage = 0,
        titleText = 0,
        thumbnails = 0,
        conversationId = 0,
        participants = 0,
        hideLeftAvatarPadding = 0,
        paddingLeft = 0,
        paddingRight = 0,
        isRobloxSubscriber = 0
    }

    if not FFlagAppChatPresenceStoreMigration then
        var6 = conversation.presenceImage
    end

    tbl3.avatarCirclePresenceImage = var6

    tbl3.titleText = titleText
    tbl3.thumbnails = conversation.thumbnails
    tbl3.conversationId = conversation.id

    tbl3.participants = if FFlagAppChatServerSideConversationSearch and conversation.isSearchResult then conversation.participants else nil

    tbl3.hideLeftAvatarPadding = var1.hideLeftAvatarPadding
    tbl3.paddingLeft = var1.paddingLeft
    tbl3.paddingRight = var1.paddingRight
    if not FFlagEnableBlackbirdCheck then
        var5 = nil
    end

    tbl3.isRobloxSubscriber = var5
    return createElement(var14, tbl3, var1.children or {})
end)
