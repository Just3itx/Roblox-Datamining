-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatLineReporting = script:FindFirstAncestor("ChatLineReporting")
local ChatLineReportingParent = ChatLineReporting.Parent

local React = require(ChatLineReportingParent.React)
local Cryo = require(ChatLineReportingParent.Cryo)
local UIBlox = require(ChatLineReportingParent.UIBlox)
local useLayerCollector = UIBlox.Core.Layout.LayerCollector.useLayerCollector
local useLocalization = require(ChatLineReportingParent.Localization).Hooks.useLocalization

local Constants = require(ChatLineReporting.Common.Constants)
local ChatLineReportInfo = require(ChatLineReporting.Components.ChatLineReportInfo)
local ChatLineReportModalWindow = require(ChatLineReporting.Components.ChatLineReportModalWindow)
local ChatLineReportSelectableLine = require(ChatLineReporting.Components.ChatLineReportSelectableLine)
local isSystemMessage = require(ChatLineReporting.Common.isSystemMessage)

local FFlagChatLineSelectionModalCleanupSizeListeners = require(ChatLineReporting.Flags.FFlagChatLineSelectionModalCleanupSizeListeners)

local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Foundation = require(ChatLineReportingParent.Foundation)
local Empty = Foundation.Empty
local RadioGroup = Foundation.RadioGroup
local ScrollView = Foundation.ScrollView
local ScrollBarVisibility = Foundation.Enums.ScrollBarVisibility

local function createChildren(messages, _, localizedText, scrollViewSizeX)
    local tbl1 = {}

    local tbl2 = ({})
    local num1 = -1

    for value, message in pairs(messages) do
        if isSystemMessage(message) then
            continue
        end

        num1 += 1
        tbl2[value] = num1

        table.insert(
            tbl1,
            React.createElement(RadioGroup.Item, {
                value = value,
                label = React.createElement(
                    ChatLineReportSelectableLine,
                    {
                        message = message,
                        localizedText = localizedText,
                        scrollViewSizeX = scrollViewSizeX
                    }
                )
            })
        )
    end
    return tbl1, tbl2
end

local function useAbsoluteSizeListener(current: (...any) -> (...any), tbl1)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(current)
    var2.current = current

    return React.useCallback(function(current2)
        if tbl1 then
            tbl1.current = current2
        end
        if var1.current then
            var1.current:Disconnect()
            var1.current = nil
        end
        if current2 then
            var1.current = current2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var2.current(current2)
            end)
        end
    end, {})
end

local function ChatLineReportSelectionModalOld(tbl1)
    local visible, var2 = React.useState(false)
    local var3 = React.useRef(nil)
    local var4, var5 = React.useState(0)
    local var6 = React.useRef(nil)
    local scrollViewSizeX, var7 = React.useState(0)
    local var8 = React.useRef(nil)
    local localizedText = useLocalization(Constants.ChatLineLocalizationKeys)

    local tbl2, tbl3 = createChildren(tbl1.messages, tbl1.setSelectedMessage, localizedText, scrollViewSizeX)
    local isDisabled = Cryo.isEmpty(tbl2)

    local var10 = useLayerCollector()
    local absoluteSize = var10.absoluteSize
    local var11, var12

    if FFlagChatLineSelectionModalCleanupSizeListeners then
        var11 = useAbsoluteSizeListener(function(arg1)
            var5(arg1.AbsoluteSize.Y)
        end)
        var12 = useAbsoluteSizeListener(function(arg1)
            var7(arg1.AbsoluteSize.X)
        end, var6)
    else
        var12 = nil
        var11 = nil
    end

    React.useEffect(function()
        if FFlagChatLineSelectionModalCleanupSizeListeners then
            return
        end

        if var3.current then
            var3.current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var5(var3.current.AbsoluteSize.Y)
            end)
        end
    end, { var3.current, absoluteSize })

    React.useEffect(function()
        if FFlagChatLineSelectionModalCleanupSizeListeners then
            return
        end

        if var6.current then
            var6.current:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                var7(var6.current.AbsoluteSize.X)
            end)
        end
    end, { var6.current, absoluteSize })

    React.useEffect(function()
        if not var6.current then
            return
        end

        local current = var6.current:FindFirstChildWhichIsA("ScrollingFrame", true)
        if current then
            var8.current = current
            var8.current.CanvasPosition = Vector2.new(0, Constants.SelectionModalCanvasPositionTopPadding)
            var8.current.Selectable = false
        end
    end, { var6.current })

    local onInfoClicked = React.useCallback(function()
        var2(not visible)
    end, { visible, var2 })

    local createElement = React.createElement
    local var14 = ChatLineReportModalWindow
    local tbl4 = {
        screenSize = Vector2.new(absoluteSize.X, absoluteSize.Y - var10.insets.top),
        position = UDim2.new(0.5, 0, 0, var10.insets.top + Constants.SelectionModalPositionOffset),
        anchorPoint = Vector2.new(0.5, 0),
        title = localizedText.ChatSelectionModalTitle,
        onCloseClicked = tbl1.onBack,
        onInfoClicked = onInfoClicked,
        buttonStackProps = {
            buttons = {{
                buttonType = ButtonType.Secondary,
                props = {
                    onActivated = tbl1.onContinue,
                    text = localizedText.ChatSelectionModalButton,
                    isDisabled = isDisabled or tbl1.selectedMessage == nil
                }
            }}
        }
    }

    local tbl5 = {
        infoView = React.createElement(ChatLineReportInfo, { visible = visible }),
        messageView = 0
    }
    local element

    if isDisabled then
        element = React.createElement(Empty, {})
    else
        local createElement2 = React.createElement
        local var15 = ScrollView
        local tbl6 = {
            Size = UDim2.new(
                1,
                0,
                0,
                math.min(
                    absoluteSize.Y - var10.insets.top - Constants.SelectionModalScreenSizeOffset,
                    var4 + Constants.SelectionModalRadioGroupOffset,
                    not tbl1.maxContentHeight and math.huge or tbl1.maxContentHeight
                )
            ),
            scroll = {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2.new(1, 0, 0, 0),
                scrollBarVisibility = ScrollBarVisibility.Always,
                ScrollingDirection = Enum.ScrollingDirection.Y
            },
            ref = 0,
            LayoutOrder = 1
        }
        if not FFlagChatLineSelectionModalCleanupSizeListeners then
            var12 = var6
        end

        tbl6.ref = var12

        local tbl7 = {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12) }),
            RadioGroup = 0
        }
        local createElement3 = React.createElement
        local root = RadioGroup.Root

        local tbl8 = {
            onValueChanged = function(arg1)
                tbl1.setSelectedMessage(tbl1.messages[arg1])
                tbl1.analyticsDispatch({ type = Constants.AnalyticsActions.SetChatLineSelected, selected_chat_line_index = tbl3[arg1] })
            end,
            ref = 0
        }

        if not FFlagChatLineSelectionModalCleanupSizeListeners then
            var11 = var3
        end

        tbl8.ref = var11
        tbl7.RadioGroup = createElement3(root, tbl8, tbl2)
        element = createElement2(var15, tbl6, tbl7)
    end

    tbl5.messageView = element
    return createElement(var14, tbl4, tbl5)
end

return ChatLineReportSelectionModalOld
