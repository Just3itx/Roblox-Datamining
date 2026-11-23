-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Foundation = require(AppChatParent.Foundation)
local useCursor = Foundation.Hooks.useCursor
local React = require(AppChatParent.React)
local useState = React.useState
local memo = React.memo
local useMemo = React.useMemo

local UIBlox = require(AppChatParent.UIBlox)
local ControlState = UIBlox.Core.Control.Enum.ControlState
local var1 = memo(UIBlox.Core.Control.Interactable)

local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)

local _types = require(AppChat.types)

local tbl1 = {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0,
    onPressedBackgroundColor3 = Color3.fromRGB(242, 242, 242),
    onPressedBackgroundTransparency = 1,
    LayoutOrder = 0,
    isDisabled = false,
    onActivated = function()
        print("BaseCell onActivated")
    end,
    showDivider = true,
    dividerTransparency = 0,
    dividerColor3 = Color3.fromRGB(227, 227, 227),
    avatarCircleCellWidth = 60
}

return memo(function(tbl2) -- name: BaseCell
    local var2 = Cryo.Dictionary.join(tbl1, tbl2)
    local var3, var4 = useState(ControlState.Initialize)

    local onStateChanged = React.useCallback(function(_, arg1)
        if not var2.isDisabled then
            var4(arg1)
        end
    end, { var2.isDisabled })

    local var6 = React.useCallback(function()
        if not var2.isDisabled then
            var2.onActivated()
        end
    end, { var2.isDisabled, var2.onActivated })

    local overlay = useMemo(function()
        if var3 ~= ControlState.Pressed then
            return nil
        end

        return (React.createElement("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = var2.onPressedBackgroundTransparency,
            BackgroundColor3 = var2.onPressedBackground3,
            BorderSizePixel = 0
        }))
    end, { var3, var2.onPressedBackground3, var2.onPressedBackgroundTransparency })
    local divider = useMemo(function()
        if not var2.showDivider then
            return nil
        end

        return (React.createElement("Frame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        }, {
            layout = React.createElement(
                "UIListLayout",
                {
                    VerticalAlignment = Enum.VerticalAlignment.Bottom,
                    HorizontalAlignment = Enum.HorizontalAlignment.Right
                }
            ),
            divider = React.createElement("Frame", {
                BackgroundTransparency = var2.dividerTransparency,
                BackgroundColor3 = var2.dividerColor3,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -var2.avatarCircleCellWidth, 0, 1)
            })
        }))
    end, {
        var2.showDivider,
        var2.dividerTransparency,
        var2.dividerColor3,
        var2.avatarCircleCellWidth
    })

    local var9 = useMemo(function()
        return Cryo.Dictionary.join(var2.children or {}, { overlay = overlay, divider = divider })
    end, { var2.children, overlay, divider })

    local selectionImageObject = useCursor(Foundation.Enums.CursorType.RoundedSlot)
    return React.createElement(var1, {
        onStateChanged = onStateChanged,
        [React.Event.Activated] = var6,
        [React.Tag] = if FFlagDebugAppChatEnableDomLocators and var2.testId ~= nil then `data-testid={var2.testId}` else nil,
        AutoButtonColor = false,
        Selectable = var2.Selectable,
        SelectionImageObject = selectionImageObject,
        Size = var2.Size,
        AutomaticSize = var2.AutomaticSize,
        BackgroundColor3 = var2.BackgroundColor3,
        BackgroundTransparency = var2.BackgroundTransparency,
        LayoutOrder = var2.LayoutOrder,
        BorderSizePixel = 0
    }, var9)
end)
