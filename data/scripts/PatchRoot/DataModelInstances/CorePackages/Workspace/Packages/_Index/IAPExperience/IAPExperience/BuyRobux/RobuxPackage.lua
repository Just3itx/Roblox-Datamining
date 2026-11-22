-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LocalizationService = game:GetService("LocalizationService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")

local Roact = require(scriptParentParentParent.Roact)
local React = require(scriptParentParentParent.React)

local UIBlox = require(scriptParentParentParent.UIBlox)
local Foundation = require(scriptParentParentParent.Foundation)
local Skeleton = Foundation.Skeleton
local useTokens = Foundation.Hooks.useTokens

local useStyleMetadata = UIBlox.Core.Style.useStyleMetadata
local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local withStyle = UIBlox.Core.Style.withStyle
local ImageSetButton = UIBlox.Core.ImageSet.ImageSetButton
local useCursor = UIBlox.App.SelectionCursor.useCursor

local RoactGamepad = require(scriptParentParentParent.RoactGamepad)

local RoactFitComponents = require(scriptParentParentParent.RoactFitComponents)
local FitFrameHorizontal = RoactFitComponents.FitFrameHorizontal
local FitTextLabel = RoactFitComponents.FitTextLabel

local MultiTextLocalizer = require(scriptParentParent.Locale.MultiTextLocalizer)
local FFlagBuyRobuxPageFitToViewport = require(scriptParentParent.Flags.FFlagBuyRobuxPageFitToViewport)
local formatNumber = require(scriptParentParent.Utility.formatNumber)

local iconsCommonRobux = Images["icons/common/robux"]

local vector2 = Vector2.new(397, 440)

local tbl1 = ({})
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function renderWithProviders(tbl2, tbl3, arg1, selectionImageObject, _, arg2, arg3)
    local fitToViewport = FFlagBuyRobuxPageFitToViewport and tbl2.fitToViewport
    if tbl2.robuxAmount == nil then
        return Roact.createElement("Frame", {
            BackgroundTransparency = 1,
            Size = if fitToViewport then UDim2.fromScale(0, 0.9) else UDim2.new(0, tbl2.scale * 404, 0, tbl2.scale * 448),
            LayoutOrder = if fitToViewport then tbl2.layoutOrder else nil
        }, {
            AspectRatio = if fitToViewport then Roact.createElement(
                "UIAspectRatioConstraint",
                {
                    AspectRatio = 101 / 112,
                    AspectType = Enum.AspectType.ScaleWithParentSize,
                    DominantAxis = Enum.DominantAxis.Height
                }
            ) else nil,
            SizeConstraint = fitToViewport and Roact.createElement("UISizeConstraint", { MaxSize = vector2 }),
            ShimmerPanel = Roact.createElement(Skeleton, { Size = UDim2.new(1, 0, 1, 0) })
        })
    end

    local theme = arg1.Theme
    local font = arg1.Font

    local textSize = tbl2.scale * 64
    local string2 = formatNumber(LocalizationService.RobloxLocaleId, tbl2.robuxAmount)
    local textSizeX

    if fitToViewport then
        local str1 = `{string2}|{textSize}`
        textSizeX = tbl1[str1]
        if textSizeX == nil then
            textSizeX = TextService:GetTextSize(string2, textSize, font.Title.Font, Vector2.new(10000, 10000)).X
            tbl1[str1] = textSizeX
        end
    else
        textSizeX = 0
    end

    local color3 = arg2.Color.Surface.Surface_100.Color3

    if tbl2.selected then
        color3 = color3:Lerp(arg2.Color.Surface.Surface_200.Color3, 0.5)
    end

    local createElement = Roact.createElement
    local var2 = RoactGamepad.Focusable[ImageSetButton]

    local tbl4 = {
        LayoutOrder = nil,
        LayoutOrder = nil,
        LayoutOrder = nil,
        LayoutOrder = nil,
        LayoutOrder = nil,
        LayoutOrder = tbl2.layoutOrder,
        BackgroundColor3 = theme.UIEmphasis.Color,
        BackgroundTransparency = theme.UIEmphasis.Transparency,
        Size = if fitToViewport then UDim2.fromScale(0, 0.9) else UDim2.new(0, tbl2.scale * 404, 0, tbl2.scale * 448),
        Image = nil,
        SelectionImageObject = selectionImageObject,
        [Roact.Ref] = tbl2.forwardRef,
        NextSelectionUp = nil,
        NextSelectionDown = nil,
        NextSelectionLeft = tbl2.nextSelectionLeft,
        NextSelectionRight = tbl2.nextSelectionRight,
        inputBindings = {
            Activated = if tbl2.onActivated == nil then nil else RoactGamepad.Input.onBegin(Enum.KeyCode.ButtonA, function()
                tbl2.onActivated(tbl2.packageId)
            end)
        }
    }
    tbl4[Roact.Event.Activated] = function()
        tbl2.onActivated(tbl2.packageId)
    end
    tbl4[Roact.Event.MouseMoved] = function()
        tbl2.onHover(tbl2.forwardRef, true)
    end
    tbl4[Roact.Event.MouseEnter] = function()
        tbl2.onHover(tbl2.forwardRef, true)
    end
    tbl4[Roact.Event.MouseLeave] = function()
        tbl2.onHover(tbl2.forwardRef, false)
    end
    tbl4[Roact.Event.SelectionGained] = function()
        tbl2.onSelect(tbl2.forwardRef)
    end
    local tbl5 = {
        AspectRatio = if fitToViewport then Roact.createElement(
            "UIAspectRatioConstraint",
            {
                AspectRatio = 101 / 112,
                AspectType = Enum.AspectType.ScaleWithParentSize,
                DominantAxis = Enum.DominantAxis.Height
            }
        ) else nil,
        SizeConstraint = fitToViewport and Roact.createElement("UISizeConstraint", { MaxSize = vector2 }),
        Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        Outline = 0
    }
    local createElement2 = Roact.createElement
    local str1 = "Frame"
    local tbl6 = {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        BackgroundColor3 = color3,
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        Size = UDim2.new(1, -3, 1, -3)
    }
    local tbl7 = {
        Corner = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        MiddleContent = 0
    }
    local createElement3 = Roact.createElement
    local str2 = "Frame"
    local tbl8 = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0)
    }
    local tbl9 = {
        [1] = nil,
        [1] = nil,
        [1] = nil,
        [1] = nil,
        Padding = Roact.createElement("UIPadding", {
            PaddingTop = if fitToViewport then UDim.new(0.05, 0) else UDim.new(0, tbl2.scale * 24),
            PaddingBottom = if fitToViewport then UDim.new(0.05, 0) else nil
        }),
        (Roact.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, if fitToViewport then 10 else tbl2.scale * 17.5)
        }))
    }

    local createElement4 = Roact.createElement
    local str3 = "Frame"
    local tbl10 = {
        LayoutOrder = 1,
        Size = if fitToViewport then UDim2.fromScale(1, 0.5) else UDim2.fromOffset(tbl2.scale * 192, tbl2.scale * 192),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1
    }
    local tbl11 = {
        AspectRatio = fitToViewport
            and Roact.createElement(
                "UIAspectRatioConstraint",
                {
                    AspectRatio = 1,
                    AspectType = Enum.AspectType.FitWithinMaxSize,
                    DominantAxis = Enum.DominantAxis.Width
                }
            ),
        FlexItem = fitToViewport and Roact.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill }),
        RobuxImage = 0
    }
    local createElement5 = Roact.createElement
    local var3 = ImageSetLabel
    local tbl12 = {}
    local var4

    if fitToViewport then
        var4 = UDim2.fromScale(1, 1)
    elseif tbl2.selected then
        var4 = UDim2.fromOffset(tbl2.scale * 192 * 1.6, tbl2.scale * 192 * 1.6)
    else
        var4 = UDim2.fromOffset(tbl2.scale * 192, tbl2.scale * 192)
    end

    tbl12.Size = var4

    local ref = Roact.Ref

    if not fitToViewport then
        arg3 = nil
    end

    tbl12[ref] = arg3
    tbl12.Position = if tbl2.selected and not fitToViewport then UDim2.new(0.5, 0, 0.3, 0) else UDim2.new(0.5, 0, 0.5, 0)

    tbl12.AnchorPoint = Vector2.new(0.5, 0.5)

    tbl12.BackgroundTransparency = 1
    tbl12.Image = tbl2.robuxImage
    tbl12.ImageTransparency = 0
    tbl11.RobuxImage = createElement5(var3, tbl12)
    tbl9.RobuxImageFrame = createElement4(str3, tbl10, tbl11)

    local createElement6 = Roact.createElement
    local var5 = if fitToViewport then "Frame" else FitFrameHorizontal
    local tbl13 = {
        LayoutOrder = 2,
        AnchorPoint = Vector2.new(0.5, 0.5),
        height = if fitToViewport then nil else UDim.new(0, textSize),
        Size = if fitToViewport then UDim2.fromScale(1, 0.18) else nil,
        contentPadding = if fitToViewport then nil else UDim.new(0, 0),
        FillDirection = if fitToViewport then nil else Enum.FillDirection.Horizontal,
        VerticalAlignment = if fitToViewport then nil else Enum.VerticalAlignment.Center,
        BackgroundTransparency = 1
    }

    local tbl14 = {
        SizeConstraint = fitToViewport
            and Roact.createElement("UISizeConstraint", { MinSize = Vector2.new(0, 40), MaxSize = Vector2.new(math.huge, 64) }),
        Layout = fitToViewport
            and Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
        Icon = Roact.createElement(
            ImageSetLabel,
            {
                LayoutOrder = 1,
                BackgroundTransparency = 1,
                Size = if fitToViewport then UDim2.fromScale(0, 1) else UDim2.new(0, textSize, 0, textSize),
                Image = iconsCommonRobux,
                ImageColor3 = theme.TextEmphasis.Color,
                ImageTransparency = theme.TextEmphasis.Transparency
            },
            fitToViewport
                and {
                    AspectRatio = Roact.createElement(
                        "UIAspectRatioConstraint",
                        {
                            AspectRatio = 1,
                            AspectType = Enum.AspectType.ScaleWithParentSize,
                            DominantAxis = Enum.DominantAxis.Height
                        }
                    )
                }
                or nil
        ),
        RobuxAmountText = 0
    }

    local createElement7 = Roact.createElement
    local var6 = if fitToViewport then "TextLabel" else FitTextLabel
    local tbl15 = {
        LayoutOrder = 2,
        width = if fitToViewport then nil else FitTextLabel.Width.FitToText,
        Size = if fitToViewport then UDim2.fromScale(0, 1) else nil,
        TextScaled = if fitToViewport then true else nil,
        Text = 0,
        Font = 0,
        TextColor3 = 0,
        TextTransparency = 0,
        TextSize = 0,
        BackgroundTransparency = 1
    }

    if fitToViewport then
        string2 = string.gsub(string2, " ", " ")
    end

    tbl15.Text = string2

    tbl15.Font = font.Title.Font
    tbl15.TextColor3 = theme.TextEmphasis.Color
    tbl15.TextTransparency = theme.TextEmphasis.Transparency
    tbl15.TextSize = textSize
    tbl14.RobuxAmountText = createElement7(var6, tbl15, {
        AspectRatio = fitToViewport
            and Roact.createElement("UIAspectRatioConstraint", {
                AspectRatio = textSizeX * 1.04 / textSize,
                AspectType = Enum.AspectType.ScaleWithParentSize,
                DominantAxis = Enum.DominantAxis.Height
            })
    })
    tbl9.RobuxAmount = createElement6(var5, tbl13, tbl14)

    tbl9.CurrencyAmmountText = Roact.createElement(if fitToViewport then "TextLabel" else FitTextLabel, {
        LayoutOrder = 3,
        AnchorPoint = Vector2.new(0.5, 0.5),
        width = if fitToViewport then nil else FitTextLabel.Width.FitToText,
        Size = if fitToViewport then UDim2.fromScale(1, 0.18) else nil,
        TextScaled = if fitToViewport then true else nil,
        TextWrapped = if fitToViewport then true else nil,
        Text = tbl2.currencyAmountStr,
        Font = font.Header1.Font,
        TextColor3 = theme.TextEmphasis.Color,
        TextTransparency = theme.TextEmphasis.Transparency,
        TextSize = tbl2.scale * 32,
        BackgroundTransparency = 1
    }, {
        SizeConstraint = fitToViewport
            and Roact.createElement("UISizeConstraint", { MinSize = Vector2.new(0, 40), MaxSize = Vector2.new(math.huge, 64) }),
        Padding = fitToViewport
            and Roact.createElement("UIPadding", { PaddingTop = UDim.new(0.25, 0), PaddingBottom = UDim.new(0.25, 0) })
    })
    local element

    if fitToViewport or tbl2.robuxMoreAmount then
        element = Roact.createElement(if fitToViewport then "TextLabel" else FitTextLabel, {
            LayoutOrder = 4,
            AnchorPoint = Vector2.new(0.5, 0.5),
            width = if fitToViewport then nil else FitTextLabel.Width.FitToText,
            Size = if fitToViewport then UDim2.fromScale(1, 0.09) else nil,
            TextScaled = if fitToViewport then true else nil,
            TextWrapped = if fitToViewport then true else nil,
            Text = if fitToViewport and tbl2.robuxMoreAmount == nil then "" else tbl3.moreRobux,
            Font = font.Header2.Font,
            TextColor3 = theme.TextEmphasis.Color,
            TextTransparency = theme.TextEmphasis.Transparency,
            TextSize = tbl2.scale * 32,
            BackgroundTransparency = 1
        }, {
            SizeConstraint = fitToViewport
                and Roact.createElement("UISizeConstraint", { MinSize = Vector2.new(0, 22), MaxSize = Vector2.new(math.huge, 40) }),
            Padding = fitToViewport and Roact.createElement("UIPadding", { PaddingTop = UDim.new(0.1, 0), PaddingBottom = UDim.new(0.1, 0) }),
            Gradient = Roact.createElement("UIGradient", {
                Rotation = 0,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 251, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(243, 185, 34)) })
            })
        })
            or nil
    else
        element = nil
    end

    tbl9.MoreText = element
    tbl7.MiddleContent = createElement3(str2, tbl8, tbl9)
    tbl5.Outline = createElement2(str1, tbl6, tbl7)
    return createElement(var2, tbl4, tbl5)
end

return function(tbl2)
    local selectionImageObject = useCursor(UDim.new(0, 8))
    local var1 = useTokens()

    local themeName = useStyleMetadata().ThemeName

    local var2 = React.useRef(nil)
    local fitToViewport = FFlagBuyRobuxPageFitToViewport and tbl2.fitToViewport
    React.useEffect(function()
        local current = var2.current
        if not fitToViewport or current == nil then
            return nil
        end
        local num1 = if tbl2.selected then 1.2 else 1
        local uDim2 = UDim2.fromScale(num1, num1)
        if current.Size == uDim2 then
            return nil
        end
        local tween = TweenService:Create(current, tweenInfo, { Size = uDim2 })
        tween:Play()
        return function()
            tween:Cancel()
        end
    end, { tbl2.selected, fitToViewport, tbl2.robuxAmount ~= nil })

    return Roact.createElement(MultiTextLocalizer, {
        keys = {
            moreRobux = {
                key = "IAPExperience.BuyRobux.Text.MoreRobux2",
                params = {
                    robux = formatNumber(LocalizationService.RobloxLocaleId, tbl2.robuxMoreAmount or 0)
                }
            }
        },
        render = function(tbl3)
            return withStyle(function(arg1)
                if tbl2.scale == nil then
                    tbl2.scale = 0.65
                end
                return renderWithProviders(tbl2, tbl3, arg1, selectionImageObject, themeName, var1, var2)
            end)
        end
    })
end
