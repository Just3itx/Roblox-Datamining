-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Cryo = require(scriptParentParentParentParentParent.Cryo)
local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local ToastIcon = require(scriptParent.ToastIcon)
local ToastText = require(scriptParent.ToastText)

local Button = require(scriptParentParentParent.Button.Button)
local ButtonType = require(scriptParentParentParent.Button.Enum.ButtonType)

local StandardButtonSize = require(scriptParentParentParentParent.Core.Button.Enum.StandardButtonSize)
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local var1 = Roact.PureComponent:extend("ToastFrame")

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    buttonProps = t.optional(t.strictInterface({ buttonDimensions = t.Vector2, buttonText = t.string, onActivated = t.callback })),
    iconProps = t.optional(ToastIcon.validateProps),
    iconChildren = t.optional(t.table),
    isCompact = t.optional(t.boolean),
    layoutOrder = t.optional(t.integer),
    padding = t.numberMin(0),
    position = t.optional(t.UDim2),
    size = t.UDim2,
    subtitleTextProps = t.optional(ToastText.validateProps),
    textFrameSize = t.UDim2,
    titleTextProps = ToastText.validateProps,
    buttonType = t.optional(ButtonType.isEnumValue)
})

var1.defaultProps = {
    padding = 0,
    size = UDim2.new(1, 0, 1, 0),
    textFrameSize = UDim2.new(1, 0, 1, 0)
}

local function renderToastIcon(iconProps, iconChildren)
    if not iconProps then
        return nil
    end

    if type(iconProps.Image) == "function" then
        return iconProps.Image(iconProps)
    end
    return Roact.createElement(ToastIcon, Cryo.Dictionary.join(iconProps, { LayoutOrder = 1 }), iconChildren)
end

function var1.render(arg1)
    local buttonProps = arg1.props.buttonProps
    local buttonText = buttonProps and buttonProps.buttonText
    local buttonDimensionsY = buttonProps and buttonProps.buttonDimensions.Y
    local buttonDimensionsX = buttonProps and buttonProps.buttonDimensions.X
    local buttonType = if buttonProps then buttonProps.buttonType or ButtonType.PrimarySystem else nil
    local isCompact = arg1.props.isCompact
    local iconProps = arg1.props.iconProps
    local onActivated = buttonProps and buttonProps.onActivated
    local padding = arg1.props.padding
    local subtitleTextProps = arg1.props.subtitleTextProps

    local var3 = if UIBloxConfig.useFoundationToastButtonSizing then padding else 0
    local verticalAlignment = if subtitleTextProps then if isCompact then Enum.VerticalAlignment.Top else Enum.VerticalAlignment.Center else Enum.VerticalAlignment.Center
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        AnchorPoint = arg1.props.anchorPoint,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = arg1.props.layoutOrder,
        Position = arg1.props.position,
        Size = arg1.props.size
    }
    local tbl2 = {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = if isCompact then Enum.FillDirection.Vertical else Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, padding),
            SortOrder = Enum.SortOrder.LayoutOrder,
            HorizontalAlignment = if isCompact then Enum.HorizontalAlignment.Center else Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center
        }),
        UIPadding = padding > 0
            and Roact.createElement("UIPadding", {
                PaddingBottom = UDim.new(0, padding),
                PaddingLeft = UDim.new(0, padding),
                PaddingRight = UDim.new(0, padding),
                PaddingTop = UDim.new(0, padding)
            }),
        ToastMessageFrame = 0,
        ToastButton = 0
    }

    local createElement2 = Roact.createElement
    local str2 = "Frame"
    local tbl3 = {
        AnchorPoint = arg1.props.anchorPoint,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = false,
        LayoutOrder = 1,
        Position = arg1.props.position,
        Size = if buttonProps then if isCompact then UDim2.new(1, 0, 1, -buttonDimensionsY - var3) else UDim2.new(1, -buttonDimensionsX - var3, 1, 0) else arg1.props.size
    }

    local tbl4 = { UIListLayout = 0, ToastIcon = 0, ToastTextFrame = 0 }
    local createElement3 = Roact.createElement
    local str3 = "UIListLayout"
    local tbl5 = {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, padding),
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = 0
    }

    if not verticalAlignment then
        if isCompact then
            verticalAlignment = Enum.VerticalAlignment.Top
        else
            verticalAlignment = Enum.VerticalAlignment.Center
        end
    end

    tbl5.VerticalAlignment = verticalAlignment
    tbl4.UIListLayout = createElement3(str3, tbl5)

    tbl4.ToastIcon = renderToastIcon(iconProps, arg1.props.iconChildren)
    tbl4.ToastTextFrame = Roact.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            LayoutOrder = 2,
            Size = arg1.props.textFrameSize
        },
        {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    FillDirection = Enum.FillDirection.Vertical,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            ToastTitle = Roact.createElement(ToastText, Cryo.Dictionary.join(arg1.props.titleTextProps, { LayoutOrder = 1 })),
            ToastSubtitle = subtitleTextProps and Roact.createElement(ToastText, Cryo.Dictionary.join(subtitleTextProps, { LayoutOrder = 2 }))
        }
    )
    tbl2.ToastMessageFrame = createElement2(str2, tbl3, tbl4)

    buttonProps = buttonProps
        and Roact.createElement(Button, {
            buttonType = buttonType,
            fitContent = not isCompact,
            layoutOrder = 2,
            maxWidth = if isCompact then nil else buttonProps.buttonDimensions.X,
            onActivated = onActivated,
            standardSize = StandardButtonSize.Small,
            text = buttonText
        })
    tbl2.ToastButton = buttonProps
    return createElement(str1, tbl1, tbl2)
end

return var1
