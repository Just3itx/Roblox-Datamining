-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T17:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCarousel = script:FindFirstAncestor("SocialCarousel")
local SocialCarouselParent = SocialCarousel.Parent
local Foundation = require(SocialCarouselParent.Foundation)
local GetTextSize = require(SocialCarouselParent.Style).GetTextSize
local React = require(SocialCarouselParent.React)

local Enums = Foundation.Enums
local Image = Foundation.Image
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local StatusIndicator = Foundation.StatusIndicator
local StatusIndicatorVariant = Foundation.Enums.StatusIndicatorVariant
local Radius = Foundation.Enums.Radius

local FFlagSocialCarouselShowLoadingSkeleton = require(SocialCarousel.Flags.FFlagSocialCarouselShowLoadingSkeleton)
local FFlagSocialCarouselUnselectableSkeleton = require(SocialCarousel.Flags.FFlagSocialCarouselUnselectableSkeleton)

local FFlagSocialCarouselRemoveStrokeForAddFriends = require(SocialCarousel.Flags.FFlagSocialCarouselRemoveStrokeForAddFriends)
local FFlagSocialCarouselXSmallTileText = require(SocialCarousel.Flags.FFlagSocialCarouselXSmallTileText)
local FFlagSocialCarouselXXSmallTiles = require(SocialCarousel.Flags.FFlagSocialCarouselXXSmallTiles)
local useXSmallTileTypography = require(SocialCarousel.Hooks.useXSmallTileTypography)

local FIntSocalCarouselMaxNewRequestsCount = require(SocialCarousel.Flags.FIntSocalCarouselMaxNewRequestsCount)

local function Tile(tbl1)
    local ref = tbl1.tileRef or React.useRef(nil)
    local var2 = useTokens()
    local large = nil
    local var3 = nil
    local var4 = nil
    local var5

    if FFlagSocialCarouselXXSmallTiles then
        local var6
        large, var6 = React.useBinding(0)

        var3 = React.useCallback(function(arg1)
            var6(arg1.AbsoluteSize.X * (tbl1.iconScale or 0))
        end, { tbl1.iconScale })
        local var7, var8 = React.useBinding(0)
        var4 = var7
        var5 = React.useCallback(function(arg1)
            var8(arg1.AbsoluteSize.X)
        end, {})
    else
        var5 = nil
    end
    local var6, var7 = React.useState(false)
    local var8 = if FFlagSocialCarouselXSmallTileText then useXSmallTileTypography() else nil
    local fontStyle = if var8 then var8.title else var2.Typography.TitleSmall
    local var1 = if var8 then var8.label else var2.Typography.LabelSmall
    local isLoading = FFlagSocialCarouselShowLoadingSkeleton and tbl1.isLoading

    local var11 = React.useMemo(function()
        if not tbl1.title then
            return Vector2.new(0, 0)
        end

        return GetTextSize(tbl1.title, fontStyle.FontSize, fontStyle.Font, Vector2.new(500, 500), { addTemporaryPadding = false })
    end, { tbl1.title, if FFlagSocialCarouselXSmallTileText or FFlagSocialCarouselXXSmallTiles then fontStyle else nil })

    local var12 = React.useMemo(function()
        if not (tbl1.presenceIconEnabled or tbl1.titleIcon) then
            return nil
        elseif tbl1.presenceIconEnabled then
            return (React.createElement(View, { tag = "size-300-300 bg-system-success radius-circle", LayoutOrder = 1 }))
        elseif tbl1.titleIcon then
            return (React.createElement(Image, { Image = tbl1.titleIcon, tag = "size-300-300 radius-circle", LayoutOrder = 1 }))
        end

        return nil
    end, { tbl1.titleIcon, tbl1.presenceIconEnabled })

    local useMemo = React.useMemo
    local function func1()
        if FFlagSocialCarouselXXSmallTiles and var4 then
            return React.createElement("UISizeConstraint", {
                MaxSize = var4:map(function(num1: number): Vector2
                    local var13 = num1 - (if var12 then 16 else 0) + 2 * (tbl1.titleOverhang or 0)
                    return Vector2.new(math.max(0, var13), var11.Y)
                end)
            })
        end

        if not ref.current then
            return nil
        end

        local x = if var12 then ref.current.AbsoluteSize.X - 16 else ref.current.AbsoluteSize.X
        return (React.createElement("UISizeConstraint", { MaxSize = Vector2.new(x, var11.Y) }))
    end

    local titleOverhang = if FFlagSocialCarouselXXSmallTiles then tbl1.titleOverhang else nil
    local var13 = if FFlagSocialCarouselXXSmallTiles then var4 else nil
    local var14 = if FFlagSocialCarouselXXSmallTiles then var12 else nil
    local uiSizeConstraint = useMemo(func1, { var11, titleOverhang, var13, var14 })

    local onStateChanged = React.useCallback(function(arg1)
        var7(arg1 == Enums.ControlState.Hover or arg1 == Enums.ControlState.Pressed)
    end, {})

    local var17 = React.useMemo(function()
        if not tbl1.subtitle then
            return nil
        end

        return (React.createElement(
            FoundationText,
            {
                tag = "size-full-0 auto-y clip text-truncate-end",
                fontStyle = var1,
                Text = tbl1.subtitle,
                LayoutOrder = 3
            }
        ))
    end, { tbl1.subtitle, if FFlagSocialCarouselXSmallTileText then var1 else nil })

    local var18 = React.useMemo(function()
        if not tbl1.badge then
            return nil
        end
        return (React.createElement(StatusIndicator, {
            Position = UDim2.new(0.9, 0, 0.1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            variant = StatusIndicatorVariant.Emphasis,
            value = tonumber(tbl1.badge),
            max = FIntSocalCarouselMaxNewRequestsCount
        }))
    end, { tbl1.badge })

    local createElement = React.createElement
    local var19 = View
    local tbl2 = {
        testId = tbl1.testId,
        tag = "auto-none",
        Size = tbl1.itemSize,
        LayoutOrder = tbl1.index,
        ref = ref,
        onAbsoluteSizeChanged = var5,
        onStateChanged = onStateChanged,
        onActivated = if isLoading then nil else tbl1.onActivated,
        stateLayer = {
            affordance = Enums.StateLayerAffordance.None
        },
        selection = FFlagSocialCarouselUnselectableSkeleton and isLoading and { Selectable = false }
            or not isLoading
                and tbl1.selectionOrder
                and {
                    SelectionOrder = tbl1.selectionOrder,
                    Selectable = tbl1.selectable == nil or tbl1.selectable
                }
            or nil
    }

    local tbl3 = { Content = 0, Badge = 0 }
    local createElement2 = React.createElement
    local var20 = View
    local tbl4 = { tag = "size-full col align-x-center gap-small" }

    local tbl5 = { Image = 0, TextContainer = 0, Subtitle = 0 }
    local element

    if isLoading then
        element = React.createElement(
            View,
            { tag = "size-full aspect-1-1", LayoutOrder = 1 },
            {
                AvatarSkeleton = React.createElement(Skeleton, { tag = "size-full", radius = Radius.Circle })
            }
        )
    else
        local createElement3 = React.createElement
        local var21 = Image
        local tbl6 = {
            Image = tbl1.image,
            tag = {
                ["size-full"] = true,
                ["aspect-1-1"] = true,
                ["bg-shift-300"] = not (var6 or tbl1.altBackground),
                ["bg-system-neutral"] = not var6 and tbl1.altBackground,
                ["radius-circle"] = true,
                ["bg-shift-400"] = var6 and not tbl1.altBackground,
                ["bg-system-contrast"] = var6 and tbl1.altBackground,
                ["align-x-center"] = true,
                ["align-y-center"] = true,
                row = true
            },
            stroke = not FFlagSocialCarouselRemoveStrokeForAddFriends
                and {
                    Color = var2.Color.Stroke.Emphasis.Color3,
                    Transparency = var2.Color.Stroke.Emphasis.Transparency,
                    Thickness = var2.Stroke.Thick,
                    BorderStrokePosition = Enum.BorderStrokePosition.Inner
                }
                or nil,
            LayoutOrder = 1,
            onAbsoluteSizeChanged = 0
        }

        if not (FFlagSocialCarouselXXSmallTiles and tbl1.iconScale) then
            var3 = nil
        end

        tbl6.onAbsoluteSizeChanged = var3

        local tbl7 = { Icon = 0 }
        local var22

        if tbl1.icon then
            local createElement4 = React.createElement
            local var23 = Icon
            local tbl8 = {
                name = tbl1.icon,
                size = 0,
                variant = 0
            }

            if not (FFlagSocialCarouselXXSmallTiles and tbl1.iconScale) then
                large = IconSize.Large
            end

            tbl8.size = large

            tbl8.variant = if FFlagSocialCarouselXXSmallTiles then tbl1.iconVariant else nil
            var22 = createElement4(var23, tbl8)
        else
            var22 = nil
        end

        tbl7.Icon = var22
        element = createElement3(var21, tbl6, tbl7)
    end

    tbl5.Image = element

    local createElement3 = React.createElement
    local var21 = View
    local tbl6 = {
        tag = "size-full-0 row auto-y gap-xsmall align-x-center align-y-center",
        LayoutOrder = 2
    }

    local tbl7 = {
        TitleIcon = if isLoading then nil else var12,
        Title = 0
    }
    local element2

    if tbl1.title and not isLoading then
        element2 = React.createElement(
            FoundationText,
            {
                tag = "auto-xy text-align-x-left clip text-truncate-end",
                fontStyle = fontStyle,
                Text = tbl1.title,
                LayoutOrder = 2
            },
            { UISizeConstraint = uiSizeConstraint }
        )
    else
        element2 = React.createElement(
            Skeleton,
            {
                Size = UDim2.new(1, 0, 0, 16),
                radius = if isLoading then Radius.Small else nil,
                LayoutOrder = 2
            }
        )
    end

    tbl7.Title = element2
    tbl5.TextContainer = createElement3(var21, tbl6, tbl7)

    if isLoading then
        var17 = nil
    end

    tbl5.Subtitle = var17
    tbl3.Content = createElement2(var20, tbl4, tbl5)

    if isLoading then
        var18 = nil
    end

    tbl3.Badge = var18
    return createElement(var19, tbl2, tbl3)
end

return Tile
