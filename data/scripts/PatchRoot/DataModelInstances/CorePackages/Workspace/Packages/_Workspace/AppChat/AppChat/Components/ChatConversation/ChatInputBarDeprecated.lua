-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SocialLibraries = require(AppChat.SocialLibraries)
local Roact = require(AppChatParent.Roact)
local AppCommonLibText = require(AppChatParent.AppCommonLib).Text
local GetTextSize = require(AppChatParent.Style).GetTextSize
local isTenFootInterface = require(AppChatParent.AppCommonLib).isTenFootInterface
local UIBlox = require(AppChatParent.UIBlox)
local Images = UIBlox.App.ImageSet.Images
local IconSize = UIBlox.App.Constant.IconSize
local Interactable = UIBlox.Core.Control.Interactable
local withStyle = UIBlox.Style.withStyle
local isMessageValid = require(script.Parent.isMessageValid)
local MessageCharacterLimit = require(script.Parent.MessageCharacterLimit)
local isKeyCodePressed = require(AppChat.Components.ChatConversation.Utils.isKeyCodePressed)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local default = require(AppChatParent.LoggingProtocol).default
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local withChatPagePadding = require(AppChat.Contexts.ChatPagePadding.withChatPagePadding)
local withSelectionCursorProvider = UIBlox.App.SelectionImage.withSelectionCursorProvider
local CursorKind = UIBlox.App.SelectionImage.CursorKind
local ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local FocusNavigationEventNameEnum = require(AppChatParent.FocusNavigationUtils).FocusNavigationEventNameEnum

local CallbackInputBox = SocialLibraries.Components.CallbackInputBox
local ChatInputBoxDisabled = require(AppChat.Components.ChatConversation.ChatInputBoxDisabled)

local SendButtonClickActionResult = require(AppChat.Analytics.Enums.SendButtonClickActionResult)
local getAppFeaturePolicies = require(AppChatParent.UniversalAppPolicy).getAppFeaturePolicies

local IsVRAppBuild = require(AppChatParent.AppCommonLib).IsVRAppBuild

local getFIntAppChatBehaviorCollectionEnabledPercentage = require(AppChat.Flags.getFIntAppChatBehaviorCollectionEnabledPercentage)
local FFlagAppChatOnConsoles = require(AppChatParent.SharedFlags).FFlagAppChatOnConsoles
local bool1 = game:DefineFastFlag("AppChatUseTextBoxTextOnSend", false)

local var1 = Roact.PureComponent:extend("ChatInputBarDeprecated")

local KeystrokeEvent = require(AppChat.Analytics.KeystrokeEvent)

var1.defaultProps = {
    userInputService = UserInputService,
    initialInputText = "",
    placeholderText = "Say something",
    inputBarDisabledText = "Chat Disabled",
    onDisabledInputBarActivated = function() end,
    sendButtonContainerSize = 45,
    LayoutOrder = 0,
    maxCharacterLength = MessageCharacterLimit,
    maxKeystrokeDataLength = 200,
    messageListRef = nil,
    onHeightChanged = function() end,
    onPositionChanged = function() end,
    onFocusLost = function() end,
    isDisabled = false,
    disabledEndTimestampDisplay = nil,
    moreMenuEnabled = false,
    onSendBtnClicked = nil,
    onSendChat = nil,
    onTextChanged = function() end,
    inputBoxRef = nil,
    inputBarRef = nil,
    eventLoggingFunc = default.logRobloxTelemetryEvent,
    textChangedFallback = false
}

function var1.init(arg1)
    arg1.isMounted = false
    arg1.state = {
        inputText = arg1.props.initialInputText,
        showSendChat = false,
        chatBarWidth = 0,
        frameHeight = 0
    }

    arg1.inputBoxRef = arg1.props.inputBoxRef or Roact.createRef()
    arg1.messageListRef = arg1.props.messageListRef
    arg1.inputBoxFocusLossKeyCodeRef = Roact.createRef()
    arg1.inputBoxFocusLossKeyCodeRef.current = Enum.KeyCode.None
    arg1.inputBarRef = arg1.props.inputBarRef or Roact.createRef()
    arg1.sendButtonRef = Roact.createRef()
    arg1.eventHandlerRegistration = nil

    arg1.textChangedFallback = arg1.props.textChangedFallback or not UserInputService.KeyboardEnabled

    function arg1.heightOfFourLines(arg2, arg3, x: number?)
        return GetTextSize("A\nB\nC\nD", arg3, arg2, Vector2.new(x, 10000)).Y
    end

    function arg1.isMoreMenuEnabled()
        return arg1.props.moreMenuEnabled
    end

    function arg1.calculateInputBoxHeight(arg2, arg3, arg4, x: number?): number
        local textSizeY = GetTextSize(arg2, arg4, arg3, Vector2.new(x, 10000)).Y
        local var2 = arg1.heightOfFourLines(arg3, arg4, x)
        local var3 = if arg1.isMoreMenuEnabled() then arg4 + math.min(textSizeY, var2) else arg4 + math.min(textSizeY, var2) + 16

        if arg1.props.onHeightChanged then
            arg1.props.onHeightChanged(var3)
        end

        return var3
    end

    arg1.inputConnectionActive = false
    arg1.inputBeganConnection = nil
    arg1.inputEndedConnection = nil
    arg1.keyPressedData = {}
    arg1.eventTypeData = {}
    arg1.timestampData = {}
    arg1.shouldCollectKeystrokes = false
    local var2 = getAppFeaturePolicies().getKeystrokeCollectionEnabled()
    local fIntAppChatBehaviorCollectionEnabledPercentage = getFIntAppChatBehaviorCollectionEnabledPercentage()
    if fIntAppChatBehaviorCollectionEnabledPercentage > 0 and Players.LocalPlayer and var2 then
        arg1.shouldCollectKeystrokes = Players.LocalPlayer.UserId % 100 < fIntAppChatBehaviorCollectionEnabledPercentage
    end

    function arg1.onTextChanged(inputText, arg2, arg3, arg4)
        if not arg1.isMounted then
            return
        end

        local showSendChat = not not (inputText and isMessageValid(inputText, arg1.props.maxCharacterLength))

        local frameHeight = arg1.calculateInputBoxHeight(inputText, arg2, arg3, arg4)

        arg1:setState({ inputText = inputText, showSendChat = showSendChat, frameHeight = frameHeight })

        arg1.props.onTextChanged(inputText)

        if arg1.shouldCollectKeystrokes and arg1.textChangedFallback then
            arg1:recordTextChange(inputText)
        end
    end

    function arg1.onInputBeganEvent(input: InputObject)
        if arg1.shouldCollectKeystrokes and not arg1.textChangedFallback and input.UserInputType == Enum.UserInputType.Keyboard then
            arg1:recordKeystroke(true, input.KeyCode)
        end

        if isKeyCodePressed({ input }, Enum.KeyCode.Return, Enum.KeyCode.KeypadEnter)
            and not isKeyCodePressed(arg1.props.userInputService:GetKeysPressed(), Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift)
        then
            arg1.onSendActivated()
        end
    end

    function arg1.onInputEndedEvent(input: InputObject)
        if arg1.shouldCollectKeystrokes and not arg1.textChangedFallback and input.UserInputType == Enum.UserInputType.Keyboard then
            arg1:recordKeystroke(false, input.KeyCode)
        end
    end

    function arg1.focusChanged(arg2)
        if arg2 and not arg1.inputConnectionActive then
            arg1.inputBeganConnection = arg1.props.userInputService.InputBegan:Connect(arg1.onInputBeganEvent)
            arg1.inputEndedConnection = arg1.props.userInputService.InputEnded:Connect(arg1.onInputEndedEvent)
            arg1.inputConnectionActive = true
        elseif not arg2 and arg1.inputConnectionActive then
            arg1:disconnectInputConnection()
            arg1.props.onFocusLost()
        end
    end

    function arg1.onSendActivated()
        local var3 = if bool1 then if arg1.inputBoxRef.current then arg1.inputBoxRef.current.Text else "" else arg1.state.inputText
        local var4 = if bool1 then var3 and isMessageValid(var3, arg1.props.maxCharacterLength) else arg1.state.showSendChat
        local var5 = AppCommonLibText.Trim(var3)
        local none = SendButtonClickActionResult.None

        if var4 and isMessageValid(var5, arg1.props.maxCharacterLength) then
            arg1.inputBoxRef:getValue().Text = ""

            if arg1.focusNavigationService and arg1.focusNavigationService.focusedGuiObject:getValue() == arg1.sendButtonRef:getValue() then
                arg1.focusNavigationService:focusGuiObject(arg1.inputBarRef:getValue(), false)
            end

            local var6 = if FFlagAppChatOnConsoles then isTenFootInterface() else nil

            if FFlagAppChatOnConsoles and var6 then
                arg1.inputBoxRef.current:ReleaseFocus()
            end

            arg1:setState({ inputText = "", showSendChat = false })

            if arg1.props.onSendChat then
                if var5 == "/shrug" then
                    arg1.props.onSendChat("¯\\_(ツ)_/¯")
                else
                    arg1.props.onSendChat(var5)
                end
                none = SendButtonClickActionResult.WillSend
            end

            local _listRef = arg1.messageListRef and arg1.messageListRef.current and arg1.messageListRef.current._listRef
            if _listRef then
                _listRef:scrollToOffset({ offset = 0 })
            end
        elseif not var4 then
            none = SendButtonClickActionResult.ButtonInactive
        else
            none = SendButtonClickActionResult.MessageInvalid
        end

        if arg1.props.onSendBtnClicked then
            arg1.props.onSendBtnClicked(none)
        end

        if arg1.shouldCollectKeystrokes then
            arg1:sendKeystrokeEvent("UASendPressed")
        end
    end

    function arg1.chatBoxSizeChanged(arg2, arg3, arg4, arg5)
        local frameHeight = arg1.calculateInputBoxHeight(arg3, arg4, arg5, arg2.AbsoluteSize.X)
        arg1:setState({ chatBarWidth = arg2.AbsoluteSize.X, frameHeight = frameHeight })
    end

    function arg1.onDisabledInputBarActivated()
        arg1.props.onDisabledInputBarActivated()
    end

    function arg1.focusChatInputBox()
        if arg1.inputBoxRef and arg1.inputBoxRef.current then
            arg1.inputBoxRef.current:CaptureFocus()
        end
    end

    function arg1.focusNavigationEventHandler(arg2)
        if arg2.eventData and arg1.inputBoxFocusLossKeyCodeRef.current == arg2.eventData.KeyCode then
            arg2:cancel()
            arg1.inputBoxFocusLossKeyCodeRef.current = Enum.KeyCode.None
        end
    end
end

function var1.render(arg1)
    local isDisabled = arg1.props.isDisabled
    return Roact.createElement(ReactFocusNavigation.FocusNavigationContext.Consumer, {
        render = function(focusNavigationService)
            arg1.focusNavigationService = focusNavigationService
            return arg1:renderContent(isDisabled)
        end
    })
end

function var1.renderContent(arg1, arg2)
    return withStyle(function(arg3)
        return withChatPagePadding(function(arg4)
            return withSelectionCursorProvider(function(arg5)
                local font = arg3.Font
                local font2 = arg3.Tokens.Typography.BodyLarge.Font
                local var2 = font.BaseSize * font.Body.RelativeSize
                local var3 = if FFlagAppChatOnConsoles then IsVRAppBuild() or isTenFootInterface() else nil
                local frameHeight = arg1.state.frameHeight
                if frameHeight == 0 then
                    frameHeight = arg1.calculateInputBoxHeight(arg1.state.inputText, font2, var2, arg1.state.chatBarWidth)
                end

                local uDim = UDim.new(0, math.max(arg4.right - 6, 0))
                if arg2 then
                    uDim = UDim.new(0, arg4.right)
                end

                local createElement = Roact.createElement
                local str1 = "Frame"
                local tbl1 = {
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    LayoutOrder = arg1.props.LayoutOrder,
                    Size = UDim2.new(1, 0, 0, frameHeight),
                    [Roact.Change.AbsolutePosition] = arg1.props.onPositionChanged
                }
                local tbl2 = {
                    layout = Roact.createElement("UIListLayout", {
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        FillDirection = Enum.FillDirection.Horizontal,
                        SortOrder = Enum.SortOrder.LayoutOrder
                    }),
                    flex = if arg1.isMoreMenuEnabled() then Roact.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }) else nil,
                    padding = if arg1.isMoreMenuEnabled() then nil else Roact.createElement("UIPadding", {
                        PaddingLeft = UDim.new(0, arg4.left),
                        PaddingRight = uDim,
                        PaddingBottom = UDim.new(0, 13),
                        PaddingTop = UDim.new(0, 8)
                    }),
                    inputBorder = 0,
                    sendButton = 0
                }

                local createElement2 = Roact.createElement
                local var4 = ImageSetLabel
                local tbl3 = {
                    Size = UDim2.new(1, if arg2 then 0 else -arg1.props.sendButtonContainerSize, 1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Image = Images["component_assets/circle_21_stroke_1"],
                    ImageColor3 = if arg1.props.isDisabled then arg3.Tokens.Color.System.Alert.Color3 else arg3.Theme.Divider.Color,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(8, 8, 9, 9)
                }
                local tbl4 = { inputImage = 0 }
                local createElement3 = Roact.createElement
                local var5 = Interactable
                local tbl5 = {
                    Name = "inputBar",
                    SelectionImageObject = arg5(CursorKind.RoundedRectNoInset),
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Selectable = true,
                    NextSelectionRight = arg1.sendButtonRef,
                    onActivated = arg1.focusChatInputBox,
                    [Roact.Ref] = arg1.inputBarRef
                }
                local createElement4 = Roact.createElement
                local var6 = ImageSetLabel
                local tbl6 = {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Image = Images["component_assets/circle_21"],
                    ImageColor3 = arg3.Theme.UIMuted.Color,
                    ImageTransparency = arg3.Theme.UIMuted.Transparency,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(8, 8, 9, 9)
                }
                local tbl7 = {
                    padding = Roact.createElement("UIPadding", {
                        PaddingTop = if arg1.isMoreMenuEnabled() then nil else UDim.new(0, var2 / 2.5),
                        PaddingLeft = UDim.new(0.02, 0),
                        PaddingRight = UDim.new(0.02, 0)
                    }),
                    inputBox = 0
                }
                local element

                if arg2 then
                    element = Roact.createElement(ChatInputBoxDisabled, {
                        bodyText = arg1.props.inputBarDisabledText,
                        contentSize = var2,
                        endTimestamp = arg1.props.disabledEndTimestampDisplay,
                        font = font2,
                        onActivated = arg1.onDisabledInputBarActivated
                    })
                else
                    local createElement5 = Roact.createElement
                    local var7 = CallbackInputBox
                    local tbl8 = {
                        initialInputText = arg1.props.initialInputText,
                        inputTextFont = font2,
                        inputTextColor3 = arg3.Theme.TextEmphasis.Color,
                        inputTextSize = var2,
                        inputTextXAlignment = Enum.TextXAlignment.Left,
                        inputTextYAlignment = if arg1.isMoreMenuEnabled() then Enum.TextYAlignment.Center else Enum.TextYAlignment.Top,
                        placeholderText = arg1.props.placeholderText,
                        placeholderTextColor3 = arg3.Theme.TextMuted.Color,
                        placeholderTextTransparency = arg3.Theme.TextMuted.Transparency,
                        clipsDescendants = false,
                        multiLine = not IsVRAppBuild(),
                        manualFocusRelease = true,
                        textWrapped = true,
                        focusChangedCallback = arg1.focusChanged,
                        clearButtonDisabled = true,
                        clearButtonSize = 0
                    }
                    function tbl8.textChangedCallback(arg6)
                        arg1.onTextChanged(arg6, font2, var2, arg1.state.chatBarWidth)
                    end
                    tbl8[Roact.Change.AbsoluteSize] = function(arg6)
                        arg1.chatBoxSizeChanged(arg6, arg1.state.inputText, font2, var2)
                    end
                    tbl8.inputBoxRef = arg1.inputBoxRef
                    tbl8.returnPressedFromOnScreenKeyboardCallback = if FFlagAppChatOnConsoles then if var3 then arg1.onSendActivated else nil elseif IsVRAppBuild() then arg1.onSendActivated else nil
                    element = createElement5(var7, tbl8)
                end

                tbl7.inputBox = element
                tbl4.inputImage = createElement3(var5, tbl5, { createElement4(var6, tbl6, tbl7) })
                tbl2.inputBorder = createElement2(var4, tbl3, tbl4)

                tbl2.sendButton = if arg2 then nil else withSelectionCursorProvider(function(arg6)
                    local createElement5 = Roact.createElement
                    local str2 = "TextButton"
                    local tbl8 = {
                        Name = "sendButton",
                        Size = UDim2.new(0, arg1.props.sendButtonContainerSize, 1, 0),
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        Text = "",
                        SelectionImageObject = arg6(CursorKind.RoundedRectNoInset),
                        Selectable = true,
                        NextSelectionLeft = arg1.inputBarRef,
                        [Roact.Event.Activated] = arg1.onSendActivated,
                        [Roact.Ref] = arg1.sendButtonRef
                    }
                    local tbl9 = {
                        layout = Roact.createElement(
                            "UIListLayout",
                            {
                                VerticalAlignment = Enum.VerticalAlignment.Center,
                                HorizontalAlignment = Enum.HorizontalAlignment.Right
                            }
                        ),
                        sendIcon = Roact.createElement(ImageSetLabel, {
                            Size = UDim2.new(0, IconSize.Regular, 0, IconSize.Regular),
                            BackgroundTransparency = 1,
                            ImageColor3 = if arg1.state.showSendChat then arg3.Tokens.Color.Content.Emphasis.Color3 else arg3.Tokens.Color.Content.Default.Color3,
                            ImageTransparency = if arg1.state.showSendChat then 0 else 0.5,
                            Image = Images["icons/actions/send"]
                        })
                    }
                    return createElement5(str2, tbl8, tbl9)
                end)

                return createElement(str1, tbl1, tbl2)
            end)
        end)
    end)
end

function var1.didMount(arg1)
    arg1.isMounted = true
    if arg1.inputBoxRef and arg1.inputBoxRef.current then
        arg1.inputBoxRef.current.Selectable = false
        arg1.focusLostConnection = arg1.inputBoxRef.current.FocusLost:Connect(function(_: boolean, inputThatCausedFocusLoss: InputObject)
            local inputBoxFocusLossKeyCodeRef = arg1.inputBoxFocusLossKeyCodeRef
            inputBoxFocusLossKeyCodeRef.current = if inputThatCausedFocusLoss then inputThatCausedFocusLoss.KeyCode else Enum.KeyCode.None
        end)
    end

    if arg1.focusNavigationService and arg1.inputBarRef.current then
        arg1.eventHandlerRegistration = arg1.focusNavigationService:registerEventHandler(
            arg1.inputBarRef.current,
            FocusNavigationEventNameEnum.NavigateBack,
            arg1.focusNavigationEventHandler
        )
    end
end

function var1.willUnmount(arg1)
    arg1.isMounted = false

    if arg1.inputConnectionActive then
        arg1:disconnectInputConnection()
    end

    if arg1.props.onHeightChanged then
        arg1.props.onHeightChanged(0)
    end

    if arg1.focusLostConnection then
        arg1.focusLostConnection:Disconnect()
    end

    if arg1.eventHandlerRegistration then
        arg1.eventHandlerRegistration:Disconnect()
    end
end

function var1.recordKeystroke(arg1, arg2, keyCode)
    if arg2 then
        table.insert(arg1.keyPressedData, keyCode.Name)
        table.insert(arg1.eventTypeData, 0)
        table.insert(arg1.timestampData, DateTime.now().UnixTimestampMillis)
    elseif keyCode ~= Enum.KeyCode.Return and keyCode ~= Enum.KeyCode.KeypadEnter or #arg1.keyPressedData ~= 0 then
        table.insert(arg1.keyPressedData, keyCode.Name)
        table.insert(arg1.eventTypeData, 1)
        table.insert(arg1.timestampData, DateTime.now().UnixTimestampMillis)
    end

    if #arg1.keyPressedData >= arg1.props.maxKeystrokeDataLength then
        arg1:sendKeystrokeEvent("UAMaxLengthReached")
    end
end

function var1.recordTextChange(arg1, arg2)
    table.insert(arg1.keyPressedData, arg2:sub(-1))
    table.insert(arg1.timestampData, DateTime.now().UnixTimestampMillis)

    if #arg1.keyPressedData >= arg1.props.maxKeystrokeDataLength then
        arg1:sendKeystrokeEvent("UAMaxLengthReached")
    end
end

function var1.sendKeystrokeEvent(arg1, chatContext)
    if not (#arg1.keyPressedData >= 0) then
        return
    end

    arg1.props.eventLoggingFunc(default, KeystrokeEvent, {}, {
        chatContext = chatContext,
        keyPressedData = table.concat(arg1.keyPressedData, ","),
        eventTypeData = table.concat(arg1.eventTypeData, ","),
        timestampData = table.concat(arg1.timestampData, ",")
    })
    arg1.keyPressedData = {}
    arg1.eventTypeData = {}
    arg1.timestampData = {}
end

function var1.disconnectInputConnection(arg1)
    if arg1.inputBeganConnection then
        arg1.inputBeganConnection:Disconnect()
        arg1.inputBeganConnection = nil
    end
    if arg1.inputEndedConnection then
        arg1.inputEndedConnection:Disconnect()
        arg1.inputEndedConnection = nil
    end
    arg1.inputConnectionActive = false
end

return var1
