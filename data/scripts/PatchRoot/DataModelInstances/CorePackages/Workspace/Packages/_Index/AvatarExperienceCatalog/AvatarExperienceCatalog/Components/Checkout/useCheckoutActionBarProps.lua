-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local React = require(AvatarExperienceCatalogParent.React)
local tutils = require(AvatarExperienceCatalogParent.tutils)

local useNavigation = require(AvatarExperienceCatalogParent.Navigation).useNavigation
local useMultiItemShoppingFtux = require(AvatarExperienceCatalog.Hooks.useMultiItemShoppingFtux)
local _CheckoutActionBar = require(AvatarExperienceCatalog.Components.Checkout.CheckoutActionBar)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local ClearTryOns = require(AvatarExperienceCatalogParent.AvatarExperienceRodux).Actions.ClearTryOns

local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local num1 = game:DefineFastInt("AXCheckoutButtonTooltipFtuxDelay", 500)
local num2 = game:DefineFastInt("AXCheckoutButtonTooltipExpireTime", 5000)
local useSelector = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useSelector
local useDispatch = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useDispatch
local FFlagStackedBottomNavMarketplaceCTA = require(AvatarExperienceCatalogParent.SharedFlags).FFlagStackedBottomNavMarketplaceCTA

local function selectTryOnItems(arg1)
    return arg1.AvatarExperience.AvatarScene.OutfitTryOn.TryOnItems
end

local function useCheckoutActionBarProps(tbl1, ref)
    local var1 = useNavigation()
    local var2 = useDispatch()

    local var3 = useMultiItemShoppingFtux()
    local var4 = useAvatarRoute()
    local name = var4 and var4.opaque and var4.opaque.name
    local routeName = var1.state.routeName

    local showCheckoutButtonTooltip, var6 = React.useState(false)

    local var7 = React.useRef(nil)

    local var8 = useSelector(selectTryOnItems, tutils.deepEqual)

    local itemCount = tutils.fieldCount(var8)

    local onClearButtonActivated = React.useCallback(function()
        if tbl1.onClearButtonActivated then
            tbl1.onClearButtonActivated()
        end

        if not var3.shouldShowClearAllItemsPrompt() then
            var2(ClearTryOns())

            return
        end

        var1.navigate(AvatarScreen.ClearAllItemsOnAvatarPrompt, {
            onConfirm = function(arg1)
                var2(ClearTryOns())

                if arg1 then
                    var3.hideClearAllItemsPrompt()
                end
            end
        })
    end, {
        tbl1.onClearButtonActivated,
        var1,
        var3,
        var2
    })
    local onCheckoutButtonActivated = React.useCallback(function()
        var1.navigate("Checkout")
        if tbl1.onCheckoutButtonActivated then
            tbl1.onCheckoutButtonActivated()
        end

        var3.setSeenTooltipOnCheckoutButton()
        if var7.current then
            task.cancel(var7.current)
        end

        var6(false)
    end, {
        tbl1.onCheckoutButtonActivated,
        var6,
        var1,
        var3
    })

    local onTooltipButtonActivated = React.useCallback(function()
        var3.setSeenTooltipOnCheckoutButton()
        if var7.current then
            task.cancel(var7.current)
        end

        var6(false)
    end, {})

    local var13 = React.useCallback(function()
        return task.delay(num1 / 1000, function()
            var6(true)

            task.delay(num2 / 1000, function()
                var3.setSeenTooltipOnCheckoutButton()
                var6(false)
            end)
        end)
    end, { var3 })

    React.useEffect(function()
        if var3.shouldShowTooltipOnCheckoutButton()
            and var4.isVisible
            and (name == AvatarScreen.Catalog or name == AvatarScreen.CatalogSearch)
            and routeName == name
        then
            var7.current = var13()
        end
    end, {
        var3,
        name,
        routeName,
        var4
    })

    React.useEffect(function()
        if not tbl1.Visible or routeName ~= name or not var4.isVisible then
            var6(false)
        end
    end, {
        tbl1.Visible,
        var6,
        var4,
        routeName,
        name
    })

    return {
        onCheckoutButtonActivated = onCheckoutButtonActivated,
        onClearButtonActivated = onClearButtonActivated,
        itemCount = itemCount,
        ref = ref,
        Visible = tbl1.Visible,
        showCheckoutButtonTooltip = showCheckoutButtonTooltip,
        onTooltipButtonActivated = onTooltipButtonActivated,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        footerVisibilityBinding = if FFlagStackedBottomNavMarketplaceCTA then tbl1.footerVisibilityBinding else nil
    }
end

return useCheckoutActionBarProps
