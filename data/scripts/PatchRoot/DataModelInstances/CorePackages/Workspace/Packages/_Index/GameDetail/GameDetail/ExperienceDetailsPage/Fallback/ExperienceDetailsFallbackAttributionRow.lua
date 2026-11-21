-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local num1 = game:DefineFastInt("EdpFallbackActionBarPlayButtonWidth", 236)
local num2 = game:DefineFastInt("EdpFallbackIconSize", 140)

local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent

local React = require(GameDetailParent.React)
local Foundation = require(GameDetailParent.Foundation)
local View = Foundation.View
local Image = Foundation.Image
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local Skeleton = Foundation.Skeleton
local Radius = Foundation.Enums.Radius
local ButtonSize = Foundation.Enums.ButtonSize
local useTokens = Foundation.Hooks.useTokens
local PlayButton = require(GameDetailParent.GamePlayButton).PlayButton
local useImageLoadFade = require(script.Parent.Parent.useImageLoadFade)
local Responsive = require(GameDetailParent.Responsive)
local SduiSharedUtilities = require(GameDetailParent.SduiSharedUtilities)
local SharedFlags = require(GameDetailParent.SharedFlags)
local FFlagLuaAppEdpFallbackPrimaryActivation = SharedFlags.FFlagLuaAppEdpFallbackPrimaryActivation
local FFlagLuaAppMediaGalleryGamepadSupport = SharedFlags.FFlagLuaAppMediaGalleryGamepadSupport
local FFlagLuaAppLaunchWhenLoadingEdp = SharedFlags.FFlagLuaAppLaunchWhenLoadingEdp
local FFlagLuaAppSduiEdpFallbackAttributionFromCache = SharedFlags.FFlagLuaAppSduiEdpFallbackAttributionFromCache
local FFlagSduiScalePlayButtonAndImageSizes = SharedFlags.FFlagSduiScalePlayButtonAndImageSizes
local FFlagEnableGameJoinEarlyAccess = SharedFlags.FFlagEnableGameJoinEarlyAccess

local function VerifiedBadgeIcon()
    local var1 = useTokens()
    return React.createElement(View, { LayoutOrder = 2, tag = "auto-xy" }, {
        Backplate = React.createElement(Icon, {
            name = Foundation.Enums.IconName.VerifiedBackplate,
            style = var1.Color.System.Emphasis,
            size = Foundation.Enums.IconSize.Small,
            ZIndex = 1
        }),
        Check = React.createElement(Icon, {
            name = Foundation.Enums.IconName.VerifiedCheck,
            size = Foundation.Enums.IconSize.Small,
            variant = Foundation.Enums.IconVariant.Filled,
            style = var1.Color.Extended.White.White_100,
            ZIndex = 2
        })
    })
end

return React.memo(function(tbl1) -- name: FallbackAttributionRow
    local var1 = useTokens()
    local isSmallScreen = tbl1.isSmallScreen
    local bool1 = tbl1.isLoading == true

    local var2 = if FFlagLuaAppEdpFallbackPrimaryActivation then React.useCallback(function(func1: (...any) -> (...any))
        return SduiSharedUtilities.getSduiFocusActivationStore().register(SduiSharedUtilities.SduiFocusTags.PrimaryAction, func1)
    end, {}) else nil

    local bool2 = if FFlagLuaAppMediaGalleryGamepadSupport then Responsive.useLastInput() == Responsive.Input.Directional else false
    local var3 = if isSmallScreen then var1.Size.Size_1400 elseif FFlagLuaAppMediaGalleryGamepadSupport and bool2 and num2 > 0 then if FFlagSduiScalePlayButtonAndImageSizes then num2 * var1.Config.UI.Scale else num2 else var1.Size.Size_2500 * 2
    local num3 = if isSmallScreen then 150 elseif FFlagSduiScalePlayButtonAndImageSizes and var3 > 256 then 512 else 256

    local image = string.format("rbxthumb://type=GameIcon&id=%s&w=%d&h=%d", tbl1.universeId, num3, num3)
    local var4 = useImageLoadFade()

    local icon = React.createElement(
        View,
        {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(var3, var3),
            testId = "--edp-fallback-attribution-icon"
        },
        {
            GameIcon = React.createElement(
                Image,
                {
                    tag = "radius-medium",
                    Image = image,
                    Size = UDim2.fromScale(1, 1),
                    onLoaded = var4.onLoaded
                }
            ),
            SkeletonOverlay = if var4.skeletonVisible then React.createElement(
                View,
                {
                    tag = "radius-medium",
                    Size = UDim2.fromScale(1, 1),
                    ZIndex = 2,
                    ClipsDescendants = true,
                    GroupTransparency = var4.overlayTransparency
                },
                {
                    Skeleton = React.createElement(Skeleton, { Size = UDim2.fromScale(1, 1) })
                }
            ) else nil
        }
    )
    local var5 = if isSmallScreen then var1.Typography.CaptionLarge.LineHeight * var1.Typography.CaptionLarge.FontSize else var1.Typography.BodyMedium.LineHeight * var1.Typography.BodyMedium.FontSize
    local element2 = nil
    if tbl1.gameName then
        element2 = React.createElement(FoundationText, {
            tag = {
                ["auto-xy text-wrap text-align-x-left text-truncate-none"] = true,
                ["text-heading-small"] = isSmallScreen,
                ["text-heading-large"] = not isSmallScreen
            },
            Text = tbl1.gameName,
            LayoutOrder = 1,
            testId = "--edp-fallback-attribution-title"
        })
    elseif bool1 then
        local yOffset = if isSmallScreen then var5 else var1.Typography.HeadingMedium.LineHeight * var1.Typography.HeadingMedium.FontSize
        element2 = React.createElement(
            Skeleton,
            {
                Size = UDim2.fromOffset(var1.Size.Size_2800 * 2, yOffset),
                radius = Radius.Small,
                LayoutOrder = 1
            }
        )
    end

    local element3 = nil
    if tbl1.creatorName then
        element3 = React.createElement(View, {
            tag = "row align-y-center gap-xsmall auto-xy",
            LayoutOrder = 2
        }, {
            CreatorName = React.createElement(FoundationText, {
                tag = "auto-xy text-body-medium content-default",
                Text = tbl1.creatorName,
                TextTruncate = Enum.TextTruncate.None,
                LayoutOrder = 1,
                testId = "--edp-fallback-attribution-creator"
            }),
            Badge = if tbl1.hasVerifiedBadge then React.createElement(VerifiedBadgeIcon) else nil
        })
    elseif bool1 then
        local yOffset = if FFlagLuaAppSduiEdpFallbackAttributionFromCache then var1.Typography.BodyLarge.FontSize * var1.Typography.BodyLarge.LineHeight else var5
        element3 = React.createElement(Skeleton, {
            Size = UDim2.fromOffset(var1.Size.Size_2800 * 2, yOffset),
            radius = Radius.Small,
            LayoutOrder = 2,
            testId = "--edp-fallback-attribution-creator-skeleton"
        })
    end

    local element4 = nil
    if tbl1.ageRecDisplayName then
        element4 = React.createElement(FoundationText, {
            tag = "auto-xy text-body-medium content-default",
            Text = tbl1.ageRecDisplayName,
            LayoutOrder = 3,
            testId = "--edp-fallback-attribution-age-rating"
        })
    elseif bool1 then
        if FFlagLuaAppSduiEdpFallbackAttributionFromCache then
            var5 = var1.Typography.BodyMedium.FontSize
            if not isSmallScreen then
                var5 += var1.Padding.XSmall
            end
        end

        element4 = React.createElement(Skeleton, {
            Size = UDim2.fromOffset(if isSmallScreen then var1.Size.Size_2400 else var1.Size.Size_2800, var5),
            radius = Radius.Small,
            LayoutOrder = 3,
            testId = "--edp-fallback-attribution-age-rating-skeleton"
        })
    end

    local var6

    if isSmallScreen then
        var6 = nil
    else
        local createElement = React.createElement
        local var7 = View
        local tbl2 = { tag = "row align-y-center gap-small auto-xy", LayoutOrder = 4 }

        local tbl3 = { PlayBtn = 0, OverflowSkeleton1 = 0, OverflowSkeleton2 = 0 }
        local createElement2 = React.createElement
        local var8 = PlayButton
        local tbl4 = {
            universeId = tbl1.universeId,
            referralSource = tbl1.referralSource,
            launchSource = tbl1.launchSource,
            experienceJoinData = tbl1.experienceJoinData,
            placeId = tbl1.placeIdOverride,
            useUIBloxButton = true,
            buttonSize = ButtonSize.Large,
            width = UDim.new(0, if FFlagSduiScalePlayButtonAndImageSizes then num1 * var1.Config.UI.Scale else num1),
            launchWhenLoading = if FFlagLuaAppLaunchWhenLoadingEdp then true else nil,
            launchOnReleaseAfterUnmount = true,
            onRegisterActivation = 0,
            enableEarlyAccessPlusTooltip = 0,
            expandWidthForSecondaryPlayButton = true,
            LayoutOrder = 1,
            testId = "--edp-fallback-feed-play-button"
        }
        if not FFlagLuaAppEdpFallbackPrimaryActivation then
            var2 = nil
        end

        tbl4.onRegisterActivation = var2
        tbl4.enableEarlyAccessPlusTooltip = if FFlagEnableGameJoinEarlyAccess then true else nil
        tbl3.PlayBtn = createElement2(var8, tbl4)

        tbl3.OverflowSkeleton1 = if bool1 then React.createElement(
            Skeleton,
            {
                Size = UDim2.fromOffset(var1.Size.Size_1200, var1.Size.Size_1200),
                radius = Radius.Medium,
                LayoutOrder = 2
            }
        ) else nil

        tbl3.OverflowSkeleton2 = if bool1 then React.createElement(
            Skeleton,
            {
                Size = UDim2.fromOffset(var1.Size.Size_1200, var1.Size.Size_1200),
                radius = Radius.Medium,
                LayoutOrder = 3
            }
        ) else nil
        var6 = createElement(var7, tbl2, tbl3)
    end

    return React.createElement(View, {
        tag = {
            ["row size-full-0 auto-y"] = true,
            ["gap-medium"] = isSmallScreen,
            ["gap-xlarge"] = not isSmallScreen,
            ["align-y-center"] = isSmallScreen,
            ["align-y-bottom"] = not isSmallScreen
        },
        LayoutOrder = 1
    }, {
        Icon = icon,
        ContentColumn = React.createElement(
            View,
            {
                tag = {
                    ["col fill gap-xsmall auto-xy"] = FFlagLuaAppSduiEdpFallbackAttributionFromCache,
                    ["col fill gap-small auto-xy"] = not FFlagLuaAppSduiEdpFallbackAttributionFromCache
                },
                LayoutOrder = 2,
                testId = "--edp-fallback-attribution-content-column"
            },
            { Title = element2, Creator = element3, AgeRating = element4, ActionRow = var6 }
        )
    })
end)
