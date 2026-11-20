-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Roact = require(scriptParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local RoactGamepad = require(scriptParentParentParentParentParent.RoactGamepad)
local t = require(scriptParentParentParentParentParent.t)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)

local SpringAnimatedItem = require(scriptParentParentParentParent.Utility.SpringAnimatedItem)
local ImageSetComponent = require(scriptParentParentParentParent.Core.ImageSet.ImageSetComponent)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local GenericTextLabel = require(scriptParentParentParentParent.Core.Text.GenericTextLabel.GenericTextLabel)
local ExpandableTextUtils = require(scriptParentParentParentParent.Core.Text.ExpandableText.ExpandableTextUtils)

local withSelectionCursorProvider = require(scriptParentParentParent.SelectionImage.withSelectionCursorProvider)
local CursorType = require(scriptParentParentParent.SelectionCursor.CursorType)
local useCursorByType = require(scriptParentParentParent.SelectionCursor.useCursorByType)

local Y = 30

local X = 5
local uDim2 = UDim2.new(0, 36, 0, 36)
local uDim2_2 = UDim2.new(1, 0, 0, 36)

local gradientGradient_0_100 = Images["gradient/gradient_0_100"]
local truncate_arrowsActions_truncationExpand = Images["truncate_arrows/actions_truncationExpand"]
local truncate_arrowsActions_truncationCollapse = Images["truncate_arrows/actions_truncationCollapse"]

local springOptions = { dampingRatio = 1, frequency = 3.5 }

local tbl1 = { dampingRatio = 1, frequency = 3.5 }

local var1 = SpringAnimatedItem.wrap(ImageSetComponent.Label)
local var2 = Roact.PureComponent:extend("ExpandableTextArea")

var2.validateProps = t.strictInterface({
    Text = t.optional(t.string),
    Position = t.optional(t.UDim2),
    compactNumberOfLines = t.optional(t.number),
    LayoutOrder = t.optional(t.number),
    width = t.optional(t.UDim),
    padding = t.optional(t.Vector2),
    onClick = t.optional(t.callback),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    frameRef = t.optional(t.table),
    gradientColor = t.optional(t.Color3),
    selectionCursor = t.table,
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var2.defaultProps = { compactNumberOfLines = 2, Text = "", isRoactGamepadEnabled = true }

function var2.init(arg1)
    arg1.state = { isExpanded = false, frameWidth = 0 }

    function arg1.onClick()
        arg1:setState(function(arg2)
            return {
                isExpanded = not arg2.isExpanded
            }
        end)
        if arg1.props.onClick then
            arg1.props.onClick(arg1.state.isExpanded)
        end
    end

    arg1.ref = Roact.createRef()
    arg1.layoutRef = Roact.createRef()
end

function var2.getRef(arg1)
    return arg1.props.frameRef or arg1.ref
end

function var2.applyFit(arg1, arg2)
    local ref = arg1:getRef()
    if not ref.current then
        return
    end
    local current = ref.current
    local yOffset = arg2 + Y + X
    local width = arg1.props.width
    if width then
        current.Size = UDim2.new(width.Scale, width.Offset, 0, yOffset)
        return
    end
    current.Size = UDim2.new(1, 0, 0, yOffset)
end

function var2.didMount(arg1)
    arg1.isMounted = true
    local current = arg1.layoutRef.current
    if current then
        arg1:applyFit(current.AbsoluteContentSize.y)
    end
end

function var2.willUnmount(arg1)
    arg1.isMounted = false
end

function var2.render(arg1)
    local propsText = arg1.props.Text
    local propsPosition = arg1.props.Position
    local compactNumberOfLines = arg1.props.compactNumberOfLines
    local layoutOrder = arg1.props.LayoutOrder
    local width = arg1.props.width
    local padding = arg1.props.padding
    local gradientColor = arg1.props.gradientColor
    local ref = arg1:getRef()

    Y = padding and padding.Y or 30
    X = padding and padding.X or 5

    return withStyle(function(arg2)
        return withSelectionCursorProvider(function(_)
            local theme = arg2.Theme
            local font = arg2.Font
            local textSize = font.BaseSize * font.Body.RelativeSize
            local var4, var5 = ExpandableTextUtils.getExpandableTextHeights(font, arg1.state.frameWidth, propsText, compactNumberOfLines)

            local uDim2_3 = UDim2.new(1, 0, 0, var5 + X)
            local uDim2_4 = UDim2.new(1, 0, 0, var4 + X)
            local bool1 = var5 < var4
            local var6 = not bool1 or arg1.state.isExpanded

            local uDim2_5 = var6 and uDim2_4 or uDim2_3

            local var7 = if arg1.props.isRoactGamepadEnabled and bool1 then RoactGamepad.Focusable.Frame else "Frame"

            local createElement = Roact.createElement
            local tbl3 = {
                BackgroundTransparency = nil,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                LayoutOrder = layoutOrder,
                Position = propsPosition,
                Size = width and UDim2.new(width.Scale, width.Offset, 0, 0) or UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                SelectionImageObject = arg1.props.selectionCursor,
                [Roact.Ref] = ref
            }

            tbl3[Roact.Change.AbsoluteSize] = function(arg3)
                if arg1.state.frameWidth ~= arg3.AbsoluteSize.X then
                    arg1:setState({ frameWidth = arg3.AbsoluteSize.X })
                end
            end

            tbl3.NextSelectionUp = arg1.props.NextSelectionUp
            tbl3.NextSelectionDown = arg1.props.NextSelectionDown
            tbl3.NextSelectionLeft = arg1.props.NextSelectionLeft
            tbl3.NextSelectionRight = arg1.props.NextSelectionRight
            tbl3.inputBindings = arg1.props.isRoactGamepadEnabled
                and bool1
                and {
                    Activated = RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, arg1.onClick)
                }
                or nil

            local tbl4 = { Layout = 0, UIPadding = 0, ExpandableContainer = 0, ButtonContainer = 0 }
            local createElement2 = Roact.createElement
            local tbl5 = {
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Vertical,
                Padding = UDim.new(0, 10)
            }

            tbl5[Roact.Change.AbsoluteContentSize] = function(arg3)
                arg1:applyFit(arg3.AbsoluteContentSize.y)
            end

            tbl5[Roact.Ref] = arg1.layoutRef
            tbl4.Layout = createElement2("UIListLayout", tbl5)

            tbl4.UIPadding = Roact.createElement("UIPadding", { PaddingTop = UDim.new(0, Y) })

            tbl4.ExpandableContainer = Roact.createElement(SpringAnimatedItem.AnimatedFrame, {
                animatedValues = {
                    height = uDim2_5.Y.Offset
                },
                mapValuesToProps = function(arg3)
                    return {
                        Size = UDim2.new(1, 0, uDim2_5.Y.Scale, arg3.height)
                    }
                end,
                regularProps = {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    Size = uDim2_5,
                    LayoutOrder = 0
                },
                springOptions = springOptions
            }, {
                DescriptionText = Roact.createElement(GenericTextLabel, {
                    colorStyle = theme.TextDefault,
                    fontStyle = font.Body,
                    Size = uDim2_5,
                    Text = propsText,
                    TextSize = textSize,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    BackgroundTransparency = 1
                }),
                Gradient = bool1
                    and Roact.createElement(var1, {
                        animatedValues = {
                            height = if var6 then 0 else 30
                        },
                        mapValuesToProps = function(arg3)
                            return {
                                Size = UDim2.new(1, 0, 0, arg3.height)
                            }
                        end,
                        regularProps = {
                            Size = UDim2.new(1, 0, 0, 30),
                            Position = UDim2.new(0, 0, 1, 0),
                            AnchorPoint = Vector2.new(0, 1),
                            BackgroundTransparency = 1,
                            Image = gradientGradient_0_100,
                            ImageColor3 = gradientColor or theme.BackgroundDefault.Color
                        },
                        springOptions = tbl1
                    })
            })
            if bool1 then
                local createElement3 = Roact.createElement
                local tbl6 = {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 10),
                    LayoutOrder = 1
                }
                local tbl7 = {
                    PressableButton = Roact.createElement("TextButton", {
                        Position = UDim2.new(0, 0, 0, -24),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = uDim2_2,
                        Text = "",
                        [Roact.Event.Activated] = arg1.onClick
                    }, {
                        DownArrow = Roact.createElement(ImageSetComponent.Label, {
                            AnchorPoint = Vector2.new(0.5, 0),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.5, 0, 0, 0),
                            Image = uDim2_5 == uDim2_4 and truncate_arrowsActions_truncationCollapse or truncate_arrowsActions_truncationExpand,
                            ImageColor3 = theme.IconEmphasis.Color,
                            ImageTransparency = theme.IconEmphasis.Transparency,
                            Size = uDim2
                        })
                    })
                }
                bool1 = createElement3("Frame", tbl6, tbl7)
            end

            tbl4.ButtonContainer = bool1
            return createElement(var7, tbl3, tbl4)
        end)
    end)
end

return Roact.forwardRef(function(arg1, frameRef)
    local selectionCursor = useCursorByType(CursorType.RoundedRect)
    arg1 = Cryo.Dictionary.join(arg1, { selectionCursor = selectionCursor })

    return Roact.createElement(var2, Cryo.Dictionary.join(arg1, { frameRef = frameRef }))
end)
