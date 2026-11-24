-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)
local Foundation = require(FriendsChatParent.Foundation)
local ExpChatShared = require(FriendsChatParent.ExpChatShared)

local useInterpolatedClientSettings = require(FriendsChatParent.ExpChatIntegration.useInterpolatedClientSettings)
local useChatWindowSettings = require(FriendsChatParent.ExpChatIntegration.useChatWindowSettings)
local FFlagFriendsChatAddTopBarDivider = require(script.Parent.Parent.Flags.FFlagFriendsChatAddTopBarDivider)
local FriendsChatFacePile = require(script.Parent.FriendsChatFacePile)
local resolveFade = require(script.Parent.Parent.Utils.resolveFade)

local View = Foundation.View
local Divider = Foundation.Divider
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonSize = Foundation.Enums.ButtonSize
local useTokens = Foundation.Hooks.useTokens

local var1 = ExpChatShared.Logger:new(script.Name)

local function FriendsChatConversationHeaderBar(tbl1)
    local var2 = useTokens()
    local var3 = useChatWindowSettings()
    local var4 = React.useMemo(function()
        return {
            BackgroundColor3 = var3.ChatWindowBackgroundColor3,
            BackgroundTransparency = var3.ChatWindowBackgroundTransparency
        }
    end, { var3 })

    local chatWindowSettings = tbl1.chatWindowSettings
    local var5 = useInterpolatedClientSettings(chatWindowSettings or var4)
    local fontFace = if chatWindowSettings then chatWindowSettings.FontFace else nil

    local var6 = React.useMemo(function()
        if fontFace == nil then
            return nil
        end
        local title = table.clone(var2.Typography.TitleMedium)

        title.Font = if typeof(fontFace) == "Font" then Font.new(fontFace.Family, Enum.FontWeight.Bold, fontFace.Style) else fontFace

        return { title = title }
    end, { var2, fontFace })

    local onBack = tbl1.onBack

    local onActivated = React.useCallback(function()
        var1:info("Back button activated")
        if onBack then
            onBack()
        end
    end, { onBack })

    local ref = React.useRef(nil)
    React.useEffect(function()
        local current = ref.current
        if current and tbl1.onAbsoluteSizeChanged then
            tbl1.onAbsoluteSizeChanged(current)
        end
    end, { tbl1.onAbsoluteSizeChanged })

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Name = "FriendsChatConversationHeaderBar",
        BackgroundColor3 = var5.BackgroundColor3 or var2.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = if tbl1.suppressBackground then 1 else resolveFade(var5.BackgroundTransparency, tbl1.transparencyValue),
        Active = tbl1.interactable == nil or tbl1.interactable,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = tbl1.layoutOrder,
        ZIndex = tbl1.zIndex,
        [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChanged,
        [React.Event.MouseEnter] = tbl1.onHovered,
        [React.Event.MouseLeave] = tbl1.onUnhovered,
        ref = ref
    }
    local tbl3 = { Content = 0 }

    local createElement2 = React.createElement
    local str2 = "CanvasGroup"
    local tbl4 = {
        Name = "FriendsChatConversationHeaderContent",
        BackgroundTransparency = 1,
        GroupTransparency = resolveFade(0, tbl1.transparencyValue),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        Interactable = tbl1.interactable,
        ZIndex = tbl1.zIndex
    }
    local tbl5 = { Row = 0, BottomDivider = 0 }
    local createElement3 = React.createElement
    local var9 = View
    local tbl6 = {
        tag = "row align-y-center gap-small size-full-0 auto-y padding-x-small padding-y-small"
    }
    local tbl7 = {
        BackButton = React.createElement(IconButton, {
            icon = IconName.ChevronLargeLeft,
            variant = ButtonVariant.Utility,
            size = ButtonSize.XSmall,
            onActivated = onActivated,
            testId = "friends-chat-back-button",
            LayoutOrder = 1,
            ref = tbl1.backButtonRef
        }),
        FacePileContainer = 0
    }
    local createElement4 = React.createElement
    local var10 = View
    local tbl8 = { tag = "fill size-0-800", LayoutOrder = 2 }

    local tbl9 = {
        FacePile = React.createElement(FriendsChatFacePile, {
            participantUserIds = tbl1.participantUserIds,
            localUserId = tbl1.localUserId,
            titleText = tbl1.titleText,
            titleStyle = if var6 then var6.title else nil,
            onActivated = tbl1.onActivated,
            selectable = tbl1.onActivated ~= nil or nil
        })
    }
    tbl7.FacePileContainer = createElement4(var10, tbl8, tbl9)
    tbl5.Row = createElement3(var9, tbl6, tbl7)

    tbl5.BottomDivider = if FFlagFriendsChatAddTopBarDivider then React.createElement(Divider, { Position = UDim2.new(0, 0, 1, -1), Size = UDim2.new(1, 0, 0, 1), ZIndex = tbl1.zIndex }) else nil
    tbl3.Content = createElement2(str2, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

return FriendsChatConversationHeaderBar
