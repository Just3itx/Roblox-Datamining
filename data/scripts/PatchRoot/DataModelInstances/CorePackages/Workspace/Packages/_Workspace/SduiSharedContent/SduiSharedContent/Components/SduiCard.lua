-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local LoadableImage = require(SduiSharedContentParent.UIBlox).App.Loading.LoadableImage
local TextSize = require(SduiSharedContentParent.TextSize)
local SignalsReact = require(SduiSharedContentParent.SignalsReact)
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)

local View = Foundation.View
local FoundationText = Foundation.Text
local Button = Foundation.Button
local useTokens = Foundation.Hooks.useTokens
local useCursor = Foundation.Hooks.useCursor
local ButtonVariant = Foundation.Enums.ButtonVariant
local InputSize = Foundation.Enums.InputSize
local CursorType = Foundation.Enums.CursorType
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance

local SharedFlags = require(SduiSharedContentParent.SharedFlags)
local FFlagFixSduiCardFocusNavScroll = SharedFlags.FFlagFixSduiCardFocusNavScroll
local FFlagLuaAppConfigureSduiCardImageScaleType = SharedFlags.FFlagLuaAppConfigureSduiCardImageScaleType
local FFlagSduiCardBackgroundClickable = SharedFlags.FFlagSduiCardBackgroundClickable

local function func1() end

return React.memo(function(tbl1) -- name: SduiCard
    local var1 = useTokens()
    local selectionImageObject = if FFlagFixSduiCardFocusNavScroll then useCursor(CursorType.RoundedRect) else nil
    local size2500 = var1.Size.Size_2500

    local var3 = SignalsReact.useSignalState(function(arg1)
        return TextSize.getTextSizeStore(arg1).getTextSizeOffset(arg1)
    end)

    local y

    if tbl1.descriptionMaxLines and tbl1.descriptionMaxLines > 0 then
        local bodyMedium = var1.Typography.BodyMedium
        local var4 = bodyMedium.FontSize + var3
        y = math.ceil(tbl1.descriptionMaxLines * var4 * bodyMedium.LineHeight)
    else
        y = nil
    end

    local yOffset, var4 = React.useState(0)
    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.Y)
    end, {})

    local selection = if FFlagFixSduiCardFocusNavScroll then React.useMemo(function()
        return {
            Selectable = true,
            SelectionImageObject = selectionImageObject,
            SelectionOrder = tbl1.selectionOrder
        }
    end, { selectionImageObject, tbl1.selectionOrder }) else nil

    local createElement = React.createElement
    local var7 = View
    local tbl2 = {
        tag = "size-full-0 row auto-y stroke-default",
        backgroundStyle = tbl1.backgroundStyle or var1.Color.Surface.Surface_100,
        cornerRadius = tbl1.cornerRadius or UDim.new(0, var1.Radius.Medium),
        selection = selection,
        onStateChanged = if FFlagFixSduiCardFocusNavScroll then func1 else nil,
        stateLayer = if FFlagFixSduiCardFocusNavScroll then (not FFlagSduiCardBackgroundClickable or tbl1.backgroundOnActivated == nil) and {
            affordance = StateLayerAffordance.None
        }
            or nil else nil,
        onActivated = if FFlagSduiCardBackgroundClickable then tbl1.backgroundOnActivated else nil,
        AnchorPoint = tbl1.anchorPoint,
        LayoutOrder = tbl1.layoutOrder,
        Position = tbl1.position,
        Size = tbl1.size,
        ZIndex = tbl1.zIndex,
        testId = tbl1.testId
    }
    local tbl3 = { ContentSection = 0, ImageSection = 0 }
    local createElement2 = React.createElement
    local var8 = View
    local tbl4 = {
        tag = "flex-between size-full-0 auto-y col gap-xsmall padding-top-large padding-bottom-large padding-left-large padding-right-small",
        Size = UDim2.new(UDim.new(1, -size2500), tbl1.size and tbl1.size.Height or UDim.new(0, 0)),
        LayoutOrder = 1,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
    local tbl5 = {
        TopContent = React.createElement(View, {
            tag = "col size-full-0 auto-y gap-xsmall",
            LayoutOrder = 1
        }, {
            Title = React.createElement(FoundationText, {
                Text = tbl1.titleText,
                tag = "size-full-0 auto-y text-align-x-left text-wrap text-label-large content-emphasis",
                LayoutOrder = 1
            }),
            Subtitle = if tbl1.descriptionText then React.createElement(FoundationText, {
                Text = tbl1.descriptionText,
                fontStyle = var1.Typography.BodyMedium,
                sizeConstraint = y and {
                    MaxSize = Vector2.new(math.huge, y)
                } or nil,
                tag = {
                    ["size-full-0 auto-y text-align-x-left text-wrap"] = true,
                    ["text-truncate-split"] = not not y
                },
                LayoutOrder = 2
            })
                or nil else nil
        }),
        CTAContainer = 0
    }
    local var9

    if tbl1.ctaText and tbl1.ctaOnActivated then
        local createElement3 = React.createElement
        local var10 = View
        local tbl6 = { tag = "auto-xy padding-top-medium", LayoutOrder = 2 }

        local tbl7 = {
            CTAButton = React.createElement(Button, {
                text = tbl1.ctaText,
                onActivated = tbl1.ctaOnActivated,
                variant = tbl1.ctaVariant or ButtonVariant.SoftEmphasis,
                size = tbl1.ctaSize or InputSize.Small,
                testId = if tbl1.testId then `{tbl1.testId}--cta` else nil
            })
        }
        var9 = createElement3(var10, tbl6, tbl7)
    else
        var9 = nil
    end

    tbl5.CTAContainer = var9
    tbl3.ContentSection = createElement2(var8, tbl4, tbl5)
    local element

    if tbl1.image then
        element = React.createElement(LoadableImage, {
            Image = tbl1.image,
            Size = UDim2.new(0, size2500, 0, yOffset),
            LayoutOrder = 2,
            BackgroundTransparency = 1,
            ImageColor3 = tbl1.imageStyle and tbl1.imageStyle.Color3 or var1.Color.Content.Emphasis.Color3,
            ImageTransparency = tbl1.imageStyle and tbl1.imageStyle.Transparency or 0,
            ScaleType = FFlagLuaAppConfigureSduiCardImageScaleType and tbl1.imageScaleType or Enum.ScaleType.Crop,
            cornerRadius = tbl1.cornerRadius or UDim.new(0, var1.Radius.Medium),
            showFailedStateWhenLoadingFailed = false,
            useShimmerAnimationWhileLoading = true
        })
    else
        element = nil
    end

    tbl3.ImageSection = element
    return createElement(var7, tbl2, tbl3)
end)
