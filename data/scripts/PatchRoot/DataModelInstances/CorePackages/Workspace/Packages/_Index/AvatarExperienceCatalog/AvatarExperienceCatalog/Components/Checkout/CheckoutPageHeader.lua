-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local useLocalization = require(AvatarExperienceCatalogParent.Localization).Hooks.useLocalization
local useNavigation = require(AvatarExperienceCatalogParent.Navigation).useNavigation
local canGoBack = require(AvatarExperienceCatalogParent.Navigation).canGoBack
local useDispatch = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useDispatch
local ClearTryOns = require(AvatarExperienceCatalogParent.AvatarExperienceRodux).Actions.ClearTryOns

local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local FFlagAXEnableExpiredUserLookCheckout = AvatarExperienceFlags.FFlagAXEnableExpiredUserLookCheckout

return React.memo(function() -- name: CheckoutPageHeader
    local var1 = if FFlagAXEnableExpiredUserLookCheckout then useDispatch() else nil
    local var2 = useNavigation()
    local var3 = Foundation.Hooks.useTokens()
    local var4 = if FFlagAXEnableExpiredUserLookCheckout then useAvatarRoute() else nil
    local var5 = useLocalization({ checkoutTitle = "Feature.Catalog.Header.Checkout" })

    local useCallback = React.useCallback

    local function func1()
        if FFlagAXEnableExpiredUserLookCheckout
            and (var4 and var4.current and var4.current.name) == AvatarScreen.ExpiredUserLookCheckout
        then
            var1(ClearTryOns())
        end

        if canGoBack(var2) then
            var2.goBack()
        end
    end

    local var6 = if FFlagAXEnableExpiredUserLookCheckout then var4 else nil
    local var7 = if FFlagAXEnableExpiredUserLookCheckout then var1 else nil
    local onActivated = useCallback(func1, { var2, var6, var7 })

    return React.createElement(
        Foundation.View,
        {
            tag = "auto-y size-full-0 bg-surface-0 row items-center padding-x-xlarge padding-y-medium gap-medium"
        },
        {
            BackButton = React.createElement(Foundation.IconButton, {
                onActivated = onActivated,
                size = Foundation.Enums.InputSize.Medium,
                icon = "chevron-large-left",
                tag = "content-emphasis"
            }),
            Title = React.createElement(Foundation.Text, {
                Text = var5.checkoutTitle,
                TextTruncate = Enum.TextTruncate.AtEnd,
                tag = "grow auto-y text-title-large content-emphasis"
            }),
            Spacer = React.createElement(Foundation.View, { Size = UDim2.fromOffset(var3.Size.Size_1000, 0) })
        }
    )
end)
