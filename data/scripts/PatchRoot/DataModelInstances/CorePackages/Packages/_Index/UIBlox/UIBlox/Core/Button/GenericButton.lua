-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)
local t = require(scriptParentParentParentParent.t)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParent.Foundation)

local EventConnection = require(scriptParentParentParentParent.ReactUtils).EventConnection

local Interactable = require(scriptParentParent.Control.Interactable)

local ControlState = require(scriptParentParent.Control.Enum.ControlState)
local getContentStyle = require(script.Parent.getContentStyle)

local withStyle = require(scriptParentParentParent.Core.Style.withStyle)
local ImageSetComponent = require(scriptParentParent.ImageSet.ImageSetComponent)
local Skeleton = Foundation.Skeleton
local IconSize = require(scriptParentParentParent.App.ImageSet.Enum.IconSize)
local getClosestRadius = require(scriptParentParentParent.App.Loading.getClosestRadius)
local getIconSize = require(scriptParentParentParent.App.ImageSet.getIconSize)
local GenericTextLabel = require(scriptParentParent.Text.GenericTextLabel.GenericTextLabel)
local withAnimation = require(scriptParentParentParent.Core.Animation.withAnimation)
local validateFontInfo = require(scriptParentParent.Style.Validator.validateFontInfo)
local validateTypographyInfo = require(scriptParentParentParent.Core.Style.Validator.validateTypographyInfo)
local HoverButtonBackground = require(scriptParentParent.Button.HoverButtonBackground)
local StandardButtonSize = require(scriptParent.Enum.StandardButtonSize)

local validateImage = require(scriptParentParent.ImageSet.Validator.validateImage)

local var1 = Roact.PureComponent:extend("GenericButton")

function var1.init(arg1)
    arg1:setState({
        controlState = ControlState.Initialize,
        absoluteSize = Vector2.new(100, 100),
        targetLoadingProgress = 1,
        isButtonUnfocused = RunService:GetRobloxGuiFocused()
    })

    function arg1.onStateChanged(arg2, controlState)
        arg1:setState({ controlState = controlState })

        if arg1.props.onStateChanged then
            arg1.props.onStateChanged(arg2, controlState)
        end
    end

    function arg1.onAbsoluteSizeChanged(arg2)
        arg1:setState({ absoluteSize = arg2.AbsoluteSize })

        if arg1.props[Roact.Change.AbsoluteSize] then
            arg1.props[Roact.Change.AbsoluteSize](arg2)
        end
    end

    function arg1.onRobloxGuiFocusedChanged(arg2)
        if arg2 then
            arg1:setState({ targetLoadingProgress = 1, isButtonUnfocused = true })
            return
        end

        arg1:setState({ isButtonUnfocused = false })
    end
end

local buttonStateColorMap = t.interface({ [ControlState.Default] = t.string })

var1.validateProps = t.interface({
    icon = t.optional(validateImage),
    text = t.optional(t.string),
    inputIcon = t.optional(validateImage),
    buttonImage = validateImage,
    fontStyle = t.optional(t.union(t.string, validateFontInfo, validateTypographyInfo)),
    delayedInputImage = t.optional(validateImage),
    buttonStateColorMap = buttonStateColorMap,
    contentStateColorMap = t.optional(buttonStateColorMap),
    textStateColorMap = t.optional(buttonStateColorMap),
    iconStateColorMap = t.optional(buttonStateColorMap),
    inputIconStateColorMap = t.optional(buttonStateColorMap),
    isDisabled = t.optional(t.boolean),
    isLoading = t.optional(t.boolean),
    isDelayedInput = t.optional(t.boolean),
    isHoverBackgroundEnabled = t.optional(t.boolean),
    hoverImage = t.optional(validateImage),
    enableInputDelayed = t.optional(t.boolean),
    delayInputSeconds = t.optional(t.numberPositive),
    onActivated = t.callback,
    onStateChanged = t.optional(t.callback),
    userInteractionEnabled = t.optional(t.boolean),
    standardSize = t.optional(StandardButtonSize.isEnumValue),
    maxWidth = t.optional(t.numberPositive),
    fitContent = t.optional(t.boolean),
    buttonTextOverride = t.optional(
        t.strictInterface({
            RichText = t.optional(t.boolean),
            Size = t.optional(t.UDim2),
            TextSize = t.optional(t.number),
            TextWrapped = t.optional(t.boolean),
            TextTruncate = t.optional(t.enum(Enum.TextTruncate)),
            TextXAlignment = t.optional(t.enum(Enum.TextXAlignment))
        })
    ),
    forwardedRef = t.optional(t.union(t.table, t.callback)),
    feedbackType = t.optional(t.string)
})

var1.defaultProps = {
    fontStyle = "Header2",
    isDisabled = false,
    isLoading = false,
    isDelayedInput = false,
    enableInputDelayed = false,
    delayInputSeconds = 3,
    SliceCenter = Rect.new(8, 8, 9, 9)
}

function var1.didMount(arg1)
    arg1:setState(
        {
            targetLoadingProgress = if arg1.state.isButtonUnfocused or not arg1.props.enableInputDelayed then 1 else 0
        }
    )
end

function var1.render(arg1)
    local isDelayedInput = arg1.props.isDelayedInput
    local delayInputSeconds = arg1.props.delayInputSeconds

    if isDelayedInput and not arg1.state.isButtonUnfocused then
        local targetLoadingProgress = arg1.state.targetLoadingProgress

        return withAnimation({ loadingProgress = targetLoadingProgress }, function(arg2)
            local num1 = math.clamp(arg2.loadingProgress, 0, 1)
            return arg1:renderButton(num1)
        end, {
            frequency = 1 / delayInputSeconds,
            dampingRatio = 0.8
        })
    elseif arg1.state.isButtonUnfocused then
        return arg1:renderButton(1)
    else
        return arg1:renderButton()
    end
end

function var1.renderButton(arg1, arg2)
    return withStyle(function(arg3)
        assert(t.table(arg3), "Style provider is missing.")

        local controlState = arg1.state.controlState

        local text = arg1.props.text
        local icon = arg1.props.icon
        local inputIcon = arg1.props.inputIcon
        local isLoading = arg1.props.isLoading
        local isDisabled = arg1.props.isDisabled
        local isDelayedInput = arg1.props.isDelayedInput

        local userInteractionEnabled = arg1.props.userInteractionEnabled

        local buttonImage = arg1.props.buttonImage
        local fontStyle = arg1.props.fontStyle
        local delayedInputImage = arg1.props.delayedInputImage
        local buttonStateColorMap2 = arg1.props.buttonStateColorMap
        local contentStateColorMap = arg1.props.contentStateColorMap
        local var3 = arg1.props.textStateColorMap or contentStateColorMap
        local var4 = arg1.props.iconStateColorMap or contentStateColorMap
        local var5 = arg1.props.inputIconStateColorMap or contentStateColorMap
        local propsSize = arg1.props.Size
        local standardSize = arg1.props.standardSize
        local maxWidth = arg1.props.maxWidth or 640
        local fitContent = arg1.props.fitContent

        if text then
            assert(buttonStateColorMap(var3), "textStateColorMap is missing or invalid.")
        end
        if icon then
            assert(buttonStateColorMap(var4), "iconStateColorMap is missing or invalid.")
        end
        if inputIcon then
            assert(buttonStateColorMap(var5), "inputIconStateColorMap is missing or invalid.")
        end
        if isDelayedInput and delayedInputImage == nil then
            isDelayedInput = false
        end

        if isLoading then
            isDisabled = true
        end

        if isDisabled then
            isDelayedInput = false
        end

        if type(fontStyle) == "string" then
            fontStyle = arg3.Font[fontStyle]
        end

        if arg2 == 1 then
            delayedInputImage = buttonImage
        end

        if isDelayedInput and arg2 ~= 0 then
            userInteractionEnabled = false
        end

        local contentStyle = getContentStyle(buttonStateColorMap2, controlState, arg3)
        local colorStyle = text and getContentStyle(var3, controlState, arg3)
        local contentStyle3 = icon and getContentStyle(var4, controlState, arg3)
        local contentStyle4 = inputIcon and getContentStyle(var5, controlState, arg3)
        local bool1 = controlState == ControlState.Hover and arg1.props.isHoverBackgroundEnabled == true
        local hoverImage = arg1.props.hoverImage

        local offset = 5
        local var6

        if standardSize then
            local yOffset = nil
            var6 = nil
            if standardSize == StandardButtonSize.Regular then
                fontStyle = arg3.Font.Header2
                yOffset = 48
                offset = 12
                var6 = false
            elseif standardSize == StandardButtonSize.Small then
                fontStyle = arg3.Font.Header2
                yOffset = 36
                offset = 8
                var6 = false
            elseif standardSize == StandardButtonSize.XSmall then
                fontStyle = arg3.Font.CaptionHeader
                yOffset = 28
                offset = 8
                var6 = true
            end

            if fitContent ~= nil then
                var6 = fitContent
            end

            propsSize = UDim2.new(if var6 then 0 else 1, 0, 0, yOffset)
        else
            var6 = fitContent
        end

        local prop

        if isLoading then
            prop = { isLoadingShimmer = 0 }
            local createElement = Roact.createElement
            local var7 = Skeleton
            local tbl1 = {
                Size = if standardSize then UDim2.new(1, offset * 2, 1, 0) else UDim2.new(1, 0, 1, 0),
                Position = if standardSize then UDim2.new(0, -offset, 0, 0) else nil,
                radius = getClosestRadius({
                    None = arg3.Tokens.Radius.None,
                    Small = arg3.Tokens.Radius.Small,
                    Medium = arg3.Tokens.Radius.Medium,
                    Large = arg3.Tokens.Size.Size_300,
                    XLarge = arg3.Tokens.Radius.Large,
                    Circle = arg3.Tokens.Radius.Circle
                }, UDim.new(0, 8))
            }
            prop.isLoadingShimmer = createElement(var7, tbl1)
        else
            local absoluteSizeX = arg1.state.absoluteSize.X
            if standardSize and var6 then
                absoluteSizeX = maxWidth
            end

            local y = arg1.state.absoluteSize.Y - 10
            local x = absoluteSizeX - offset * 2
            if icon then
                x -= 5 + getIconSize(IconSize.Medium)
            end
            local vector2 = Vector2.new(x, y)

            local prop2 = arg1.props[Roact.Children]

            if not prop2 then
                prop2 = {
                    UIListLayout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 5)
                    }),
                    Icon = if icon then Roact.createElement(ImageSetComponent.Label, {
                        Size = UDim2.new(0, getIconSize(IconSize.Medium), 0, getIconSize(IconSize.Medium)),
                        BackgroundTransparency = 1,
                        Image = icon,
                        ImageColor3 = contentStyle3.Color,
                        ImageTransparency = contentStyle3.Transparency,
                        LayoutOrder = 1
                    })
                        or nil else nil,
                    Text = 0
                }
                local element

                if text then
                    element = Roact.createElement(
                        GenericTextLabel,
                        Cryo.Dictionary.join({
                            BackgroundTransparency = 1,
                            Text = text,
                            fontStyle = fontStyle,
                            colorStyle = colorStyle,
                            LayoutOrder = 2,
                            maxSize = vector2,
                            TextWrapped = not standardSize and nil,
                            TextTruncate = if standardSize then Enum.TextTruncate.AtEnd else nil,
                            TextXAlignment = if standardSize and icon then Enum.TextXAlignment.Left else nil
                        }, arg1.props.buttonTextOverride or {})
                    )
                        or nil
                else
                    element = nil
                end

                prop2.Text = element
            end

            prop = arg1.props[Roact.Children]

            if not prop then
                prop = { ButtonMiddleContent = 0, ButtonIcon = 0 }
                local createElement = Roact.createElement
                local str1 = "Frame"
                local tbl1 = {
                    AutomaticSize = if var6 then Enum.AutomaticSize.X else nil,
                    Size = if var6 then UDim2.fromScale(0, 1) else UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1
                }
                prop.ButtonMiddleContent = createElement(str1, tbl1, prop2)

                prop.ButtonIcon = inputIcon
                    and Roact.createElement(ImageSetComponent.Label, {
                        AnchorPoint = Vector2.new(1, 0.5),
                        Position = UDim2.new(1, -4, 0.5, 0),
                        Size = UDim2.new(0, getIconSize(IconSize.Medium), 0, getIconSize(IconSize.Medium)),
                        BackgroundTransparency = 1,
                        Image = inputIcon,
                        ImageColor3 = contentStyle4.Color,
                        ImageTransparency = contentStyle4.Transparency
                    })
                    or nil
            end
        end

        local createElement = Roact.createElement
        local var7 = Interactable
        local var8 = Cryo.Dictionary.join(arg1.props, {
            forwardedRef = Cryo.None,
            icon = Cryo.None,
            text = Cryo.None,
            inputIcon = Cryo.None,
            buttonImage = Cryo.None,
            fontStyle = Cryo.None,
            delayedInputImage = Cryo.None,
            buttonStateColorMap = Cryo.None,
            contentStateColorMap = Cryo.None,
            textStateColorMap = Cryo.None,
            iconStateColorMap = Cryo.None,
            inputIconStateColorMap = Cryo.None,
            onActivated = Cryo.None,
            isLoading = Cryo.None,
            isHoverBackgroundEnabled = Cryo.None,
            hoverImage = Cryo.None,
            isDelayedInput = Cryo.None,
            enableInputDelayed = Cryo.None,
            delayInputSeconds = Cryo.None,
            standardSize = Cryo.None,
            maxWidth = Cryo.None,
            fitContent = Cryo.None,
            buttonTextOverride = Cryo.None,
            [Roact.Children] = Cryo.None,
            Size = propsSize,
            AutomaticSize = if var6 then Enum.AutomaticSize.X else nil,
            [Roact.Ref] = arg1.props.forwardedRef,
            isDisabled = isDisabled,
            onStateChanged = arg1.onStateChanged,
            userInteractionEnabled = userInteractionEnabled,
            Image = buttonImage,
            ScaleType = Enum.ScaleType.Slice,
            ImageColor3 = contentStyle.Color,
            ImageTransparency = contentStyle.Transparency,
            BackgroundTransparency = 1,
            AutoButtonColor = false,
            [Roact.Event.Activated] = arg1.props.onActivated,
            [Roact.Change.AbsoluteSize] = arg1.onAbsoluteSizeChanged
        })
        local tbl1 = {
            UISizeConstraint = if standardSize and maxWidth then Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(maxWidth, math.huge) }) else nil,
            UIPadding = if standardSize then Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, offset), PaddingRight = UDim.new(0, offset) }) else nil,
            ButtonContent = Roact.createElement("Frame", {
                AutomaticSize = if var6 then Enum.AutomaticSize.X else nil,
                Size = if var6 then UDim2.fromScale(0, 1) else UDim2.fromScale(1, 1),
                BackgroundTransparency = 1
            }, prop),
            LoadingImage = isDelayedInput
                and Roact.createElement(ImageSetComponent.Label, {
                    Size = UDim2.new(arg2, 0, 1, 0),
                    Position = UDim2.new(1, 0, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5),
                    BackgroundTransparency = 1,
                    Image = delayedInputImage,
                    ImageColor3 = Color3.new(0, 0, 0),
                    ImageTransparency = 0.5,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = arg1.props.SliceCenter
                }),
            HoverBackground = if bool1 then Roact.createElement(HoverButtonBackground, {
                sidePadding = if standardSize then UDim.new(0, offset) else nil,
                image = hoverImage,
                sliceCenter = arg1.props.SliceCenter
            })
                or nil else nil,
            EventConnection = Roact.createElement(
                EventConnection,
                {
                    event = RunService.RobloxGuiFocusedChanged,
                    callback = arg1.onRobloxGuiFocusedChanged
                }
            )
        }
        return createElement(var7, var8, tbl1)
    end)
end

function var1.didUpdate(arg1, arg2, arg3)
    if arg1.props.enableInputDelayed ~= arg2.enableInputDelayed then
        arg1:setState({ targetLoadingProgress = if arg1.props.enableInputDelayed then 0 else 1 })
    end

    if not arg1.state.isButtonUnfocused
        and arg3.isButtonUnfocused
        and arg1.state.targetLoadingProgress == 1
        and arg1.props.enableInputDelayed
    then
        arg1:setState({ targetLoadingProgress = 0 })
    end
end

return Roact.forwardRef(function(arg1, forwardedRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardedRef = forwardedRef }))
end)
