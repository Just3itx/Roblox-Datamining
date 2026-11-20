-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)

local GenericTextLabel = require(scriptParentParent.Text.GenericTextLabel.GenericTextLabel)
local Interactable = require(scriptParentParent.Control.Interactable)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)
local validateFontInfo = require(scriptParentParentParent.Core.Style.Validator.validateFontInfo)

local var1 = Roact.PureComponent:extend("GenericCell")

var1.validateProps = t.strictInterface({
    onActivated = t.optional(t.callback),
    isSelected = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    onStateChanged = t.callback,
    titleText = t.optional(t.string),
    subtitleText = t.optional(t.string),
    renderRightContent = t.optional(t.callback),
    rightContentWidth = t.optional(t.number),
    renderLeftContent = t.optional(t.callback),
    leftContentWidth = t.optional(t.number),
    colorStyle = validateColorInfo,
    textStyle = t.optional(validateColorInfo),
    fontStyle = t.optional(validateFontInfo),
    subtitleTextStyle = t.optional(validateColorInfo),
    subtitleFontStyle = t.optional(validateFontInfo),
    dividerStyle = t.table,
    controlRef = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    SelectionImageObject = t.optional(t.table)
})

var1.defaultProps = { rightContentWidth = 0, leftContentWidth = 0, isDisabled = false }

function var1.render(arg1)
    assert(arg1.validateProps(arg1.props))

    local createElement = Roact.createElement
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1
    }

    local tbl2 = {
        Interactable = Roact.createElement(Interactable, {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = arg1.props.colorStyle.Color,
            BackgroundTransparency = arg1.props.colorStyle.Transparency,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            [Roact.Event.Activated] = not arg1.props.isDisabled and arg1.props.onActivated,
            [Roact.Ref] = arg1.props.controlRef,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            SelectionImageObject = arg1.props.SelectionImageObject,
            isDisabled = arg1.props.isDisabled,
            onStateChanged = arg1.props.onStateChanged
        }, {
            Contents = Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    LayoutOrder = 1
                },
                {
                    UIPadding = Roact.createElement("UIPadding", {
                        PaddingLeft = UDim.new(0, 24),
                        PaddingRight = UDim.new(0, 24),
                        PaddingTop = UDim.new(0, 12),
                        PaddingBottom = UDim.new(0, 12)
                    }),
                    UIListLayout = Roact.createElement("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center
                    }),
                    Frame = Roact.createElement("Frame", {
                        Size = UDim2.new(1, -arg1.props.rightContentWidth - arg1.props.leftContentWidth, 1, 0),
                        BackgroundTransparency = 1,
                        LayoutOrder = 2
                    }, {
                        UIListLayout = Roact.createElement("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            FillDirection = Enum.FillDirection.Vertical,
                            VerticalAlignment = Enum.VerticalAlignment.Center
                        }),
                        TitleText = arg1.props.titleText
                            and Roact.createElement(GenericTextLabel, {
                                Size = UDim2.new(1, 0, 1, 0),
                                colorStyle = arg1.props.textStyle,
                                fontStyle = arg1.props.fontStyle,
                                Text = arg1.props.titleText,
                                LayoutOrder = 1,
                                TextXAlignment = Enum.TextXAlignment.Left
                            }),
                        SubTitleText = arg1.props.subtitleText
                            and Roact.createElement(GenericTextLabel, {
                                Size = UDim2.new(1, 0, 1, 0),
                                colorStyle = arg1.props.subtitleTextStyle,
                                fontStyle = arg1.props.subtitleFontStyle,
                                Text = arg1.props.subtitleText,
                                LayoutOrder = 2,
                                TextXAlignment = Enum.TextXAlignment.Left
                            })
                    }),
                    RightContent = arg1.props.renderRightContent and arg1.props.renderRightContent(),
                    LeftContent = arg1.props.renderLeftContent and arg1.props.renderLeftContent()
                }
            ),
            Divider = Roact.createElement("Frame", {
                Size = UDim2.new(1, -24, 0, 1),
                Position = UDim2.new(0, 24, 1, -1),
                BorderSizePixel = 0,
                BackgroundColor3 = arg1.props.dividerStyle.Color,
                BackgroundTransparency = arg1.props.dividerStyle.Transparency
            })
        })
    }
    return createElement("Frame", tbl1, tbl2)
end

return Roact.forwardRef(function(arg1, controlRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { controlRef = controlRef }))
end)
