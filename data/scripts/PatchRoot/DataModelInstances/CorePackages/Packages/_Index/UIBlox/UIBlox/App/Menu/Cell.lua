-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local validateColorInfo = require(scriptParentParentParent.Core.Style.Validator.validateColorInfo)
local withSelectionCursorProvider = require(scriptParentParentParent.App.SelectionImage.withSelectionCursorProvider)
local CursorKind = require(scriptParentParentParent.App.SelectionImage.CursorKind)
local _StyleTypes = require(scriptParentParentParent.App.Style.StyleTypes)
local Object = require(scriptParentParentParentParent.LuauPolyfill).Object

local ImageSetComponent = require(scriptParentParentParentParent.UIBlox.Core.ImageSet.ImageSetComponent)
local Images = require(scriptParentParentParentParent.UIBlox.App.ImageSet.Images)
local GenericTextLabel = require(scriptParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local divideTransparency = require(scriptParentParentParent.Utility.divideTransparency)
local validateFontInfo = require(scriptParentParentParentParent.UIBlox.Core.Style.Validator.validateFontInfo)

local ControlState = require(scriptParentParentParentParent.UIBlox.Core.Control.Enum.ControlState)

local KeyLabel = require(script.Parent.KeyLabel.KeyLabel)
local RoundedFrame = require(script.Parent.RoundedFrame)

local Interactable = require(scriptParentParentParent.Core.Control.Interactable)

local component_assetsCircle_17 = Images["component_assets/circle_17"]

local var1 = Roact.PureComponent:extend("Cell")

var1.validateProps = t.strictInterface({
    icon = t.optional(t.union(t.table, t.string)),
    text = t.string,
    onActivated = t.callback,
    keyCodeLabel = t.optional(
        t.union(t.enum(Enum.KeyCode), t.strictInterface({ key = t.enum(Enum.KeyCode), axis = t.optional(t.string) }))
    ),
    selected = t.optional(t.boolean),
    iconColorOverride = t.optional(t.Color3),
    textColorOverride = t.optional(t.Color3),
    elementHeight = t.integer,
    hasRoundTop = t.boolean,
    hasRoundBottom = t.boolean,
    hasDivider = t.boolean,
    disabled = t.optional(t.boolean),
    stayOnActivated = t.optional(t.boolean),
    renderRightSideGadget = t.optional(t.callback),
    rightSideGadgetSize = t.optional(t.Vector2),
    leftPaddingOffset = t.optional(t.number),
    layoutOrder = t.integer,
    setButtonRef = t.optional(t.union(t.callback, t.table)),
    cursorKind = t.optional(CursorKind.isEnumValue),
    isElementBackgroundVisible = t.optional(t.boolean),
    dividerOffset = t.optional(t.number),
    dividerSize = t.optional(t.number),
    fontStyle = t.optional(t.union(t.string, validateFontInfo)),
    iconSize = t.optional(t.integer),
    selectedIconSize = t.optional(t.integer),
    iconPaddingLeft = t.optional(t.integer),
    textPadding = t.optional(t.strictInterface({ left = t.integer, right = t.integer })),
    selectedIconPaddingRight = t.optional(t.integer),
    keyLabelPaddingRight = t.optional(t.integer),
    textOnlyPadding = t.optional(t.integer),
    borderCornerRadius = t.optional(t.integer),
    background = t.optional(validateColorInfo),
    selectionOrder = t.optional(t.number),
    selectionCursor = t.optional(t.table)
})

var1.defaultProps = {
    selected = false,
    disabled = false,
    rightSideGadgetSize = nil,
    leftPaddingOffset = 0,
    isElementBackgroundVisible = true,
    dividerOffset = 0,
    dividerSize = 1,
    iconSize = 36,
    selectedIconSize = 16,
    iconPaddingLeft = 12,
    textPadding = { left = 12, right = 12 },
    selectedIconPaddingRight = 24,
    textOnlyPadding = 24,
    keyLabelPaddingRight = 16,
    borderCornerRadius = 4
}

function var1.init(arg1)
    arg1.state = {
        controlState = ControlState.Default,
        keyLabelWidth = 0
    }

    function arg1.keyLabelSizeChanged(arg2)
        arg1:setState({ keyLabelWidth = arg2.AbsoluteSize.X })
    end

    function arg1.setControlState(controlState)
        arg1:setState({ controlState = controlState })
    end

    function arg1.onStateChanged(_, arg2)
        arg1.setControlState(arg2)
    end
end

function var1.getImageProperties(arg1)
    local imageRectSize = component_assetsCircle_17.ImageRectSize
    local imageRectOffset = component_assetsCircle_17.ImageRectOffset

    local minX = 8 * Images.ImagesResolutionScale
    local minY = 8 * Images.ImagesResolutionScale
    local rect = Rect.new(minX, minY, imageRectSize.x - minX, imageRectSize.y - minY)

    local imageRectSizeX = imageRectSize.X
    local num1 = math.floor(imageRectSizeX / 2)

    if arg1.props.hasRoundTop and arg1.props.hasRoundBottom then
        return imageRectSize, imageRectOffset, rect
    elseif arg1.props.hasRoundTop then
        return Vector2.new(imageRectSizeX, num1), imageRectOffset, Rect.new(num1 - 1, num1 - 1, num1 + 1, num1)
    elseif arg1.props.hasRoundBottom then
        return Vector2.new(imageRectSizeX, num1), imageRectOffset + Vector2.new(0, num1), Rect.new(num1 - 1, 0, num1 + 1, 1)
    end
    return Vector2.new(1, 1), imageRectOffset + Vector2.new(num1, num1), Rect.new(0, 0, 0, 0)
end

function var1.renderRoundedBackground(tbl1, zIndex: number, background)
    local uDim = UDim.new(0, tbl1.props.borderCornerRadius)
    local createElement = Roact.createElement
    local var2 = RoundedFrame
    local tbl2 = {
        zIndex = zIndex,
        background = background,
        topCornerRadius = if tbl1.props.hasRoundTop then uDim else nil,
        bottomCornerRadius = 0
    }

    if not tbl1.props.hasRoundBottom then
        uDim = nil
    end

    tbl2.bottomCornerRadius = uDim
    return createElement(var2, tbl2)
end

function var1.renderWithSelectionCursor(arg1, _)
    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font
        local settings = arg2.Settings

        local textOnlyPadding = arg1.props.textOnlyPadding
        if arg1.props.icon then
            textOnlyPadding = arg1.props.iconPaddingLeft
        end
        local offset = textOnlyPadding + arg1.props.leftPaddingOffset
        local offset2 = 0
        if arg1.props.keyCodeLabel then
            offset2 = arg1.props.keyLabelPaddingRight
        elseif arg1.props.selected then
            offset2 = arg1.props.selectedIconPaddingRight
        end

        local tbl1 = {
            Color = Color3.new(1, 1, 1),
            Transparency = 1
        }

        if arg1.state.controlState == ControlState.Pressed then
            tbl1 = theme.BackgroundOnPress
        elseif arg1.state.controlState == ControlState.Hover then
            tbl1 = theme.BackgroundOnHover
        end

        local imageRectSize, imageRectOffset, sliceCenter = arg1:getImageProperties()

        local num1 = 0
        local bool1 = true
        local var5

        if arg1.props.rightSideGadgetSize ~= nil then
            var5 = arg1.props.rightSideGadgetSize.X + arg1.props.iconPaddingLeft + arg1.props.iconSize + arg1.props.textPadding.left
        else
            if arg1.props.icon then
                offset = arg1.props.iconPaddingLeft
                num1 = arg1.props.iconPaddingLeft + arg1.props.iconSize
                bool1 = false
            end

            if arg1.props.selected then
                num1 = num1 + arg1.props.selectedIconSize + arg1.props.selectedIconPaddingRight
                bool1 = false
            end

            if arg1.props.keyCodeLabel then
                num1 = num1 + arg1.props.keyLabelPaddingRight + arg1.state.keyLabelWidth
                bool1 = false
            end

            if bool1 then
                var5 = num1 + arg1.props.textOnlyPadding * 2
            else
                var5 = num1 + arg1.props.textPadding.left + arg1.props.textPadding.right
            end
        end

        local textEmphasis = theme.TextEmphasis
        local var6 = arg1.props.textColorOverride
            and {
                Color = arg1.props.textColorOverride,
                Transparency = theme.TextEmphasis.Transparency
            }
            or textEmphasis

        local colorStyle = (arg1.state.controlState == ControlState.Pressed or arg1.props.disabled)
            and {
                Color = var6.Color,
                Transparency = divideTransparency(theme.TextEmphasis.Transparency, 2)
            }
            or var6

        local backgroundUiDefault = theme.BackgroundUIDefault
        local var8 = Object.assign(
            {},
            {
                Color = backgroundUiDefault.Color,
                Transparency = backgroundUiDefault.Transparency
            },
            arg1.props.background
        )
        var8.Transparency *= settings.PreferredTransparency

        local tbl2 = {
            Background = if arg1.props.isElementBackgroundVisible then arg1:renderRoundedBackground(-1, var8) else nil,
            Divider = Roact.createElement("Frame", {
                BackgroundColor3 = theme.Divider.Color,
                BackgroundTransparency = theme.Divider.Transparency,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -arg1.props.dividerOffset, 0, arg1.props.dividerSize),
                Position = UDim2.new(0, arg1.props.dividerOffset, 1, 0),
                AnchorPoint = Vector2.new(0, 1),
                Visible = arg1.props.hasDivider
            }),
            StateOverlay = arg1:renderRoundedBackground(2, tbl1),
            LeftAlignedContent = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1)
            }, {
                Layout = Roact.createElement("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, arg1.props.textPadding.left)
                }),
                LeftPadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, offset) }),
                Icon = arg1.props.icon
                    and Roact.createElement(ImageSetComponent.Label, {
                        Image = arg1.props.icon,
                        Size = UDim2.fromOffset(arg1.props.iconSize, arg1.props.iconSize),
                        BackgroundTransparency = 1,
                        ImageColor3 = arg1.props.iconColorOverride or theme.IconEmphasis.Color,
                        ImageTransparency = divideTransparency(theme.IconEmphasis.Transparency, if arg1.props.disabled then 2 else 1),
                        LayoutOrder = 1
                    }),
                Text = Roact.createElement(GenericTextLabel, {
                    fontStyle = arg1.props.fontStyle or font.Header2,
                    colorStyle = colorStyle,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -var5, 1, 0),
                    Text = arg1.props.text,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = false,
                    LayoutOrder = 2
                })
            }),
            RightAlignedContent = 0
        }

        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl3 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1)
        }
        local tbl4 = {
            Layout = Roact.createElement("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, arg1.props.textPadding.right)
            }),
            RightPadding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, offset2) }),
            RightSideContent = 0
        }

        local element = arg1.props.renderRightSideGadget
            and arg1.props.rightSideGadgetSize
            and Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = 3,
                Size = UDim2.fromOffset(arg1.props.rightSideGadgetSize.X, arg1.props.rightSideGadgetSize.Y)
            }, arg1.props.renderRightSideGadget())

        if not element then
            local createFragment = Roact.createFragment
            local tbl5 = {
                KeyLabel = arg1.props.keyCodeLabel
                    and Roact.createElement(
                        KeyLabel,
                        {
                            keyCode = arg1.props.keyCodeLabel,
                            LayoutOrder = 2,
                            [Roact.Change.AbsoluteSize] = arg1.keyLabelSizeChanged
                        }
                    ),
                SelectedIcon = Roact.createElement(ImageSetComponent.Label, {
                    Image = Images["icons/status/success_small"],
                    Size = UDim2.fromOffset(arg1.props.selectedIconSize, arg1.props.selectedIconSize),
                    LayoutOrder = 1,
                    BackgroundTransparency = 1,
                    ImageColor3 = theme.IconEmphasis.Color,
                    ImageTransparency = theme.IconEmphasis.Transparency,
                    Visible = arg1.props.selected
                })
            }
            element = createFragment(tbl5)
        end

        tbl4.RightSideContent = element
        tbl2.RightAlignedContent = createElement(str1, tbl3, tbl4)

        return Roact.createElement(Interactable, {
            Size = UDim2.new(1, 0, 0, arg1.props.elementHeight),
            BackgroundTransparency = 1,
            Image = nil,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = sliceCenter,
            ImageRectSize = imageRectSize,
            ImageRectOffset = imageRectOffset,
            SliceScale = 1 / Images.ImagesResolutionScale,
            ImageTransparency = 1,
            ImageColor3 = var8.Color,
            AutoButtonColor = false,
            LayoutOrder = arg1.props.layoutOrder,
            BorderSizePixel = 0,
            [Roact.Ref] = arg1.props.setButtonRef,
            SelectionImageObject = arg1.props.selectionCursor,
            SelectionOrder = arg1.props.selectionOrder,
            onStateChanged = arg1.onStateChanged,
            [Roact.Event.Activated] = arg1.props.onActivated,
            isDisabled = arg1.props.disabled
        }, tbl2)
    end)
end

function var1.render(arg1)
    return withSelectionCursorProvider(function(arg2)
        return arg1:renderWithSelectionCursor(arg2)
    end)
end

return var1
