-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local context = scriptParentParent.context
local dependencies = require(scriptParentParent.dependencies)
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local useTokens = require(scriptParentParent.Parent.Foundation).Hooks.useTokens
local type = require(scriptParentParent.type)
local ButtonStack = UIBlox.App.Button.ButtonStack
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local constants = require(scriptParentParent.constants)
local DefaultContentPadding = constants.DefaultContentPadding
local DefaultButtonHeight = constants.DefaultButtonHeight

local useNotificationCardState = require(context.useNotificationCardState)
local useNotificationCardData = require(context.useNotificationCardData)

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

local function func2(arg1, callback, notificationPayload)
    local captionLarge = useTokens().Typography.CaptionLarge
    local result = {}
    if arg1 then
        for _, value in ipairs(arg1) do
            local tbl1 = {
                buttonType = func1(value.buttonStyle),
                props = 0
            }
            local props = {
                text = value.label.text,
                fontStyle = captionLarge,
                onActivated = 0
            }

            function props.onActivated()
                if callback and notificationPayload then
                    callback(value, notificationPayload)
                end
            end

            tbl1.props = props

            table.insert(result, tbl1)
        end
    end
    return result
end

return function()
    local var1 = useNotificationCardState("button")
    local var2 = useNotificationCardData()
    local handleActions = var2.handleActions

    local buttons = func2(var1, handleActions, var2.notificationPayload)

    if not (#buttons > 0) then
        return nil
    end

    return (React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 3
        },
        {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, DefaultContentPadding) }),
            ActionButtons = buttons
                and React.createElement(
                    ButtonStack,
                    {
                        buttonHeight = DefaultButtonHeight,
                        buttons = buttons,
                        marginBetween = DefaultContentPadding
                    }
                )
        }
    ))
end
