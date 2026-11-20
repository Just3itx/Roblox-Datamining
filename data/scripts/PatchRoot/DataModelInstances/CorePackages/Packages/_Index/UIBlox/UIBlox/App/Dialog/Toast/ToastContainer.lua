-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:38:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local t = require(scriptParentParentParentParentParent.t)

local GetTextSize = require(scriptParentParentParentParent.Core.Text.GetTextSize)
local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local memoize = require(scriptParentParentParentParent.Utility.memoize)
local withStyle = require(scriptParentParentParentParent.Core.Style.withStyle)
local validateColorInfo = require(scriptParentParentParentParent.Core.Style.Validator.validateColorInfo)
local ButtonType = require(scriptParentParentParent.Button.Enum.ButtonType)
local FoundationButtonUtils = require(scriptParentParentParent.Button.FoundationButtonUtils)
local StandardButtonSize = require(scriptParentParentParentParent.Core.Button.Enum.StandardButtonSize)
local UIBloxConfig = require(scriptParentParentParentParent.UIBloxConfig)

local vector2 = Vector2.new(36, 36)

local Small = StandardButtonSize.Small

local function getTextHeight(arg1, font, arg2, x: number?) -- Luacid: Inlined by compiler; 2 call sites recovered
    local vector2_2 = Vector2.new(x, 10000)
    return GetTextSize(arg1, arg2, font, vector2_2).Y
end

local var1 = Roact.PureComponent:extend("ToastContainer")

var1.validateProps = t.strictInterface({
    anchorPoint = t.optional(t.Vector2),
    buttonText = t.optional(t.string),
    fitHeight = t.optional(t.boolean),
    iconColorStyle = t.optional(validateColorInfo),
    iconImage = t.optional(t.union(t.table, t.string, t.callback)),
    iconSize = t.optional(t.Vector2),
    iconChildren = t.optional(t.table),
    layoutOrder = t.optional(t.integer),
    onActivated = t.optional(t.callback),
    onTouchSwipe = t.optional(t.callback),
    padding = t.numberMin(0),
    position = t.UDim2,
    pressedScale = t.optional(t.number),
    renderToast = t.callback,
    size = t.UDim2,
    sizeConstraint = t.optional(t.table),
    toastSubtitle = t.optional(t.string),
    toastTitle = t.string,
    buttonType = t.optional(ButtonType.isEnumValue)
})

var1.defaultProps = {
    anchorPoint = Vector2.new(0, 0),
    fitHeight = true,
    padding = 12,
    position = UDim2.new(0, 0, 0, 0),
    size = UDim2.new(1, -24, 0, 0),
    sizeConstraint = {
        MaxSize = Vector2.new(400, math.huge),
        MinSize = Vector2.new(24, 60)
    }
}

function var1.init(arg1)
    arg1.containerRef = Roact.createRef()
    arg1.isMounted = false

    arg1.state = { containerWidth = 0, pressed = false, subtitleHeight = 0, titleHeight = 0 }

    function arg1.getIconSize()
        local iconSize = arg1.props.iconSize
        local iconImage = arg1.props.iconImage
        local imagesResolutionScale = Images.ImagesResolutionScale
        if iconImage then
            return iconSize
                or (if iconImage.ImageRectSize and imagesResolutionScale and imagesResolutionScale > 0 then iconImage.ImageRectSize / imagesResolutionScale else vector2)
        end

        return Vector2.new(0, 0)
    end

    function arg1.onButtonInputBegan(_, arg2)
        if arg2.UserInputState == Enum.UserInputState.Begin
            and (arg2.UserInputType == Enum.UserInputType.Touch or arg2.UserInputType == Enum.UserInputType.MouseButton1)
            and not arg1.state.pressed
        then
            arg1:setState({ pressed = true })
        end
    end

    function arg1.onButtonInputEnded()
        if arg1.state.pressed then
            arg1:setState({ pressed = false })
        end
    end

    function arg1.getTextHeights(arg2): (number, number)
        local iconImage = arg1.props.iconImage
        local iconSize = arg1.getIconSize()
        local buttonText = arg1.props.buttonText
        local onActivated = arg1.props.onActivated
        local padding = arg1.props.padding
        local toastSubtitle = arg1.props.toastSubtitle
        local toastTitle = arg1.props.toastTitle

        local font = arg2.Font
        local header2 = font.Header2
        local captionBody = font.CaptionBody

        local var2 = arg1.state.containerWidth - padding * 2
        if iconImage then
            var2 = var2 - iconSize.X - padding
        end

        if buttonText and onActivated and not arg1.showCompactToast() then
            var2 = var2 - arg1.getButtonDimensions(arg2).X - arg1.getButtonGap()
        end

        local num1 = math.max(0, (getTextHeight(toastTitle, header2.Font, header2.RelativeSize * font.BaseSize, var2)))
        local var3 = if toastSubtitle then math.max(0, (getTextHeight(toastSubtitle, captionBody.Font, captionBody.RelativeSize * font.BaseSize, var2))) else 0
        return var3, num1
    end

    function arg1.showCompactToast(): boolean
        return arg1.state.containerWidth < 400
    end

    function arg1.getButtonGap()
        return if UIBloxConfig.useFoundationToastButtonSizing then arg1.props.padding else 0
    end

    function arg1.showPressed()
        return if arg1.props.buttonText or not arg1.props.onActivated then nil else arg1.state.pressed
    end

    arg1.getButtonDimensions = memoize(function(arg2)
        local buttonText = arg1.props.buttonText
        local onActivated = arg1.props.onActivated
        if not (buttonText and onActivated) then
            return Vector2.new(0, 0)
        end

        local fitContentSize = if UIBloxConfig.useFoundationToastButtonSizing and UIBloxConfig.useFoundationButton then FoundationButtonUtils.getFitContentSize(buttonText, Small, arg2.Tokens) else nil

        if not fitContentSize then
            local font = arg2.Font.Header2.Font
            local var2 = arg2.Font.Header2.RelativeSize * arg2.Font.BaseSize

            fitContentSize = (if UIBloxConfig.useFoundationToastButtonSizing then Vector2.new(32, 16) else Vector2.new(40, 40)) + GetTextSize(buttonText, var2, font, Vector2.new(1000, 1000))
        end

        if not arg1.showCompactToast() then
            return fitContentSize
        end
        return Vector2.new(math.min(fitContentSize.X, 200), fitContentSize.Y)
    end)
end

function var1.render(arg1)
    local iconImage = arg1.props.iconImage
    local iconSize = arg1.getIconSize()
    local padding = arg1.props.padding
    local toastSubtitle = arg1.props.toastSubtitle
    local toastTitle = arg1.props.toastTitle
    return withStyle(function(arg2)
        local yOffset, yOffset2 = arg1.getTextHeights(arg2)
        local yOffset3 = yOffset2 + yOffset
        local buttonDimensionsY = arg1.getButtonDimensions(arg2).Y

        local size = arg1.props.size
        if arg1.props.fitHeight then
            local yOffset4 = math.max(iconSize.Y, yOffset3) + padding * 2 + (if arg1.showCompactToast() and arg1.props.buttonText and arg1.props.onActivated then buttonDimensionsY + arg1.getButtonGap() else 0)

            size = UDim2.new(size.X.Scale, size.X.Offset, 0, yOffset4)
        end

        local theme = arg2.Theme
        local font = arg2.Font
        local header2 = font.Header2
        local captionBody = font.CaptionBody

        local createElement = Roact.createElement
        local str1 = "TextButton"
        local tbl1 = {
            AnchorPoint = arg1.props.anchorPoint,
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.layoutOrder,
            Position = arg1.props.position,
            Size = size,
            Text = ""
        }

        tbl1[Roact.Change.AbsoluteSize] = function(arg3)
            if arg1.state.containerWidth ~= arg3.AbsoluteSize.X then
                arg1:setState({ containerWidth = arg3.AbsoluteSize.X })
            end
        end

        local activated = Roact.Event.Activated
        tbl1[activated] = if arg1.props.buttonText then nil else arg1.props.onActivated
        tbl1[Roact.Event.InputBegan] = arg1.onButtonInputBegan
        tbl1[Roact.Event.InputEnded] = arg1.onButtonInputEnded
        tbl1[Roact.Event.TouchSwipe] = arg1.props.onTouchSwipe
        tbl1[Roact.Ref] = arg1.containerRef
        return createElement(str1, tbl1, {
            UISizeConstraint = Roact.createElement("UISizeConstraint", arg1.props.sizeConstraint),
            Toast = arg1.props.renderToast({
                buttonProps = arg1.props.buttonText
                    and arg1.props.onActivated
                    and {
                        buttonDimensions = arg1.getButtonDimensions(arg2),
                        buttonText = arg1.props.buttonText,
                        onActivated = arg1.props.onActivated,
                        buttonType = arg1.props.buttonType
                    }
                    or nil,
                iconProps = iconImage
                    and {
                        colorStyle = arg1.props.iconColorStyle,
                        Image = iconImage,
                        Size = UDim2.new(0, iconSize.X, 0, iconSize.Y)
                    }
                    or nil,
                iconChildren = arg1.props.iconChildren,
                isCompact = if arg1.props.buttonText and arg1.props.onActivated then arg1.showCompactToast() else nil,
                padding = padding,
                pressed = arg1.showPressed(),
                pressedScale = arg1.props.pressedScale,
                subtitleTextProps = toastSubtitle
                    and {
                        colorStyle = theme.TextEmphasis,
                        fontStyle = captionBody,
                        Size = UDim2.new(1, 0, 0, yOffset),
                        Text = toastSubtitle
                    }
                    or nil,
                textFrameSize = UDim2.new(1, iconImage and -iconSize.X - padding or 0, 0, yOffset3),
                titleTextProps = {
                    colorStyle = theme.TextEmphasis,
                    fontStyle = header2,
                    Size = UDim2.new(1, 0, 0, yOffset2),
                    Text = toastTitle
                }
            })
        })
    end)
end

function var1.didMount(arg1)
    arg1:setState({ containerWidth = arg1.containerRef.current and arg1.containerRef.current.AbsoluteSize.X or 0 })
end

return var1
