-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:30:42Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local CardDensity = require(Foundation.Enums.CardDensity)
local CardHeaderSize = require(Foundation.Enums.CardHeaderSize)
local CardHeight = require(Foundation.Enums.CardHeight)
local CardMediaAspectRatio = require(Foundation.Enums.CardMediaAspectRatio)
local CardMediaPlacement = require(Foundation.Enums.CardMediaPlacement)
local CardVariant = require(Foundation.Enums.CardVariant)

local CardActions = require(script.Parent.Subcomponents.CardActions)
local CardHeader = require(script.Parent.Subcomponents.CardHeader)
local CardMedia = require(script.Parent.Subcomponents.CardMedia)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local useCardVariants = require(script.Parent.useCardVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local Ratio2x1 = CardMediaAspectRatio.Ratio2x1

local tbl1 = {
    [CardMediaAspectRatio.Ratio1x1] = 1,
    [CardMediaAspectRatio.Ratio5x4] = 1.25,
    [CardMediaAspectRatio.Ratio4x3] = 4 / 3,
    [CardMediaAspectRatio.Ratio3x2] = 1.5,
    [CardMediaAspectRatio.Ratio16x9] = 16 / 9,
    [CardMediaAspectRatio.Ratio2x1] = 2
}

local tbl2 = {
    variant = CardVariant.Standard,
    density = CardDensity.Default,
    height = CardHeight.Fit,
    testId = "--foundation-card"
}

local tbl3 = {
    [CardDensity.Compact] = CardHeaderSize.Small,
    [CardDensity.Default] = CardHeaderSize.Medium,
    [CardDensity.Comfortable] = CardHeaderSize.Large
}

local function resolveMedia(src)
    if typeof(src) == "string" then
        return {
            src = src,
            placement = CardMediaPlacement.End,
            width = 136,
            aspectRatio = tbl1[Ratio2x1]
        }
    end

    if typeof(src) ~= "table" then
        return nil
    end

    local placement = src.placement or CardMediaPlacement.End
    local width = if placement ~= CardMediaPlacement.End or src.width == nil then 136 else src.width
    local var3 = if placement == CardMediaPlacement.Bottom and src.aspectRatio ~= nil then src.aspectRatio else Ratio2x1
    return {
        src = src.image,
        placement = placement,
        width = width,
        aspectRatio = tbl1[var3]
    }
end

local function getBottomMediaHeight(tbl4, num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl4 == nil or tbl4.placement ~= CardMediaPlacement.Bottom then
        return 0
    end

    return math.round(num1 / tbl4.aspectRatio)
end

return React.memo(React.forwardRef(function(arg1, ref) -- name: Card
    local var1 = withDefaults(arg1, tbl2)
    local var2 = useTokens()
    local var3 = var1.headerSize or tbl3[var1.density]

    local bool1 = var1.title ~= nil or var1.description ~= nil
    local var4 = resolveMedia(var1.media)
    local bool2 = not (var4 == nil) and var4.placement == CardMediaPlacement.End
    local bool3 = var1.onOverflow ~= nil or var1.onClose ~= nil
    local isInline = bool1 and not bool2
    local isFillHeight = var1.height == CardHeight.Fill
    local bool6 = (var1.eyebrow == nil or var1.title == nil) and var1.description == nil
    local variantProps = useCardVariants(var2, var1.variant, var1.density, var3, var1.height, bool2, bool6, isInline)

    local var6, var7 = React.useState(0)
    local var8, var9 = React.useState(0)

    local onAbsoluteSizeChanged = React.useCallback(function(arg2)
        local absoluteSizeX = arg2.AbsoluteSize.X
        var7(function(arg3)
            return if arg3 == absoluteSizeX then arg3 else absoluteSizeX
        end)
    end, {})

    local var5 = React.useCallback(function(arg2)
        var9(arg2.AbsoluteSize.Y)
    end, {})

    local element = if bool3 then React.createElement(CardActions, {
        testId = var1.testId,
        variantProps = variantProps,
        onOverflow = var1.onOverflow,
        onClose = var1.onClose,
        overflowRef = var1.overflowRef,
        isOverMedia = bool2,
        isInline = isInline
    }) else nil
    local bottomHeight = getBottomMediaHeight(var4, var6)
    local y = var8 + bottomHeight

    local createElement = React.createElement
    local var12 = View
    local var13 = withCommonProps(var1, {
        tag = variantProps.container.tag,
        sizeConstraint = isFillHeight and {
            MinSize = Vector2.new(0, y)
        } or nil,
        onActivated = var1.onActivated,
        ref = ref
    })
    local tbl4 = { Body = 0, Actions = 0 }
    local createElement2 = React.createElement
    local var14 = View
    local tbl5 = {
        tag = variantProps.body.tag,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged
    }
    local tbl6 = { Content = 0, Media = 0 }
    local createElement3 = React.createElement
    local var15 = View
    local tbl7 = {
        tag = variantProps.content.tag,
        onAbsoluteSizeChanged = var5,
        LayoutOrder = 1
    }
    local tbl8 = { Header = 0, Children = 0 }
    local element2

    if bool1 then
        element2 = React.createElement(CardHeader, {
            testId = var1.testId,
            variantProps = variantProps,
            eyebrow = var1.eyebrow,
            icon = var1.icon,
            title = var1.title,
            description = var1.description,
            descriptionLineClamp = if var1.lineClamp then var1.lineClamp.description else nil,
            actions = if isInline then element else nil
        })
    else
        element2 = nil
    end

    tbl8.Header = element2

    tbl8.Children = if var1.children then React.createElement(
        View,
        {
            tag = variantProps.children.tag,
            LayoutOrder = 2,
            testId = `{var1.testId}--content`
        },
        var1.children
    ) else nil
    tbl6.Content = createElement3(var15, tbl7, tbl8)

    tbl6.Media = if var4 then React.createElement(CardMedia, {
        image = var4.src,
        width = var4.width,
        isEnd = bool2,
        isFillHeight = isFillHeight,
        bottomHeight = bottomHeight,
        tag = variantProps.media.tag,
        testId = var1.testId
    }) else nil
    tbl4.Body = createElement2(var14, tbl5, tbl6)

    if isInline then
        element = nil
    end

    tbl4.Actions = element
    return createElement(var12, var13, tbl4)
end))
