-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ContentProvider = game:GetService("ContentProvider")
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local Responsive = require(ServerDrivenUiParent.Responsive)
local GetInputModeStore = Responsive.GetInputModeStore
local Foundation = require(ServerDrivenUiParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local UIBlox = require(ServerDrivenUiParent.UIBlox)
local Cryo = require(ServerDrivenUiParent.Cryo)
local LoadableImage = UIBlox.App.Loading.LoadableImage
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local TextSize = require(ServerDrivenUiParent.TextSize)
local _SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)

local HoldDetector = require(ServerDrivenUiParent.HoldToPlay).HoldDetector
local SduiDefaultTileImage = require(script.Parent.SduiDefaultTileImage)
local useTileHoldAction = require(script.Parent.useTileHoldAction)

local FFlagSduiTileDisableLegacyHover = require(ServerDrivenUi.Flags).FFlagSduiTileDisableLegacyHover
local FFlagSduiGameTileEnableHoverInVR = require(ServerDrivenUiParent.SharedFlags).FFlagSduiGameTileEnableHoverInVR

local FFlagLuaAppHomePageFirstImageLoadObserver = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppHomePageFirstImageLoadObserver
local FFlagSduiTileThumbnailPadding = require(ServerDrivenUiParent.SharedFlags).FFlagSduiTileThumbnailPadding
local FFlagLuaAppSduiVideoThumbnail = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiVideoThumbnail
local FFlagLuaAppSduiGameTileFeedback = require(ServerDrivenUiParent.SharedFlags).FFlagLuaAppSduiGameTileFeedback

local SduiTileInsetImage = require(script.Parent.SduiTileInsetImage)

local tbl1 = {}

local function isRobloxContentUrl(image: string): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return string.match(image, "^rbxthumb://") ~= nil or string.match(image, "^rbxasset") ~= nil
end

local function maybeLayoutForButton(tbl2, rightContent, num1: number, offset: number, bool1: boolean?)
    if rightContent == nil or bool1 then
        return tbl2
    end

    local tbl3 = {
        Content = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y
            },
            {
                UIListLayout = React.createElement("UIListLayout", {
                    HorizontalFlex = Enum.UIFlexAlignment.None,
                    SortOrder = Enum.SortOrder.Name,
                    FillDirection = Enum.FillDirection.Horizontal,
                    Padding = UDim.new(0, num1 or 0),
                    HorizontalAlignment = Enum.HorizontalAlignment.Left,
                    VerticalAlignment = Enum.VerticalAlignment.Bottom
                }),
                UIPadding = if offset > 0 then React.createElement(
                    "UIPadding",
                    {
                        PaddingLeft = UDim.new(0, offset),
                        PaddingRight = UDim.new(0, offset),
                        PaddingBottom = UDim.new(0, offset)
                    }
                ) else nil,
                LeftContent = React.createElement(
                    "Frame",
                    {
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Size = UDim2.new(0, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.XY
                    },
                    Cryo.Dictionary.join({ UIFlexItem = React.createElement("UIFlexItem", { FlexMode = Enum.UIFlexMode.Shrink }) }, tbl2)
                ),
                RightContent = rightContent
            }
        )
    }
    return tbl3
end

return React.memo(function(tbl2) -- name: SduiTile
    local layoutOrder = tbl2.layoutOrder
    local anchorPoint = tbl2.anchorPoint
    local automaticSize = tbl2.automaticSize
    local size = tbl2.size
    local zIndex = tbl2.zIndex
    local position = tbl2.position
    local backgroundColor3 = tbl2.backgroundColor3
    local selectionOrder = tbl2.selectionOrder

    React.useLayoutEffect(function()
        local image = tbl2.image

        if not image or not isRobloxContentUrl(image) then
            return
        end

        task.spawn(function()
            ContentProvider:PreloadAsync({ image })
        end)
    end, { tbl2.image })

    local var1 = TextSize.getTextSizeStore(false).getTextSizeOffset(false)

    local var2 = useTokens()

    local aspectRatio = if tbl2.imageAspectRatio and tbl2.imageAspectRatio == 0 then 1 else tbl2.imageAspectRatio or 1

    local titleLines = tbl2.titleLines or 1
    local cardCornerRadius = tbl2.cornerRadius or var2.Radius.Medium

    local var4 = tbl2.titleFont or var2.Typography.TitleMedium
    local emphasis = var2.Color.Content.Emphasis
    local yOffset = math.ceil(titleLines * (var4.LineHeight * var4.FontSize + var1))

    local bool1 = tbl2.ctaButtonComponent ~= nil

    local var5, var6 = React.useState(false)

    local isContained = tbl2.isContained
    local var7, color3

    if tbl2.backgroundStyle ~= nil then
        var7 = tbl2.backgroundStyle

        color3 = var7.Color3
    else
        var7 = var2.Color.Surface.Surface_100
        color3 = backgroundColor3 or var7.Color3
    end

    local offset2 = tbl2.containmentPadding or var2.Padding.Small

    local var8, var9 = React.useState(false)

    if tbl2.isHovered ~= nil then
        var8 = tbl2.isHovered
    end
    local var10 = React.useCallback(function()
        if (if FFlagSduiGameTileEnableHoverInVR then GetInputModeStore(false).getPreferredInputType(false) else GetInputModeStore(false).getLastInputType(false)) ~= Responsive.Input.Pointer then
            return
        end

        var9(true)
        if tbl2.onMouseEnter then
            tbl2.onMouseEnter()
        elseif tbl2.setCustomConditionState then
            tbl2.setCustomConditionState("hovered", true)
        end
    end, { tbl2.onMouseEnter, tbl2.setCustomConditionState })

    local var11 = React.useCallback(function()
        var9(false)
        if tbl2.onMouseLeave then
            tbl2.onMouseLeave()
        elseif tbl2.setCustomConditionState then
            tbl2.setCustomConditionState("hovered", false)
        end
    end, { tbl2.onMouseLeave, tbl2.setCustomConditionState })

    local var12 = React.useCallback(function()
        if tbl2.onSelectionGained then
            tbl2.onSelectionGained()
        elseif tbl2.setCustomConditionState then
            tbl2.setCustomConditionState("selected", true)
        end
    end, { tbl2.onSelectionGained, tbl2.setCustomConditionState })

    local var13 = React.useCallback(function()
        if tbl2.onSelectionLost then
            tbl2.onSelectionLost()
        elseif tbl2.setCustomConditionState then
            tbl2.setCustomConditionState("selected", false)
        end
    end, { tbl2.onSelectionLost, tbl2.setCustomConditionState })

    local var14 = useTileHoldAction(tbl2.holdActionConfig, tbl2.setGuiObject, tbl2.onActivated)
    local onGuiStateChanged, onActivated, var15

    if FFlagLuaAppSduiGameTileFeedback then
        local var16 = React.useRef(false)

        onGuiStateChanged = React.useCallback(function(...)
            var16.current = false

            if tbl2.onGuiStateChanged then
                tbl2.onGuiStateChanged(...)
            end
        end, { tbl2.onGuiStateChanged })

        onActivated = React.useCallback(function()
            if var16.current then
                var16.current = false
                return
            end

            if var14 then
                var14.onActivated()
            elseif tbl2.onActivated then
                tbl2.onActivated()
            end
        end, { var14, tbl2.onActivated })

        var15 = React.useCallback(function()
            if not tbl2.onTouchLongPress or tbl2.isDisabled then
                return
            end

            local current = var16.current
            var16.current = true
            if not current then
                tbl2.onTouchLongPress()
            end
        end, { tbl2.onTouchLongPress, tbl2.isDisabled })
    else
        onGuiStateChanged = nil
        onActivated = nil
        var15 = nil
    end

    local var16, var17, var18, offset3

    if FFlagSduiTileDisableLegacyHover or not tbl2.enableLegacyHoverState then
        var16 = nil
        var17 = nil
        var18 = nil
        offset3 = nil
    else
        offset3 = tbl2.containmentPadding or var2.Padding.Medium
        if var8 then
            var16 = UDim2.new(1, offset3 * 2, 1, offset3 * 2)
        else
            var16 = nil
        end

        if var8 then
            var17 = UDim2.new(0, -offset3, 0, -offset3)
            var18 = var8
        else
            var18 = var8
            var17 = nil
        end
    end
    local transparency = var7.Transparency
    local element = if tbl2.imagePadding == nil then nil else React.createElement(SduiTileInsetImage, {
        image = tbl2.image,
        imageComponent = tbl2.imageComponent,
        imagePadding = tbl2.imagePadding,
        imageCornerRadius = tbl2.imageCornerRadius or 1000,
        cardCornerRadius = cardCornerRadius,
        isContained = isContained,
        backgroundStyle = tbl2.thumbnailBackgroundStyle
    })
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl3 = {
        [React.Tag] = if tbl2.testId then `data-testid={tbl2.testId}` else nil,
        ref = if var14 then var14.tileRef else tbl2.setGuiObject,
        Size = var16 or size or UDim2.new(1, 0, 1, 0),
        Position = var17 or position,
        AnchorPoint = anchorPoint,
        LayoutOrder = layoutOrder,
        ZIndex = zIndex,
        SelectionImageObject = tbl2.sduiContext.dependencies.cursors.tileCursor,
        Active = if FFlagLuaAppSduiGameTileFeedback then not tbl2.isDisabled else tbl2.isDisabled,
        Selectable = if FFlagLuaAppSduiGameTileFeedback then tbl2.selectable else nil
    }
    local guiState = React.Change.GuiState

    if not FFlagLuaAppSduiGameTileFeedback then
        onGuiStateChanged = tbl2.onGuiStateChanged
    end

    tbl3[guiState] = onGuiStateChanged

    local activated = React.Event.Activated

    if not FFlagLuaAppSduiGameTileFeedback then
        if var14 then
            onActivated = var14.onActivated
        else
            onActivated = tbl2.onActivated
        end
    end

    tbl3[activated] = onActivated

    tbl3[React.Event.MouseEnter] = var10
    tbl3[React.Event.MouseLeave] = var11
    tbl3[React.Event.SelectionGained] = var12
    tbl3[React.Event.SelectionLost] = var13
    local touchLongPress = React.Event.TouchLongPress

    if not (FFlagLuaAppSduiGameTileFeedback and tbl2.onTouchLongPress) then
        var15 = nil
    end

    tbl3[touchLongPress] = var15

    tbl3.ClipsDescendants = false
    tbl3.Text = ""
    tbl3.TextTransparency = 1
    if not isContained then
        transparency = if var18 then transparency else 1
    end

    tbl3.BackgroundTransparency = transparency
    tbl3.AutoButtonColor = false
    tbl3.AutomaticSize = automaticSize or Enum.AutomaticSize.Y
    tbl3.BackgroundColor3 = color3
    tbl3.BorderSizePixel = 0
    tbl3.SelectionOrder = selectionOrder
    local tbl4 = {
        UIPadding = if FFlagSduiTileDisableLegacyHover or not var18 then nil else React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, offset3),
                PaddingRight = UDim.new(0, offset3),
                PaddingTop = UDim.new(0, offset3)
            }
        ),
        UICorner = if isContained or not FFlagSduiTileDisableLegacyHover and var18 then React.createElement("UICorner", { CornerRadius = UDim.new(0, cardCornerRadius) }) else nil,
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, var2.Gap.Medium),
            HorizontalAlignment = if FFlagSduiTileThumbnailPadding then Enum.HorizontalAlignment.Center else nil
        }),
        ImageFrame = 0,
        BottomContent = 0,
        ExtraChildren = 0,
        HoldDetector = 0
    }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl5 = {
        [React.Tag] = if FFlagLuaAppHomePageFirstImageLoadObserver then "observed-image" else nil,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = if FFlagSduiTileThumbnailPadding and tbl2.thumbnailPadding ~= nil then UDim2.new(1, tbl2.thumbnailPadding * -2, 1 / aspectRatio, 0) else UDim2.new(1, 0, 1 / aspectRatio, 0),
        ZIndex = -1,
        LayoutOrder = 1,
        ClipsDescendants = if isContained then true else nil,
        SizeConstraint = Enum.SizeConstraint.RelativeXX
    }
    local tbl6 = {
        BackgroundImage = 0,
        Thumbnail = 0,
        UIAspectRatioConstraint = 0,
        ThumbnailOverlay = 0,
        OverflowMenu = 0,
        HoverOverlay = 0
    }
    local var19

    if tbl2.backgroundImageComponent then
        var19 = tbl2.backgroundImageComponent
    elseif tbl2.backgroundImage then
        var19 = React.createElement(
            ImageSetLabel,
            {
                Size = UDim2.new(1, 0, 1, 0),
                Image = tbl2.backgroundImage,
                BackgroundTransparency = 1,
                ZIndex = -3
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, cardCornerRadius) })
            }
        )
    else
        var19 = nil
    end

    tbl6.BackgroundImage = var19

    if not element then
        if tbl2.imageComponent then
            element = tbl2.imageComponent
        elseif tbl2.image then
            if FFlagLuaAppSduiVideoThumbnail then
                element = React.createElement(SduiDefaultTileImage, {
                    image = tbl2.image,
                    thumbnailBackgroundStyle = tbl2.thumbnailBackgroundStyle,
                    isContained = isContained,
                    cardCornerRadius = cardCornerRadius
                })
            else
                element = React.createElement(LoadableImage, {
                    BackgroundColor3 = if tbl2.thumbnailBackgroundStyle then tbl2.thumbnailBackgroundStyle.Color3 or nil else nil,
                    BackgroundTransparency = tbl2.thumbnailBackgroundStyle and tbl2.thumbnailBackgroundStyle.Transparency or 1,
                    Image = tbl2.image,
                    Size = UDim2.new(1, 0, 1, if isContained then cardCornerRadius else 0),
                    cornerRadius = UDim.new(0, cardCornerRadius),
                    showFailedStateWhenLoadingFailed = true,
                    useShimmerAnimationWhileLoading = true,
                    ZIndex = -2,
                    ScaleType = if isContained then Enum.ScaleType.Tile else nil,
                    TileSize = if isContained then UDim2.new(1, 0, 1, -cardCornerRadius) else nil
                })
            end
        else
            element = nil
        end
    end

    tbl6.Thumbnail = element

    tbl6.UIAspectRatioConstraint = React.createElement("UIAspectRatioConstraint", { AspectRatio = aspectRatio or 1 })

    tbl6.ThumbnailOverlay = tbl2.thumbnailOverlayComponent
    tbl6.OverflowMenu = if FFlagLuaAppSduiGameTileFeedback then tbl2.thumbnailOverflowMenuComponent else nil
    local element2

    if var8 and not var5 then
        element2 = React.createElement(
            "Frame",
            {
                BackgroundColor3 = var2.Color.State.Hover.Color3,
                BackgroundTransparency = var2.Color.State.Hover.Transparency,
                Size = UDim2.new(1, 0, 1, if isContained then cardCornerRadius else 0)
            },
            {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, cardCornerRadius) })
            }
        )
    else
        element2 = nil
    end

    tbl6.HoverOverlay = element2
    tbl4.ImageFrame = createElement2(str2, tbl5, tbl6)

    local createElement3 = React.createElement
    local str3 = "Frame"
    local tbl7 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = 2,
        ZIndex = 1
    }

    local func1 = maybeLayoutForButton
    local tbl8 = {
        UIPadding = if isContained and not bool1 then React.createElement(
            "UIPadding",
            {
                PaddingLeft = UDim.new(0, offset2),
                PaddingRight = UDim.new(0, offset2),
                PaddingBottom = UDim.new(0, offset2)
            }
        ) else nil,
        UIListLayout = React.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.Name,
            HorizontalFlex = Enum.UIFlexAlignment.Fill
        })
    }
    local var20

    if tbl2.titleComponent then
        var20 = tbl2.titleComponent
    elseif tbl2.titleText and tbl2.titleText ~= "" then
        var20 = React.createElement("TextLabel", {
            Size = UDim2.new(1, 0, 0, yOffset),
            BackgroundTransparency = 1,
            Text = tbl2.titleText,
            FontFace = normalizeFontFace(var4.Font),
            TextSize = var4.FontSize,
            TextTransparency = emphasis.Transparency,
            TextColor3 = emphasis.Color3,
            TextWrapped = titleLines > 1,
            TextTruncate = Enum.TextTruncate.SplitWord,
            TextXAlignment = tbl2.titleTextXAlignment or Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            AutomaticSize = if bool1 then Enum.AutomaticSize.X or nil else nil
        })
    else
        var20 = nil
    end

    tbl8["1_Title"] = var20

    tbl8["2_Footer"] = if tbl2.footerComponent then tbl2.footerComponent else nil
    local var21

    if tbl2.bottomButtonComponent then
        local createElement4 = React.createElement
        local tbl9 = {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0)
        }

        tbl9[React.Event.MouseEnter] = function()
            if var6 then
                var6(true)
            end
        end
        tbl9[React.Event.MouseLeave] = function()
            if var6 then
                var6(false)
            end
        end

        var21 = createElement4("Frame", tbl9, {
            UIPadding = React.createElement("UIPadding", { PaddingTop = UDim.new(0, tbl2.bottomButtonGap or var2.Gap.Small) }),
            Content = tbl2.bottomButtonComponent
        })
    else
        var21 = nil
    end

    tbl8["3_BottomButton"] = var21

    tbl8.Z_3_ExtraOverflow = if FFlagSduiTileDisableLegacyHover or not (var18 and tbl2.renderLegacyHoverState) then nil else React.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 0, 0),
            ZIndex = -1
        },
        {
            ExtraOverflow = tbl2.renderLegacyHoverState(offset3, color3, cardCornerRadius)
        }
    )
    tbl4.BottomContent = createElement3(
        str3,
        tbl7,
        (func1(tbl8, tbl2.ctaButtonComponent, var2.Gap.Small, if isContained then offset2 else 0, var18))
    )

    tbl4.ExtraChildren = if tbl2.focusNavActionsComponent or tbl2.children then React.createElement(
        React.Fragment,
        nil,
        Cryo.Dictionary.join(tbl2.children or tbl1, { focusNavActions = tbl2.focusNavActionsComponent })
    ) else nil

    tbl4.HoldDetector = if var14 and var14.holdDetectorProps then React.createElement(HoldDetector, var14.holdDetectorProps) else nil
    return createElement(str1, tbl3, tbl4)
end)
