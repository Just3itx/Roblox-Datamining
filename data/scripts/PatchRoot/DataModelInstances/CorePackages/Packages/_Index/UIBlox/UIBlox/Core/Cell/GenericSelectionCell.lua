-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParent.t)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)

local ControlState = require(scriptParentParentParentParent.UIBlox.Core.Control.Enum.ControlState)
local GenericCell = require(scriptParentParentParentParent.UIBlox.Core.Cell.GenericCell)
local ImageSetComponent = require(scriptParentParentParentParent.UIBlox.Core.ImageSet.ImageSetComponent)

local var1 = Roact.PureComponent:extend("GenericSelectionCell")

local tbl1 = {
    [ControlState.Default] = "BackgroundDefault",
    [ControlState.Hover] = "BackgroundOnHover",
    [ControlState.Pressed] = "BackgroundOnPress"
}

local tbl2 = {
    [ControlState.Default] = "IconDefault",
    [ControlState.Hover] = "IconEmphasis",
    [ControlState.Pressed] = "IconDefault"
}

local function getCellStyle(tbl3, arg1, arg2)
    local var2 = tbl3[arg1] or tbl3[ControlState.Default]

    local tbl4 = {
        Color = arg2.Theme[var2].Color,
        Transparency = arg2.Theme[var2].Transparency
    }

    if arg1 == ControlState.Default or arg1 == ControlState.Disabled then
        tbl4.Transparency = 1
    end

    return tbl4
end

local function getIconStyle(tbl3, arg1, arg2)
    local var2 = tbl3[arg1] or tbl3[ControlState.Default]

    local tbl4 = {
        Color = arg2.Theme[var2].Color,
        Transparency = arg2.Theme[var2].Transparency
    }

    if arg1 == ControlState.Disabled or arg1 == ControlState.Pressed then
        tbl4.Transparency = 0.5 * tbl4.Transparency + 0.5
    end

    return tbl4
end

local function getTextStyle(arg1, arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local tbl3 = {
        Color = arg1.Color,
        Transparency = arg1.Transparency
    }

    if arg2 == ControlState.Disabled or arg2 == ControlState.Pressed then
        tbl3.Transparency = 0.5 * tbl3.Transparency + 0.5
    end

    return tbl3
end

var1.validateProps = t.strictInterface({
    text = t.string,
    subtitleText = t.optional(t.string),
    defaultImage = t.union(t.string, t.table),
    selectedImage = t.union(t.string, t.table),
    defaultImageSize = t.number,
    selectedImageSize = t.number,
    onActivated = t.optional(t.callback),
    isSelected = t.optional(t.boolean),
    isDisabled = t.optional(t.boolean),
    useDefaultControlState = t.optional(t.boolean),
    controlRef = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    SelectionImageObject = t.optional(t.table)
})

var1.defaultProps = { isSelected = false }

function var1.init(arg1)
    arg1.state = {
        controlState = ControlState.Default
    }

    function arg1.onStateChanged(_, controlState)
        arg1:setState({ controlState = controlState })
    end
end

function var1.render(arg1)
    assert(arg1.validateProps(arg1.props))

    return withStyle(function(arg2)
        local font = arg2.Font
        local theme = arg2.Theme

        local var2 = arg1.props.useDefaultControlState and ControlState.Default or arg1.state.controlState

        local iconStyle = getIconStyle(tbl2, var2, arg2)
        local colorStyle = getCellStyle(tbl1, var2, arg2)
        local textStyle = getTextStyle(theme.TextEmphasis, var2)
        local subtitleTextStyle = getTextStyle(theme.TextDefault, var2)
        local divider = theme.Divider

        local createElement = Roact.createElement
        local var3 = GenericCell
        local tbl3 = {
            titleText = arg1.props.text,
            colorStyle = colorStyle,
            textStyle = textStyle,
            fontStyle = font.Header2,
            subtitleText = arg1.props.subtitleText,
            subtitleTextStyle = subtitleTextStyle,
            subtitleFontStyle = font.Body,
            rightContentWidth = arg1.props.defaultImageSize,
            onActivated = arg1.props.onActivated,
            dividerStyle = divider,
            isDisabled = arg1.props.isDisabled,
            [Roact.Ref] = arg1.props.controlRef,
            NextSelectionUp = arg1.props.NextSelectionUp,
            NextSelectionDown = arg1.props.NextSelectionDown,
            NextSelectionLeft = arg1.props.NextSelectionLeft,
            NextSelectionRight = arg1.props.NextSelectionRight,
            SelectionImageObject = arg1.props.SelectionImageObject
        }

        function tbl3.renderRightContent()
            return Roact.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, arg1.props.defaultImageSize, 1, 0),
                    LayoutOrder = 3
                },
                {
                    SelectionImage = Roact.createElement(ImageSetComponent.Label, {
                        BackgroundTransparency = 1,
                        Image = arg1.props.defaultImage,
                        Size = UDim2.new(0, arg1.props.defaultImageSize, 0, arg1.props.defaultImageSize),
                        ImageColor3 = iconStyle.Color,
                        ImageTransparency = iconStyle.Transparency,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0)
                    }, {
                        SelectedImage = arg1.props.isSelected
                            and Roact.createElement(ImageSetComponent.Label, {
                                BackgroundTransparency = 1,
                                Image = arg1.props.selectedImage,
                                Size = UDim2.new(0, arg1.props.selectedImageSize, 0, arg1.props.selectedImageSize),
                                ImageColor3 = iconStyle.Color,
                                ImageTransparency = iconStyle.Transparency,
                                AnchorPoint = Vector2.new(0.5, 0.5),
                                Position = UDim2.new(0.5, 0, 0.5, 0)
                            })
                    })
                }
            )
        end

        tbl3.onStateChanged = arg1.onStateChanged
        return createElement(var3, tbl3)
    end)
end

return Roact.forwardRef(function(arg1, controlRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { controlRef = controlRef }))
end)
