-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Roact = require(scriptParentParentParent.Roact)
local t = require(scriptParentParentParent.t)
local normalizeFontFace = require(scriptParentParentParent.Foundation).Utility.normalizeFontFace

local Images = require(scriptParentParentParent.UIBlox.App.ImageSet.Images)
local ImageSetComponent = require(scriptParentParentParent.UIBlox.Core.ImageSet.ImageSetComponent)
local withStyle = require(scriptParentParentParent.UIBlox.Core.Style.withStyle)
local RoundedFrame = require(scriptParentParentParent.UIBlox.App.Menu.RoundedFrame)

local var1 = Roact.PureComponent:extend("ModalBottomSheetButton")
local ImageRectSize = Images["component_assets/circle_17"].ImageRectSize
local ImageRectOffset = Images["component_assets/circle_17"].ImageRectOffset

local minX = 8 * Images.ImagesResolutionScale
local minY = 8 * Images.ImagesResolutionScale
local rect = Rect.new(minX, minY, ImageRectSize.x - minX, ImageRectSize.y - minY)
local offset = 8 * Images.ImagesResolutionScale

var1.validateProps = t.strictInterface({
    icon = t.optional(t.union(t.table, t.string)),
    text = t.optional(t.string),
    onActivated = t.optional(t.callback),
    renderRightElement = t.optional(t.callback),
    showImage = t.boolean,
    isFixed = t.boolean,
    onActivatedAndDismissed = t.callback,
    elementHeight = t.integer,
    hasRoundBottom = t.boolean,
    hasRoundTop = t.boolean,
    LayoutOrder = t.integer,
    stayOnActivated = t.optional(t.boolean)
})

var1.defaultProps = {
    icon = {},
    text = "",
    onActivated = function() end
}

function var1.init(arg1)
    local pressed, updatePressed = Roact.createBinding(false)
    arg1.pressed = pressed
    arg1.updatePressed = updatePressed
    arg1.ref = Roact.createRef()
    function arg1.onColorChange(imageColor3)
        if not arg1.ref.current then
            return
        end
        arg1.ref.current.ImageColor3 = imageColor3
    end

    function arg1.onInputBegan(arg2): boolean
        return arg2.UserInputType == Enum.UserInputType.MouseButton1 or arg2.UserInputType == Enum.UserInputType.Touch
    end
    function arg1.onInputEnd(arg2): boolean
        return arg2.UserInputType == Enum.UserInputType.MouseButton1 or arg2.UserInputType == Enum.UserInputType.Touch
    end
end

function var1.render(arg1)
    local hasRoundTop = arg1.props.hasRoundTop
    local hasRoundBottom = arg1.props.hasRoundBottom

    local var2 = nil

    local imageRectSizeX = ImageRectSize.X
    local var3 = imageRectSizeX / 2
    local var4, var5

    if hasRoundTop and hasRoundBottom then
        var4 = ImageRectSize
        var5 = ImageRectOffset
        var2 = rect
    elseif hasRoundTop then
        var4 = Vector2.new(imageRectSizeX, var3)
        var5 = ImageRectOffset
        var2 = Rect.new(var3 - 1, var3 - 1, var3 + 1, var3)
    elseif hasRoundBottom then
        var4 = Vector2.new(imageRectSizeX, var3)
        var5 = ImageRectOffset + Vector2.new(0, var3)
        var2 = Rect.new(var3 - 1, 0, var3 + 1, 1)
    else
        var4 = Vector2.new(1, 1)
        var5 = ImageRectOffset + Vector2.new(var3, var3)
    end

    local elementHeight = arg1.props.elementHeight
    local uDim2 = if arg1.props.isFixed then UDim2.new(0, 300, 0, elementHeight) else UDim2.new(1, -32, 0, elementHeight)
    local offset2 = if arg1.props.showImage or arg1.props.renderRightElement then 12 else 24

    local num1 = offset2
    local var6 = elementHeight * 0.8
    if arg1.props.showImage then
        num1 = num1 + var6 + offset2
    end
    if arg1.props.renderRightElement then
        num1 = num1 + var6 + offset2
    end

    return withStyle(function(arg2)
        local theme = arg2.Theme
        local font = arg2.Font

        local imageColor3 = arg1.pressed:map(function(arg3)
            return if arg3 then theme.BackgroundOnPress.Color else theme.BackgroundUIDefault.Color
        end)
        local imageTransparency = arg1.pressed:map(function(arg3)
            return if arg3 then theme.BackgroundOnPress.Transparency else theme.BackgroundUIDefault.Transparency
        end)
        local textEmphasisColor = theme.TextEmphasis.Color
        local textEmphasisTransparency = theme.TextEmphasis.Transparency

        local createElement = Roact.createElement
        local str1 = "ImageButton"
        local tbl1 = {
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = var2,
            Image = Images["component_assets/circle_17"].Image,
            ImageColor3 = imageColor3,
            ImageRectSize = var4,
            ImageRectOffset = var5,
            ImageTransparency = imageTransparency,
            Size = UDim2.fromScale(1, 1),
            LayoutOrder = arg1.props.LayoutOrder,
            [Roact.Ref] = arg1.ref,
            [Roact.Event.Activated] = arg1.props.onActivatedAndDismissed
        }

        tbl1[Roact.Event.InputBegan] = function(_, arg3)
            if arg1.onInputBegan(arg3) then
                arg1.updatePressed(true)
            end
        end
        tbl1[Roact.Event.InputEnded] = function(_, arg3)
            if arg1.onInputEnd(arg3) then
                arg1.updatePressed(false)
            end
        end
        local tbl2 = {
            buttonContents = Roact.createElement("Frame", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1
            }, {
                horizontalLayout = Roact.createElement("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, offset2)
                }),
                padding = Roact.createElement(
                    "UIPadding",
                    {
                        PaddingLeft = UDim.new(0, offset2),
                        PaddingTop = UDim.new(0.1, 0),
                        PaddingBottom = UDim.new(0.1, 0)
                    }
                ),
                icon = if arg1.props.showImage then Roact.createElement(ImageSetComponent.Label, {
                    Image = arg1.props.icon,
                    ImageColor3 = textEmphasisColor,
                    ImageTransparency = textEmphasisTransparency,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, var6, 0, var6),
                    LayoutOrder = 1
                })
                    or nil else nil,
                textLabel = Roact.createElement("TextLabel", {
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -num1, 1, 0),
                    Text = arg1.props.text,
                    TextTransparency = textEmphasisTransparency,
                    FontFace = normalizeFontFace(font.Header2.Font),
                    TextColor3 = textEmphasisColor,
                    TextSize = font.Header2.RelativeSize * font.BaseSize,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    LayoutOrder = 2
                }),
                rightContainer = arg1.props.renderRightElement
                    and Roact.createElement(
                        "Frame",
                        {
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, var6, 0, var6),
                            LayoutOrder = 3
                        },
                        {
                            hint = arg1.props.renderRightElement()
                        }
                    )
            }),
            bottomBorder = not hasRoundBottom
                and Roact.createElement("Frame", {
                    LayoutOrder = 0,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = theme.Divider.Color,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 1),
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 0)
                })
        }
        local button = createElement(str1, tbl1, tbl2)

        local createElement2 = Roact.createElement
        local str2 = "Frame"
        local tbl3 = {
            LayoutOrder = arg1.props.LayoutOrder,
            Size = uDim2,
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }

        local tbl4 = {
            Background = Roact.createElement(RoundedFrame, {
                zIndex = -1,
                background = theme.BackgroundUIDefault,
                topCornerRadius = if hasRoundTop then UDim.new(0, offset) else nil,
                bottomCornerRadius = if hasRoundBottom then UDim.new(0, offset) else nil
            }),
            Button = button
        }
        return createElement2(str2, tbl3, tbl4)
    end)
end

return var1
