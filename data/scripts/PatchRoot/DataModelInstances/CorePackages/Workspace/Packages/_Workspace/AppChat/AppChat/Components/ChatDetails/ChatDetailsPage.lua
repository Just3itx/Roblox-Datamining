-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:51:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Logger = require(script.Parent.Logger)
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local useCallback = React.useCallback
local memo = React.memo
local Images = require(AppChatParent.UIBlox).App.ImageSet.Images
local useTextSizeOffset = require(AppChatParent.UIBlox).Core.Style.useTextSizeOffset

local useTokens = require(AppChatParent.Foundation).Hooks.useTokens

local SectionHeader = require(script.Parent.SectionHeader)
local GroupNameEntryCell = require(script.Parent.GroupNameEntryCell)
local AddFriendsEntry = require(script.Parent.AddFriendsEntry)
local ParticipantList = require(script.Parent.ParticipantList)
local LeaveGroupCell = require(script.Parent.LeaveGroupCell)
local TestStyle = require(AppChat.SocialLibraries).Components.TestStyle
local ConversationTypeCell = require(script.Parent.UnfilteredThreads.ConversationTypeCell)
local CreateUnfilteredChatCell = require(script.Parent.UnfilteredThreads.CreateUnfilteredChatCell)

local useIsAppChatVerticallyConstrained = require(AppChat.App.Hooks.useIsAppChatVerticallyConstrained)
local bool1 = game:DefineFastFlag("AppChatDetailsPageAutomaticCanvasSize", false)
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local DomLocators = require(AppChat.Utils.DomLocators)

local useIsChatUserMessagesEnabled = require(AppChat.Hooks.useIsChatUserMessagesEnabled)

local tbl1 = {
    participants = {},
    localUserId = nil,
    conversation = nil,
    conversationId = nil,
    isGroupConversation = false,
    topBarHeight = 0,
    shouldShowCreateUnfilteredChat = false,
    shouldHideGroupChatFunctionality = false,
    shouldShowAddFriends = true,
    shouldShowConversationTypeInfo = true,
    navigateBack = function() end,
    conversationTitle = "PlaceholderTitle",
    pageHeaderText = "localizedText.ChatDetails",
    generalText = "localizedText.General",
    membersText = "localizedText.Members",
    addFriendsText = "localizedText.AddFriends",
    leaveGroupText = "localizedText.LeaveGroup",
    onlinePresenceText = "localizedText.OnlineText",
    offlinePresenceText = "localizedText.OfflineText",
    conversationTypeHeaderText = "Expressive Chat Features",
    conversationTypeText = "localizedText.ConversationTypeText",
    createUnfilteredChatText = "Create new chat without filters",
    createUnfilteredChatSubTitleText = "All members of this conversation will be invited, but some are not eligible to join.",
    onGroupNameEntryCellActivated = function(_)
        Logger:warning("onGroupNameEntryCellActivated was not passed to ChatDetailsPage")
    end,
    onAddFriendsCellActivated = function(_)
        Logger:warning("onAddFriendsCellActivated was not passed to ChatDetailsPage")
    end,
    onLeaveGroupCellActivated = function(_)
        Logger:warning("onLeaveGroupCellActivated was not passed to ChatDetailsPage")
    end,
    onParticipantCellActivated = function(_, _)
        Logger:warning("onParticipantCellActivated was not passed to ChatDetailsPage")
    end,
    onConversationTypeIconActivated = function(_)
        Logger:warning("onConversationTypeIconActivated was not passed to ChatDetailsPage")
    end,
    onCreateUnfilteredChatCellActivated = function(_)
        Logger:warning("onCreateUnfilteredChatCellActivated was not passed to ChatDetailsPage")
    end,
    LayoutOrder = 0,
    style = Cryo.Dictionary.join(TestStyle, { Tokens = { Color = { None = {} }, Size = { Size_0 = 0 } } })
}

function ChatDetailsPage(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local style = var1.style
    local var2 = useTextSizeOffset()
    local var3 = useTokens().Size.Size_1200 + 2 * var2

    local var4 = useIsAppChatVerticallyConstrained()
    local tbl3 = {
        ChatGroupHeader = {
            marginTop = style.Tokens.Size.Size_0,
            marginBottom = style.Tokens.Size.Size_0
        },
        MembersHeader = {
            marginTop = style.Tokens.Size.Size_0,
            marginBottom = style.Tokens.Size.Size_0
        },
        GroupNameEntryCell = {
            paddingBottom = style.Tokens.Size.Size_0
        }
    }

    local function onActivated()
        var1.onGroupNameEntryCellActivated(var1.conversation)
    end

    local function func1()
        var1.onAddFriendsCellActivated(var1.conversation)
    end

    local function func2()
        var1.onLeaveGroupCellActivated(var1.conversation)
    end

    local function onEntryActivated(arg1, arg2)
        Logger:info("onParticipantCellActivated: {}", arg1.id)
        if arg1.isLocalUser then
            return
        end

        var1.onParticipantCellActivated(arg1.id, arg2)
    end

    local var5 = useCallback(function()
        var1.onCreateUnfilteredChatCellActivated(var1.conversation)
    end, { var1.conversation })

    local var6 = useCallback(function(_, swipeDirection, arg1)
        if not var1.wideMode and swipeDirection == Enum.SwipeDirection.Right and arg1 == 1 then
            var1.navigateBack()
        end
    end)

    local num1 = 0
    for _, _ in pairs(var1.participants) do
        num1 += 1
    end

    local var7 = useIsChatUserMessagesEnabled()
    local shouldShowAddFriends = var1.shouldShowAddFriends

    if shouldShowAddFriends then
        num1 += 1
    end

    local yOffset = num1 * var3

    local var8 = yOffset + 8 * var3

    local bool2 = not var7

    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl4 = {
        AutoButtonColor = false,
        BackgroundColor3 = style.Theme.BackgroundDefault.Color,
        BorderSizePixel = 0,
        LayoutOrder = var1.LayoutOrder,
        Size = UDim2.new(1, 0, 1, 0),
        Text = "",
        Transparency = style.Tokens.Color.None.Transparency,
        [React.Event.TouchSwipe] = var6,
        Selectable = false
    }
    local tbl5 = { ScrollingContent = 0 }
    local createElement2 = React.createElement
    local str2 = "ScrollingFrame"
    local tbl6 = {
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(1, 0, 0, if bool1 then 0 else var8),
        AutomaticCanvasSize = if bool1 then Enum.AutomaticSize.Y else nil,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        LayoutOrder = var1.LayoutOrder,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = false
    }
    local tbl7 = {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        ChatGroupHeader = var1.isGroupConversation
            and React.createElement(SectionHeader, {
                marginTop = if var4 then tbl3.ChatGroupHeader.marginTop else 20,
                marginBottom = if var4 then tbl3.ChatGroupHeader.marginBottom else nil,
                LayoutOrder = 1,
                Text = var1.chatGroupText,
                style = var1.style
            }),
        GroupNameEntryCell = 0,
        MembersHeader = 0,
        MembersFrame = 0,
        LeaveGroupCell = 0,
        ConversationTypeHeader = 0,
        ConversationTypeCell = 0,
        CreateUnfilteredChatCell = 0
    }

    local isGroupConversation2 = var1.isGroupConversation
    isGroupConversation2 = isGroupConversation2
        and React.createElement(GroupNameEntryCell, {
            LayoutOrder = 2,
            groupNameText = var1.conversationTitle,
            iconImage = Images["icons/actions/edit/edit"],
            isDisabled = var1.shouldHideGroupChatFunctionality or bool2,
            cellHeight = var3,
            paddingBottom = if var4 then tbl3.GroupNameEntryCell.paddingBottom else nil,
            onActivated = onActivated,
            style = var1.style
        })
    tbl7.GroupNameEntryCell = isGroupConversation2

    tbl7.MembersHeader = React.createElement(SectionHeader, {
        LayoutOrder = 3,
        marginTop = if var4 then tbl3.MembersHeader.marginTop else 14,
        marginBottom = if var4 then tbl3.MembersHeader.marginBottom else 8,
        Text = var1.membersText,
        style = var1.style
    })

    tbl7.MembersFrame = React.createElement("Frame", {
        Size = UDim2.new(1, 0, 0, yOffset),
        BackgroundColor3 = style.Theme.BackgroundDefault.Color,
        BackgroundTransparency = style.Tokens.Color.None.Transparency,
        BorderSizePixel = 0,
        LayoutOrder = 4
    }, {
        UIListLayout = React.createElement(
            "UIListLayout",
            {
                VerticalAlignment = Enum.VerticalAlignment.Top,
                SortOrder = Enum.SortOrder.LayoutOrder
            }
        ),
        AddFriendsCell = if shouldShowAddFriends then React.createElement(AddFriendsEntry, {
            LayoutOrder = 1,
            Text = var1.addFriendsText,
            iconImage = Images["icons/actions/edit/add"],
            cellHeight = var3,
            onActivated = func1,
            style = var1.style
        }) else nil,
        ParticipantList = React.createElement(ParticipantList, {
            activeParticipantId = var1.activeParticipantId,
            LayoutOrder = 2,
            entries = var1.participants,
            entryHeight = var3,
            onlinePresenceText = var1.onlinePresenceText,
            offlinePresenceText = var1.offlinePresenceText,
            childWidth = 120,
            onEntryActivated = onEntryActivated
        })
    })

    local isGroupConversation3 = var1.isGroupConversation
        and React.createElement(LeaveGroupCell, {
            LayoutOrder = 5,
            leaveGroupText = var1.leaveGroupText,
            iconImage = Images["icons/controls/vehicle/exit"],
            cellHeight = var3,
            onActivated = func2,
            style = var1.style,
            testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.chatDetailsListActionButton("leaveGroup") else nil
        })
    tbl7.LeaveGroupCell = isGroupConversation3

    tbl7.ConversationTypeHeader = if var7 then React.createElement(
        SectionHeader,
        {
            LayoutOrder = 6,
            marginTop = 26,
            Text = var1.conversationTypeHeaderText,
            style = var1.style
        }
    ) else nil

    tbl7.ConversationTypeCell = if var7 then React.createElement(ConversationTypeCell, {
        layoutOrder = 7,
        bodyText = var1.conversationTypeText,
        iconImage = Images["icons/actions/info"],
        onIconActivated = var1.onConversationTypeIconActivated,
        shouldShowIcon = var1.shouldShowConversationTypeInfo,
        style = var1.style
    }) else nil
    local element

    if var7 and var1.shouldShowCreateUnfilteredChat then
        element = React.createElement(CreateUnfilteredChatCell, {
            layoutOrder = 8,
            bodyText = var1.createUnfilteredChatText,
            subTitleText = var1.createUnfilteredChatSubTitleText,
            iconImage = Images["icons/actions/edit/copy"],
            cellHeight = var3,
            isLoading = var1.isCreateUnfilteredChatLoading,
            conversationId = var1.conversationId,
            onActivated = var5,
            style = var1.style
        })
    else
        element = nil
    end

    tbl7.CreateUnfilteredChatCell = element
    tbl5.ScrollingContent = createElement2(str2, tbl6, tbl7)
    return createElement(str1, tbl4, tbl5)
end

return memo(ChatDetailsPage)
