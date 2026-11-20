-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local normalizeFontFace = require(scriptParentParentParentParent.Foundation).Utility.normalizeFontFace

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)
local RoactGamepad = require(scriptParentParentParentParent.RoactGamepad)

local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local GetFontFromFontStyle = require(scriptParentParentParent.Core.Text.GetFontFromFontStyle)
local ImageSetComponent = require(scriptParentParentParent.Core.ImageSet.ImageSetComponent)
local validateImage = require(scriptParentParentParent.Core.ImageSet.Validator.validateImage)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local getPageMargin = require(scriptParentParent.Container.getPageMargin)
local IconSize = require(scriptParentParent.ImageSet.Enum.IconSize)
local getIconSize = require(scriptParentParent.ImageSet.getIconSize)
local Images = require(scriptParentParent.ImageSet.Images)

local Button = require(scriptParentParent.Button.Button)
local ButtonType = require(scriptParentParent.Button.Enum.ButtonType)

local var1 = Roact.PureComponent:extend("EmptyState")

var1.validateProps = t.strictInterface({
    text = t.string,
    icon = t.optional(validateImage),
    size = t.optional(t.UDim2),
    position = t.optional(t.UDim2),
    anchorPoint = t.optional(t.Vector2),
    buttonIcon = t.optional(validateImage),
    buttonText = t.optional(t.string),
    buttonType = t.optional(ButtonType.isEnumValue),
    onActivated = t.optional(t.callback),
    frameRef = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    maxSizeTextLabel = t.optional(t.Vector2),
    iconColor = t.optional(t.Color3),
    iconSize = t.optional(t.UDim2),
    titleProps = t.optional(t.strictInterface({ titleText = t.optional(t.string) }))
})

var1.defaultProps = {
    icon = Images["icons/status/oof_xlarge"],
    size = UDim2.fromScale(1, 1),
    position = UDim2.fromScale(0.5, 0.5),
    anchorPoint = Vector2.new(0.5, 0.5),
    buttonIcon = Images["icons/common/refresh"],
    buttonType = ButtonType.Secondary,
    iconSize = UDim2.fromOffset(getIconSize(IconSize.XLarge), getIconSize(IconSize.XLarge))
}

local function getCorrectedIconValue(buttonIcon) -- Luacid: Inlined by compiler; 1 call site recovered
    return if buttonIcon == "" then nil else buttonIcon
end

function var1.init(arg1)
    arg1:setState({ absoluteSize = Vector2.new(0, 0) })

    function arg1.onAbsoluteSizeChange(arg2)
        arg1:setState({ absoluteSize = arg2.AbsoluteSize })
    end

    arg1.buttonRef = Roact.createRef()
end

function var1.render(arg1)
    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local frame = RoactGamepad.Focusable.Frame
        local tbl1 = {
            [Roact.Change.AbsoluteSize] = arg1.onAbsoluteSizeChange,
            Size = arg1.props.size,
            Position = arg1.props.position,
            AnchorPoint = arg1.props.anchorPoint,
            BackgroundTransparency = 1,
            [Roact.Ref] = arg1.props.frameRef,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            NextSelectionULeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            defaultChild = arg1.buttonRef
        }
        local tbl2 = { Content = 0 }
        local createElement2 = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            Size = UDim2.new(1, 0, 0, 187),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1
        }
        local tbl4 = {
            UIListLayout = Roact.createElement(
                "UIListLayout",
                {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }
            ),
            Icon = Roact.createElement(ImageSetComponent.Label, {
                AnchorPoint = Vector2.new(0.5, 0),
                Size = arg1.props.iconSize,
                LayoutOrder = 1,
                Image = arg1.props.icon,
                BackgroundTransparency = 1,
                ImageColor3 = arg1.props.iconColor or arg2.Theme.IconEmphasis.Color,
                ImageTransparency = arg2.Theme.IconEmphasis.Transparency
            }),
            iconTextPadding = Roact.createElement(
                "Frame",
                {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.fromOffset(0, 12),
                    BackgroundTransparency = 1,
                    LayoutOrder = 2
                }
            ),
            TitleFrame = 0,
            Text = 0,
            textButtonPadding = 0,
            buttonFrame = 0
        }
        local element

        if arg1.props.titleProps and arg1.props.titleProps.titleText then
            element = Roact.createElement("Frame", {
                Size = UDim2.fromScale(1, 0),
                Position = UDim2.fromScale(0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                BorderSizePixel = 0,
                LayoutOrder = 3
            }, {
                TitlePadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, 14), PaddingBottom = UDim.new(0, 14) }),
                TitleText = Roact.createElement("TextLabel", {
                    BackgroundTransparency = 1,
                    Text = arg1.props.titleProps.titleText,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    FontFace = normalizeFontFace(GetFontFromFontStyle(arg2.Font.Title)),
                    TextSize = arg2.Font.Header1.RelativeSize * arg2.Font.BaseSize,
                    TextColor3 = arg2.Theme.TextEmphasis.Color,
                    TextTransparency = arg2.Theme.TextEmphasis.Transparency,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.fromScale(1, 0),
                    TextWrapped = true,
                    LayoutOrder = 1
                })
            })
        else
            element = nil
        end

        tbl4.TitleFrame = element

        tbl4.Text = Roact.createElement(GenericTextLabel, {
            Text = arg1.props.text,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
            LayoutOrder = 4,
            fontStyle = arg2.Font.Body,
            colorStyle = arg2.Theme.TextDefault,
            maxSize = arg1.props.maxSizeTextLabel
        })
        tbl4.textButtonPadding = Roact.createElement(
            "Frame",
            {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.fromOffset(0, 24),
                BackgroundTransparency = 1,
                LayoutOrder = 5
            }
        )

        local onActivated = arg1.props.onActivated

        if onActivated then
            local createElement3 = Roact.createElement
            local tbl5 = {
                Size = UDim2.new(1, 0, 0, 48),
                AnchorPoint = Vector2.new(0.5, 0),
                BackgroundTransparency = 1,
                LayoutOrder = 6
            }

            local tbl6 = {
                UIPadding = Roact.createElement("UIPadding", {
                    PaddingLeft = UDim.new(0, getPageMargin(arg1.state.absoluteSize.X)),
                    PaddingRight = UDim.new(0, getPageMargin(arg1.state.absoluteSize.X))
                }),
                UISizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(640, 48) }),
                Button = Roact.createElement(Button, {
                    buttonType = arg1.props.buttonType,
                    size = UDim2.fromScale(1, 1),
                    position = UDim2.fromScale(0.5, 0.5),
                    anchorPoint = Vector2.new(0.5, 0.5),
                    onActivated = arg1.props.onActivated,
                    icon = getCorrectedIconValue(arg1.props.buttonIcon),
                    text = arg1.props.buttonText,
                    [Roact.Ref] = arg1.buttonRef
                })
            }
            onActivated = createElement3("Frame", tbl5, tbl6)
        end

        tbl4.buttonFrame = onActivated
        tbl2.Content = createElement2(str1, tbl3, tbl4)
        return createElement(frame, tbl1, tbl2)
    end)
end

return Roact.forwardRef(function(arg1, frameRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)
