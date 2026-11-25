-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local useEventConnection = require(scriptParentParent.ReactUtils).useEventConnection
local Foundation = require(scriptParentParent.Foundation)
local _Signals = require(scriptParentParent.Signals)
local ChatLineReporting = require(scriptParentParent.ChatLineReporting)
local ChatLineReportRoot = ChatLineReporting.ChatLineReportRoot
local Constants = ChatLineReporting.Constants

local useInExperienceLocalization = require(scriptParentParent.ChatUIPrimitives).Hooks.useInExperienceLocalization
local useDismissOnEscapeOrMenu = require(scriptParentParent.ChatUIPrimitives).Hooks.useDismissOnEscapeOrMenu
local ReportMenuFocusRoot = require(script.Parent.ReportMenuFocusRoot)
local FFlagExpChatTextChannelWindowFocusNav = require(script.Parent.Flags.FFlagExpChatTextChannelWindowFocusNav)

local tbl1 = {
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop
}

local View = Foundation.View
local Icon = Foundation.Icon
local Menu = Foundation.Menu
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local PopoverSide = Foundation.Enums.PopoverSide
local PopoverAlign = Foundation.Enums.PopoverAlign

local function mapMessagesForReport(tbl2, textChannel)
    local var1 = table.create(#tbl2)
    for _, value in tbl2 do
        if value.messageType ~= "user" then
            continue
        end

        table.insert(var1, {
            userId = value.senderUserId,
            text = value.content,
            textChannel = textChannel,
            messageId = value.messageId,
            prefixText = value.prefixText
        })
    end

    return var1
end

local function TopBannerView(arg1)
    useDismissOnEscapeOrMenu(arg1.focusNavEnabled == true and arg1.isOpen, arg1.onPressedOutside)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = UDim2.new(1, 0, 0, Constants.TopBannerSize),
        BackgroundTransparency = 1,
        ZIndex = arg1.ZIndex
    }
    local tbl3 = { Menu = 0 }
    local createElement2 = React.createElement
    local var1 = Menu
    local tbl4 = {
        isOpen = arg1.isOpen,
        items = arg1.items,
        size = InputSize.Medium,
        side = PopoverSide.Right,
        align = PopoverAlign.Start,
        onPressedOutside = arg1.onPressedOutside,
        Position = UDim2.new(1, Constants.IconButtonPositionXOffset, 0, 0),
        ref = if arg1.focusNavEnabled then arg1.menuContentRef else nil,
        selectionGroup = if arg1.focusNavEnabled then tbl1 else nil
    }
    local tbl5 = {
        Button = React.createElement(
            View,
            {
                Size = UDim2.fromOffset(Constants.IconButtonSize, Constants.IconButtonSize),
                tag = "align-x-center align-y-center radius-medium",
                onActivated = arg1.onTriggerActivated,
                ref = if arg1.focusNavEnabled then arg1.triggerRef else nil
            },
            {
                icon = React.createElement(Icon, { name = IconName.ThreeDotsHorizontal, size = IconSize.Large })
            }
        )
    }
    tbl3.Menu = createElement2(var1, tbl4, tbl5)
    return createElement(str1, tbl2, tbl3)
end

local function TopBannerFocusNav(arg1)
    local isOpen = arg1.isOpen
    local onOpenChanged = arg1.onOpenChanged
    React.useEffect(function()
        if onOpenChanged then
            onOpenChanged(isOpen)
        end
    end, { isOpen, onOpenChanged })

    local render = React.useCallback(function(arg2)
        return React.createElement(TopBannerView, {
            ZIndex = arg1.ZIndex,
            isOpen = arg1.isOpen,
            items = arg1.items,
            onTriggerActivated = arg1.onTriggerActivated,
            onPressedOutside = arg1.onPressedOutside,
            focusNavEnabled = arg1.focusNavEnabled,
            menuContentRef = arg2.containerRef,
            triggerRef = arg2.triggerRef
        })
    end, {
        arg1.ZIndex,
        arg1.isOpen,
        arg1.items,
        arg1.onTriggerActivated,
        arg1.onPressedOutside,
        arg1.focusNavEnabled
    })

    return React.createElement(ReportMenuFocusRoot, { isOpen = arg1.isOpen, render = render })
end

return React.memo(function(tbl2) -- name: ChatWindowTopBanner
    local var1 = useInExperienceLocalization()
    local isOpen, var3 = React.useState(false)

    useEventConnection(GuiService:GetPropertyChangedSignal("MenuIsOpen"), function()
        if GuiService.MenuIsOpen then
            var3(false)
        end
    end)

    local text = var1("Feature.ReportAbuse.Action.EnterChatLineReporting")

    local onTriggerActivated = React.useCallback(function()
        var3(not isOpen)
    end, { isOpen })

    local onPressedOutside = React.useCallback(function()
        var3(false)
    end, {})

    local onActivated = React.useCallback(function()
        local var7 = not tbl2.messagesSignal and {} or tbl2.messagesSignal(false)
        ChatLineReportRoot.initialize((mapMessagesForReport(var7, tbl2.targetChannel)))
        var3(false)
    end, { tbl2.messagesSignal, tbl2.targetChannel })

    local items = React.useMemo(function()
        return {{
            id = "report",
            icon = IconName.SpeechBubbleExclamation,
            text = text,
            onActivated = onActivated
        }}
    end, { text, onActivated })

    if FFlagExpChatTextChannelWindowFocusNav then
        return React.createElement(TopBannerFocusNav, {
            ZIndex = tbl2.ZIndex,
            isOpen = isOpen,
            items = items,
            onTriggerActivated = onTriggerActivated,
            onPressedOutside = onPressedOutside,
            focusNavEnabled = tbl2.focusNavEnabled,
            onOpenChanged = tbl2.onOpenChanged
        })
    end

    return React.createElement(TopBannerView, {
        ZIndex = tbl2.ZIndex,
        isOpen = isOpen,
        items = items,
        onTriggerActivated = onTriggerActivated,
        onPressedOutside = onPressedOutside,
        focusNavEnabled = tbl2.focusNavEnabled
    })
end)
