-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Cryo = require(AppChatParent.Cryo)
local _UIBlox = require(AppChatParent.UIBlox)
local SocialLibraries = require(AppChat.SocialLibraries)
local useTokens = require(AppChatParent.Foundation).Hooks.useTokens
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local FFlagAppChatRemoveConversationListDivider = require(AppChat.Flags.FFlagAppChatRemoveConversationListDivider)

local PresenceBubbleCell = require(script.Parent.PresenceBubbleCell)
local TestStyle = SocialLibraries.Components.TestStyle

local tbl1 = {
    Size = UDim2.new(1, 0, 1, 0),
    avatarCirclePresenceImage = nil,
    subTitleText = nil,
    subTitleIcon = nil,
    titleText = "TestUser",
    secondaryTitleText = nil,
    thumbnails = {},
    conversationId = nil,
    childWidth = 0,
    style = Cryo.Dictionary.join(TestStyle, { Tokens = { Color = { None = {} } } }),
    showDivider = not FFlagAppChatRemoveConversationListDivider,
    boldTitle = true,
    isLoading = false,
    hideLeftAvatarPadding = false,
    paddingLeft = 0,
    paddingRight = 0
}

return React.memo(function(tbl2) -- name: StyledCell
    local var1 = useTokens()
    local var2 = Cryo.Dictionary.join(tbl1, tbl2)
    local style = var2.style
    local theme = style.Theme
    local font = style.Font

    local showNewPresenceImage = type(var2.avatarCirclePresenceImage) == "table"

    return React.createElement(PresenceBubbleCell, {
        childWidth = var2.childWidth,
        titleText = var2.titleText,
        secondaryTitleText = var2.secondaryTitleText,
        subTitleText = var2.subTitleText,
        subTitleTimestamp = var2.subTitleTimestamp,
        subTitleIcon = var2.subTitleIcon,
        testId = if FFlagDebugAppChatEnableDomLocators then var2.testId else nil,
        avatarCirclePresenceImage = var2.avatarCirclePresenceImage,
        thumbnails = var2.thumbnails,
        onActivated = var2.onActivated,
        onCircleActivated = var2.onCircleActivated,
        Size = var2.Size,
        isLoading = var2.isLoading,
        showNewPresenceImage = showNewPresenceImage,
        conversationId = var2.conversationId,
        participants = var2.participants,
        BackgroundColor3 = theme.BackgroundDefault.Color,
        BackgroundTransparency = style.Tokens.Color.None.Transparency,
        onPressedBackgroundColor3 = theme.BackgroundOnPress.Color,
        onPressedBackgroundTransparency = theme.BackgroundOnPress.Transparency,
        avatarCircleBackgroundColor3 = theme.PlaceHolder.Color,
        avatarCircleDividerColor3 = theme.PlaceHolder.Color,
        avatarCirclePresenceImageColor3 = if showNewPresenceImage then theme.OnlineStatus.Color else nil,
        avatarCirclePresenceImageTransparency = if showNewPresenceImage then theme.OnlineStatus.Transparency else nil,
        subTitleTextFont = var1.Typography.BodySmall.Font,
        subTitleTextTransparency = theme.TextDefault.Transparency,
        subTitleTextColor3 = theme.TextDefault.Color,
        subTitleTextSize = font.CaptionBody.RelativeSize * font.BaseSize,
        subTitleIconColor3 = style.Theme.IconDefault.Color,
        subTitleIconTransparency = style.Theme.IconDefault.Transparency,
        titleFont = var1.Typography.TitleLarge.Font,
        titleTextTransparency = if var2.boldTitle then theme.TextEmphasis.Transparency else theme.TextDefault.Transparency,
        titleTextColor3 = if var2.boldTitle then theme.TextEmphasis.Color else theme.TextDefault.Color,
        titleTextSize = font.Header2.RelativeSize * font.BaseSize,
        secondaryTitleFont = var1.Typography.TitleLarge.Font,
        secondaryTitleTextTransparency = theme.TextMuted.Transparency,
        secondaryTitleTextColor3 = theme.TextMuted.Color,
        secondaryTitleTextSize = font.Header2.RelativeSize * font.BaseSize,
        showDivider = var2.showDivider,
        dividerTransparency = theme.Divider.Transparency,
        dividerColor3 = theme.Divider.Color,
        avatarCircleSize = var1.Size.Size_1000,
        avatarCircleCellWidth = var1.Size.Size_1200,
        hideLeftAvatarPadding = var2.hideLeftAvatarPadding,
        paddingLeft = var2.paddingLeft,
        paddingRight = var2.paddingRight,
        isRobloxSubscriber = var2.isRobloxSubscriber
    }, var2.children or {})
end)
