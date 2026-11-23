-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local UserInputService = game:GetService("UserInputService")

local SocialLibraries = require(AppChat.SocialLibraries)
local React = require(AppChatParent.React)
local Foundation = require(AppChatParent.Foundation)
local GetTextSize = require(AppChatParent.Style).GetTextSize
local AppCommonLibText = require(AppChatParent.AppCommonLib).Text
local UIBlox = require(AppChatParent.UIBlox)
local BuilderIcons = require(AppChatParent.BuilderIcons)
local useStyle = UIBlox.Core.Style.useStyle
local isKeyCodePressed = require(AppChat.Components.ChatConversation.Utils.isKeyCodePressed)
local default = require(AppChatParent.LoggingProtocol).default
local Cryo = require(AppChatParent.Cryo)
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local FocusNavigationEventNameEnum = require(AppChatParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local CallbackInputBox = SocialLibraries.Components.CallbackInputBox
local ChatInputBoxDisabled = require(script.Parent.ChatInputBoxDisabled)
local isMessageValid = require(script.Parent.isMessageValid)
local MessageCharacterLimit = require(script.Parent.MessageCharacterLimit)
local useKeystrokeCollection = require(script.Parent.Hooks.useKeystrokeCollection)
local useInputConnections = require(script.Parent.Hooks.useInputConnections)
local useChatPagePadding = require(AppChat.Contexts.ChatPagePadding.useChatPagePadding)
local useIsSpatial = require(AppChatParent.Responsive).useIsSpatial

local SendButtonClickActionResult = require(AppChat.Analytics.Enums.SendButtonClickActionResult)
local _types = require(AppChat.types)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)
local useChatWideModeFocus = require(AppChat.Contexts.ChatWideModeFocus.useChatWideModeFocus)

local tbl1 = {
    userInputService = UserInputService,
    initialInputText = "",
    placeholderText = "Write a message",
    inputBarDisabledText = "Chat Disabled",
    inputBarRef = nil,
    inputBoxRef = nil,
    onDisabledInputBarActivated = function() end,
    LayoutOrder = 0,
    maxCharacterLength = MessageCharacterLimit,
    maxKeystrokeDataLength = 200,
    messageListRef = nil,
    onHeightChanged = function(_) end,
    onPositionChanged = function(_) end,
    onFocusLost = function() end,
    isDisabled = false,
    disabledEndTimestampDisplay = nil,
    onSendBtnClicked = function(_) end,
    onSendChat = function(_) end,
    onTextChanged = function(_) end,
    eventLoggingFunc = default.logRobloxTelemetryEvent,
    textChangedFallback = false,
    moreMenuEnabled = false
}

local function heightOfNLines(num1: number, font, arg1, num2: number?) -- Luacid: Inlined by compiler; 1 call site recovered
    return GetTextSize(string.rep("A\n", num1 - 1), arg1, font, Vector2.new(num2 or 10000, 10000)).Y
end

return React.memo(function(tbl2) -- name: ChatInputBar
    local var1 = Cryo.Dictionary.union(tbl1, tbl2)

    local var2, var3 = React.useState(0)
    local var4, var5 = React.useState(0)
    local var6, var7 = React.useState(false)

    local var8 = React.useRef(nil)
    if var1.inputBoxRef then
        var8 = var1.inputBoxRef
    end
    local var9 = React.useRef(nil)
    local var10 = React.useRef(nil)
    if var1.inputBarRef then
        var9 = var1.inputBarRef
    end
    local var11 = React.useRef(Enum.KeyCode.None)
    local ref = ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, function(arg1)
        if arg1.eventData and var11.current == arg1.eventData.KeyCode then
            arg1:cancel()
            var11.current = Enum.KeyCode.None
        end
    end, "Bubble", var9)

    local var13 = React.useRef(var1.initialInputText or "")
    local var14 = React.useRef(false)
    local var15 = React.useRef(var1.textChangedFallback or not UserInputService.KeyboardEnabled)

    local var16, var17 = React.useBinding(var13.current ~= "")

    useChatPagePadding()
    local var18 = if FFlagAppChatConsoleFocusFixes then useChatWideModeFocus() else nil
    local var19 = Foundation.Hooks.useTokens()
    local var20 = useStyle()
    local font = var19.Typography.BodyLarge.Font
    local var21 = var20.Font.BaseSize * var20.Font.Body.RelativeSize

    local var22 = React.useMemo(function()
        return (heightOfNLines(4, font, var21, var2))
    end, { font, var21, var2 })
    local var23 = React.useMemo(function()
        local var23 = font
        local var24 = var21
        return GetTextSize(string.rep("A\n", 0), var24, var23, Vector2.new(10000, 10000)).Y
    end, { font, var21 })

    local var24 = useKeystrokeCollection(
        {
            eventLoggingFunc = var1.eventLoggingFunc,
            maxKeystrokeDataLength = var1.maxKeystrokeDataLength
        }
    )
    local var25 = React.useCallback(function()
        return var13.current and isMessageValid(var13.current, var1.maxCharacterLength)
    end, { var1.maxCharacterLength })

    local var26 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
    local onActivated = React.useCallback(function()
        local current = var13.current
        if var8.current then
            current = var8.current.Text or ""
        end
        local var27 = AppCommonLibText.Trim(current)

        local _none = SendButtonClickActionResult.None
        local var28

        if var25() and isMessageValid(var27, var1.maxCharacterLength) then
            if var8.current then
                var8.current.Text = ""
            end

            if var26 and var26.focusedGuiObject:getValue() == var10.current then
                var26:focusGuiObject(var9.current, false)
            end

            var13.current = ""
            var17(false)

            if var27 == "/shrug" then
                var1.onSendChat("¯\\_(ツ)_/¯")
            else
                var1.onSendChat(var27)
            end
            var28 = SendButtonClickActionResult.WillSend

            local _listRef = var1.messageListRef and var1.messageListRef.current and var1.messageListRef.current._listRef
            if _listRef then
                _listRef:scrollToOffset({ offset = 0 })
            end
        elseif not var25() then
            var28 = SendButtonClickActionResult.ButtonInactive
        else
            var28 = SendButtonClickActionResult.MessageInvalid
        end

        var1.onSendBtnClicked(var28)

        var24.sendKeystrokeEventOnSend()
    end, {
        var25,
        var1.onSendChat,
        var1.onSendBtnClicked,
        var24.sendKeystrokeEventOnSend,
        var26
    })

    local onInputEnded = React.useCallback(function(arg1, _)
        if var24 and not var15.current and arg1.UserInputType == Enum.UserInputType.Keyboard then
            var24.recordKeystroke(false, arg1.KeyCode)
        end
    end, { var24.recordKeystroke })

    local onInputBegan = React.useCallback(function(arg1, _)
        if var24 and not var15.current and arg1.UserInputType == Enum.UserInputType.Keyboard then
            var24.recordKeystroke(true, arg1.KeyCode)
        end
        if isKeyCodePressed({ arg1 }, Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter)
            and not isKeyCodePressed(var1.userInputService:GetKeysPressed(), Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift)
        then
            onActivated()
        end
    end, {
        var1.userInputService,
        var24.recordKeystroke,
        var24.sendKeystrokeEventOnSend,
        onActivated
    })

    local var30 = useInputConnections({
        userInputService = var1.userInputService,
        onInputBegan = onInputBegan,
        onInputEnded = onInputEnded,
        onFocusLost = var1.onFocusLost
    })

    local var31 = React.useCallback(function(str1: string, x: number): number
        local textSizeY = GetTextSize(str1, var21, var19.Typography.BodyLarge.Font, Vector2.new(x, 10000)).Y

        local var31 = var21 + math.min(textSizeY, var22)

        if var1.onHeightChanged then
            var1.onHeightChanged(var31)
        end

        return var31
    end, {
        var19,
        var22,
        var1.onHeightChanged,
        font,
        var21
    })
    local textChangedCallback = React.useCallback(function(current: string)
        if not var14.current then
            return
        end

        var13.current = current
        var17(current ~= "")
        var7(var25())

        if var24 and var15.current then
            var24.recordTextChange(current)
        end

        local var32 = var31(current, var2)
        var5(var32)

        if var1.onTextChanged then
            var1.onTextChanged(current)
        end
    end, {
        var24.recordTextChange,
        var31,
        var1.onTextChanged,
        var2
    })

    local var33 = React.useCallback(function(arg1)
        local var33 = var31(var13.current, arg1.AbsoluteSize.X)
        var3(arg1.AbsoluteSize.X)
        var5(var33)
    end, { var31 })

    local var12 = React.useCallback(function()
        if var8.current then
            var8.current:CaptureFocus()
        end
    end, {})

    React.useEffect(function()
        var14.current = true
        return function()
            var14.current = false
            if var1.onHeightChanged then
                var1.onHeightChanged(0)
            end
        end
    end, { var1.onHeightChanged })

    React.useEffect(function()
        local connection = nil
        if var8 and var8.current then
            var8.current.Selectable = false
            connection = var8.current.FocusLost:Connect(function(_: boolean, inputThatCausedFocusLoss: InputObject)
                local var35 = var11
                var35.current = if inputThatCausedFocusLoss then inputThatCausedFocusLoss.KeyCode else Enum.KeyCode.None
            end)
        end

        return function()
            if connection then
                connection:Disconnect()
            end
        end
    end, {})

    local moreMenuEnabled = var1.moreMenuEnabled
    local var35 = useIsSpatial()
    if var4 == 0 then
        var4 = var31(var13.current, var2)
    end

    local var36 = var21 + var23
    local isDisabled = var1.isDisabled
    local createElement = React.createElement
    local view = Foundation.View
    local tbl3 = {
        tag = {
            ["padding-x-xlarge"] = not moreMenuEnabled,
            fill = moreMenuEnabled
        },
        Size = UDim2.new(if moreMenuEnabled then 0 else 1, 0, 0, var4),
        LayoutOrder = var1.LayoutOrder,
        onAbsolutePositionChanged = var1.onPositionChanged
    }
    local tbl4 = { inputBar = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl5 = {
        tag = {
            ["row size-full"] = true,
            ["stroke-emphasis stroke-thick"] = not isDisabled,
            ["stroke-alert"] = isDisabled
        },
        onActivated = var12,
        ref = ref,
        cornerRadius = UDim.new(0, var36 / 2),
        selection = {
            Selectable = true,
            NextSelectionRight = var10,
            NextSelectionLeft = if FFlagAppChatConsoleFocusFixes and var18 then var18.conversationListRef else nil
        },
        cursor = {
            radius = UDim.new(0, var36 / 2),
            offset = 0
        },
        LayoutOrder = 1
    }

    local tbl6 = { inputBoxWrapper = 0, sendButtonColumn = 0 }
    local createElement3 = React.createElement
    local view3 = Foundation.View
    local tbl7 = {
        tag = "size-0-full fill padding-left-large",
        padding = {
            top = UDim.new(0, var21 / 2),
            bottom = UDim.new(0, var21 / 2)
        },
        LayoutOrder = 1
    }

    local tbl8 = { inputBox = 0 }
    local element

    if isDisabled then
        element = React.createElement(ChatInputBoxDisabled, {
            bodyText = var1.inputBarDisabledText,
            font = font,
            contentSize = var21,
            endTimestamp = var1.disabledEndTimestampDisplay,
            onActivated = var1.onDisabledInputBarActivated
        })
    else
        element = React.createElement(CallbackInputBox, {
            initialInputText = var1.initialInputText,
            inputTextFont = font,
            inputTextColor3 = var20.Theme.TextEmphasis.Color,
            inputTextSize = var21,
            inputTextXAlignment = Enum.TextXAlignment.Left,
            inputTextYAlignment = Enum.TextYAlignment.Center,
            placeholderText = var1.placeholderText,
            placeholderTextColor3 = var20.Theme.TextMuted.Color,
            placeholderTextTransparency = var20.Theme.TextMuted.Transparency,
            clipsDescendants = false,
            multiLine = not var35,
            manualFocusRelease = true,
            textWrapped = true,
            focusChangedCallback = var30.focusChanged,
            clearButtonDisabled = true,
            clearButtonSize = 0,
            textChangedCallback = textChangedCallback,
            [React.Change.AbsoluteSize] = var33,
            inputBoxRef = var8,
            returnPressedFromOnScreenKeyboardCallback = if var35 then onActivated else nil
        })
    end

    tbl8.inputBox = element
    tbl6.inputBoxWrapper = createElement3(view3, tbl7, tbl8)

    tbl6.sendButtonColumn = React.createElement(
        Foundation.View,
        { tag = "col size-0-full auto-x align-y-bottom", LayoutOrder = 2, Visible = var16 },
        {
            sendButtonWrapper = React.createElement(
                Foundation.View,
                {
                    tag = "col flex-around padding-small",
                    Size = UDim2.new(0, var36, 0, var36)
                },
                {
                    sendButton = React.createElement(Foundation.View, {
                        tag = {
                            ["col radius-circle flex-around"] = true,
                            ["bg-action-emphasis"] = var6,
                            ["bg-action-standard"] = not var6
                        },
                        Size = UDim2.new(0, var36 - var19.Padding.Small, 0, var36 - var19.Padding.Small),
                        isDisabled = not var6,
                        onActivated = onActivated,
                        selection = { Selectable = true, NextSelectionLeft = var9 },
                        cursor = {
                            radius = UDim.new(0, var36 / 2),
                            offset = var19.Padding.Small / 2
                        },
                        ref = var10
                    }, {
                        sendButtonIcon = React.createElement(Foundation.Icon, {
                            style = var19.Color.ActionEmphasis.Foreground,
                            size = Foundation.Enums.IconSize.Small,
                            name = BuilderIcons.Icon.ArrowLargeUp
                        })
                    })
                }
            )
        }
    )
    tbl4.inputBar = createElement2(view2, tbl5, tbl6)
    return createElement(view, tbl3, tbl4)
end)
