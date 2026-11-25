-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local React = require(scriptParentParent.React)
local ReactUtils = require(scriptParentParent.ReactUtils)
local Foundation = require(scriptParentParent.Foundation)
local Responsive = require(scriptParentParent.Responsive)
local ReactFocusNavigation = require(scriptParentParent.ReactFocusNavigation)
local FocusNavigationUtils = require(scriptParentParent.FocusNavigationUtils)
local InputHandlers = require(scriptParentParent.InputHandlers)
local _Signals = require(scriptParentParent.Signals)
local ChatUIPrimitives = require(scriptParentParent.ChatUIPrimitives)
local TextChatWindowInputBarHost = require(script.Parent.TextChatWindowInputBarHost)
local ChatWindowTopBanner = require(script.Parent.ChatWindowTopBanner)
local MessageListArea = require(script.Parent.MessageListArea)
local _Message = require(script.Parent.Message)
local themeFromBackgroundColor = require(script.Parent.themeFromBackgroundColor)
local useChatWindowEntryHandoff = require(script.Parent.useChatWindowEntryHandoff)
local SelectionInputs = require(script.Parent.FocusNavigation.SelectionInputs)

local FFlagExpChatTextChannelWindowThemeByBackground = require(script.Parent.Flags.FFlagExpChatTextChannelWindowThemeByBackground)
local FFlagExpChatTextChannelWindowFocusNav = require(script.Parent.Flags.FFlagExpChatTextChannelWindowFocusNav)
local FFlagExpChatExpressionTrayReducedMotion = ChatUIPrimitives.Flags.FFlagExpChatExpressionTrayReducedMotion
local bool1 = game:DefineFastFlag("ExpChatTCWAllowKeyboardNav", false)
local FFlagExpChatTCWMemoizeChatWindowBody = require(script.Parent.Flags.FFlagExpChatTCWMemoizeChatWindowBody)

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local Provider = FocusNavigationUtils.FocusNavigableSurfaceRegistry.Provider
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local createNextOrder = ReactUtils.createNextOrder
local focusNavigationService = if FFlagExpChatTextChannelWindowFocusNav then ReactFocusNavigation.FocusNavigationService.new(ReactFocusNavigation.EngineInterface.CoreGui) else nil
local tbl1 = ({})
if bool1 then
    for _, value in SelectionInputs.Back do
        if value.EnumType == Enum.KeyCode then
            tbl1[value] = FocusNavigationEventNameEnum.NavigateBack
        end
    end
else
    tbl1[Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack
end

local tbl2 = {}

local tbl3 = {
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop
}

local function ChatWindowBody(arg1)
    local var1 = Foundation.Hooks.useTokens()
    local nextOrder = createNextOrder()

    local createElement = React.createElement
    local view = Foundation.View
    local tbl4 = {
        Size = arg1.Size or UDim2.fromScale(1, 1),
        ref = arg1.focusRootRef,
        selectionGroup = if arg1.focusNavEnabled then tbl3 else nil
    }
    local tbl5 = {
        chatView = React.createElement(Foundation.View, {
            tag = "col fill size-full clip",
            cornerRadius = if FFlagExpChatTextChannelWindowThemeByBackground then nil else UDim.new(0, var1.Radius.Medium),
            backgroundStyle = not FFlagExpChatTextChannelWindowThemeByBackground
                and {
                    Color3 = var1.DarkMode.Surface.Surface_100.Color3,
                    Transparency = 0.3
                }
                or nil
        }, {
            messageList = React.createElement(Foundation.View, {
                tag = "fill size-full-0",
                LayoutOrder = nextOrder()
            }, {
                content = React.createElement(MessageListArea, {
                    channelState = arg1.channelState,
                    messagesSignal = arg1.messagesSignal,
                    fontFace = arg1.fontFace,
                    windowName = arg1.windowName,
                    selectableRows = arg1.focusNavEnabled,
                    selectionCursor = arg1.selectionCursor,
                    onLatestUsernameChanged = arg1.onLatestUsernameChanged
                })
            }),
            inputBar = React.createElement(
                Foundation.View,
                {
                    tag = "size-full-0 auto-y padding-small",
                    LayoutOrder = nextOrder()
                },
                {
                    host = React.createElement(TextChatWindowInputBarHost, {
                        targetChannel = arg1.targetChannel,
                        canLocalUserChat = arg1.canLocalUserChat,
                        localUserId = arg1.localUserId,
                        fontFace = arg1.fontFace,
                        textBoxRef = arg1.inputTextBoxRef,
                        focusNavEnabled = arg1.focusNavEnabled,
                        selectionCursor = arg1.selectionCursor,
                        onExpressionTrayOpenChanged = arg1.setExpressionTrayOpen
                    })
                }
            )
        }),
        topBanner = React.createElement(ChatWindowTopBanner, {
            ZIndex = 2,
            messagesSignal = arg1.messagesSignal,
            targetChannel = arg1.targetChannel,
            focusNavEnabled = arg1.focusNavEnabled,
            onOpenChanged = arg1.setReportMenuOpen
        })
    }
    return createElement(view, tbl4, tbl5)
end

if FFlagExpChatTCWMemoizeChatWindowBody then
    ChatWindowBody = React.memo(ChatWindowBody)
end

local function ChatAppFocusNav(tbl4)
    local var1 = React.useRef(nil)
    local bool2 = Responsive.usePreferredInput() == Responsive.Input.Directional
    local bool3 = if bool1 then tbl4.windowInstance ~= nil else bool2 and tbl4.windowInstance ~= nil
    local selectionCursor = Foundation.Hooks.useCursor(Foundation.Enums.CursorType.RoundedRect)

    local var3, setReportMenuOpen = React.useState(false)
    local var5, setExpressionTrayOpen = React.useState(false)

    local windowInstance = tbl4.windowInstance

    local var7 = React.useCallback(function()
        GuiService.SelectedCoreObject = nil
        if windowInstance and windowInstance:IsDescendantOf(game) then
            GuiService.SelectedObject = windowInstance
        end
    end, { windowInstance })

    local setSelection = ReactFocusNavigation.useFocusGuiObject()
    local eventHandlers = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                if UserInputService:GetFocusedTextBox() ~= nil then
                    return
                end
                var7()
                arg1:cancel()
            end)
        }
        return result
    end, { var7 })
    local focusRootRef = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
        isAutoFocusRoot = false,
        shouldRestoreFocus = false,
        eventMap = if var3 or var5 then tbl2 else tbl1,
        eventHandlers = eventHandlers
    })

    useChatWindowEntryHandoff(
        {
            enabled = bool3,
            windowInstance = tbl4.windowInstance,
            focusTargetRef = var1,
            setSelection = setSelection
        }
    )

    local var11 = React.useRef(nil)
    local onLatestUsernameChanged = React.useCallback(function(arg1)
        local current = var1.current
        local current2 = var11.current
        if current2 ~= nil and current2 ~= arg1 then
            current2.NextSelectionDown = nil
        end
        var11.current = arg1
        if current == nil then
            return
        end
        current.NextSelectionUp = arg1
        if arg1 ~= nil then
            arg1.NextSelectionDown = current
        end
    end, { var1 })

    local var13 = table.clone(tbl4)
    var13.focusNavEnabled = bool3
    var13.selectionCursor = selectionCursor
    var13.focusRootRef = focusRootRef
    var13.onLatestUsernameChanged = onLatestUsernameChanged
    var13.inputTextBoxRef = var1
    var13.setReportMenuOpen = setReportMenuOpen
    var13.setExpressionTrayOpen = setExpressionTrayOpen
    return React.createElement(ChatWindowBody, var13)
end

local function useReducedMotion()
    local var1, var2 = React.useState(UserGameSettings.ReducedMotion)
    React.useEffect(function()
        var2(UserGameSettings.ReducedMotion)
        local connection = UserGameSettings:GetPropertyChangedSignal("ReducedMotion"):Connect(function()
            var2(UserGameSettings.ReducedMotion)
        end)
        return function()
            connection:Disconnect()
        end
    end, {})
    return var1
end

local function ChatApp(tbl4)
    local colorMode = if FFlagExpChatTextChannelWindowThemeByBackground and tbl4.backgroundColor then themeFromBackgroundColor(tbl4.backgroundColor) else Foundation.Enums.ColorMode.Dark
    local reducedMotion = if FFlagExpChatExpressionTrayReducedMotion then useReducedMotion() else false
    local element

    if FFlagExpChatTextChannelWindowFocusNav then
        element = React.createElement(
            ReactFocusNavigation.FocusNavigationContext.Provider,
            { value = focusNavigationService },
            {
                registryProvider = React.createElement(Provider, nil, { inner = React.createElement(ChatAppFocusNav, tbl4) })
            }
        )
    else
        local var3 = table.clone(tbl4)
        var3.focusNavEnabled = false
        element = React.createElement(ChatWindowBody, var3)
    end

    return React.createElement(Foundation.FoundationProvider, {
        colorMode = colorMode,
        preferences = FFlagExpChatExpressionTrayReducedMotion and { reducedMotion = reducedMotion } or nil
    }, { inner = element })
end

return ChatApp
