-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local tutils = require(AvatarExperienceCatalogParent.tutils)
local Foundation = require(AvatarExperienceCatalogParent.Foundation)
local ReactOtter = require(AvatarExperienceCatalogParent.ReactOtter)
local FFlagAXMISWithBlackbird = require(AvatarExperienceCatalogParent.SharedFlags).FFlagAXMISWithBlackbird
local duration = game:DefineFastInt("AXBuyDelayMilliseconds", 1000) / 1000

return React.memo(function(tbl1) -- name: CheckoutBuyButton
    local var1 = Foundation.Hooks.useTokens()

    local var2, var3 = React.useState(false)
    local var4 = React.useCallback(function()
        var3(true)
    end, { var2 })
    local var5, var6 = ReactOtter.useAnimatedBinding(1, var4)

    React.useEffect(function()
        if not var2 then
            var6(ReactOtter.ease(0, { duration = duration, easingStyle = Enum.EasingStyle.Linear }))
        end
    end, { var2 })

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y fill",
        LayoutOrder = if FFlagAXMISWithBlackbird then tbl1.LayoutOrder else nil
    }

    return createElement(view, tbl2, {
        BuyButton = React.createElement(Foundation.Button, {
            text = tbl1.label,
            onActivated = tbl1.onCheckoutButtonActivated,
            variant = Foundation.Enums.ButtonVariant.Emphasis,
            size = Foundation.Enums.ButtonSize.Medium,
            fillBehavior = Foundation.Enums.FillBehavior.Fill,
            isDisabled = not var2 or tbl1.isPurchasing,
            isLoading = tbl1.isPurchasing,
            testId = "CheckoutBuyButton_BuyButton"
        }),
        CooldownBar = React.createElement(Foundation.View, {
            isDisabled = true,
            backgroundStyle = {
                Color3 = var1.Color.Surface.Surface_0.Color3,
                Transparency = 0.5
            },
            Position = UDim2.fromScale(1, 0),
            Size = var5:map(function(arg1): UDim2
                return UDim2.fromScale(-arg1, 1)
            end)
        })
    })
end, tutils.deepEqual)
