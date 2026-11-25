-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local context = scriptParentParent.context
local Hooks = scriptParentParent.Hooks
local utils = scriptParentParent.utils
local dependencies = require(scriptParentParent.dependencies)
local UIBlox = dependencies.UIBlox
local useTokens = require(scriptParentParent.Parent.Foundation).Hooks.useTokens
local useLocalization = dependencies.Localization.Hooks.useLocalization
local type = require(scriptParentParent.type)
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local constants = require(scriptParentParent.constants)
local DefaultContentPadding = constants.DefaultContentPadding
local DefaultButtonHeight = constants.DefaultButtonHeight

local scriptParentParentParent = scriptParentParent.Parent
local React = require(scriptParentParentParent.React)
local useFocusGuiObject = require(scriptParentParentParent.ReactFocusNavigation).useFocusGuiObject
local FocusNavigationUtils = require(scriptParentParentParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local getTimerFromCardData = require(utils.toastNotificationHelper).getTimerFromCardData

local useNotificationCardState = require(context.useNotificationCardState)
local useNotificationCardData = require(context.useNotificationCardData)
local useTimeRemainingMap = require(Hooks.useTimeRemainingMap)

local function func1(buttonStyle) -- Luacid: Inlined by compiler; 1 call site recovered
    if buttonStyle == type.SENDERButtonStyleEnum.Growth then
        return ButtonType.PrimaryContextual
    end

    if buttonStyle == type.SENDERButtonStyleEnum.Primary then
        return ButtonType.PrimarySystem
    end

    if buttonStyle == type.SENDERButtonStyleEnum.Secondary then
        return ButtonType.Secondary
    end

    if buttonStyle == type.SENDERButtonStyleEnum.Alert then
        return ButtonType.Alert
    end

    return ButtonType.Secondary
end

local function func2(arg1, tbl1, callback, buttonRef)
    local var1 = useTokens()
    local var2 = useNotificationCardData()

    local tbl2 = {}
    for _, value in ipairs(arg1) do
        if value.timer and value.timer.showTimeOnElement then
            tbl2[value.timer.showTimeOnElement] = getTimerFromCardData(var2, value.timer.showTimeOnElement)
        end
    end
    local var3 = useTimeRemainingMap(tbl2, var2)

    local result = {}
    if arg1 then
        for _, value in ipairs(arg1) do
            local text = if value and value.timer and value.timer.showTimeOnElement then `{value.label.text} ({var3[value.timer.showTimeOnElement]}{tbl1.secondsAbbreviated})` else value and value.label and value.label.text or ""
            local buttonType = func1(value.buttonStyle)

            local tbl3 = { buttonType = buttonType, props = 0 }
            local props = {
                text = text,
                fontStyle = var1.Typography.TitleLarge,
                onActivated = 0,
                buttonRef = 0
            }

            function props.onActivated()
                if callback then
                    callback(value)
                end
            end
            props.buttonRef = if buttonType == ButtonType.PrimaryContextual then buttonRef else nil
            tbl3.props = props

            table.insert(result, tbl3)
        end
    end
    return result
end

return function(tbl1)
    local var1 = useNotificationCardState("button")
    local handleActions = useNotificationCardData().handleActions

    local var2 = useLocalization({ secondsAbbreviated = "Feature.Notifications.Label.SecondsAbbreviated" })

    local shouldAutoFocus = tbl1.shouldAutoFocus
    local var3 = React.useRef(nil)
    local var4 = useFocusGuiObject()

    React.useEffect(function()
        if not shouldAutoFocus then
            return
        end

        local current = var3.current
        if current then
            var4(current)

            return function()
                var4(nil)
            end
        end
    end, { shouldAutoFocus, var4 })

    local buttons = func2(var1, var2, handleActions, var3)

    if not (#buttons > 0) then
        return nil
    end

    return (React.createElement(
        "Frame",
        {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 0)
        },
        {
            FocusRoot = React.createElement(FocusRoot, {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp,
                isIsolated = true,
                isFocusable = shouldAutoFocus,
                isAutoFocusRoot = shouldAutoFocus
            }, {
                ActionButtons = buttons
                    and React.createElement(
                        ButtonStack,
                        {
                            buttonHeight = DefaultButtonHeight,
                            buttons = buttons,
                            marginBetween = DefaultContentPadding
                        }
                    )
            })
        }
    ))
end
