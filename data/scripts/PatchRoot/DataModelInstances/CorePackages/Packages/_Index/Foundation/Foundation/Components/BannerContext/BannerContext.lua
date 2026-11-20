-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BannerContextPresentation = require(Foundation.Enums.BannerContextPresentation)
local BannerContextVariant = require(Foundation.Enums.BannerContextVariant)
local InternalNotice = require(Foundation.Components.InternalNotice)
local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local useBannerContextVariants = require(script.Parent.useBannerContextVariants)

local tbl1 = {
    variant = BannerContextVariant.Standard,
    presentation = BannerContextPresentation.Inline,
    testId = "--foundation-banner-context"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: BannerContext
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local variantProps = useBannerContextVariants(var2, var1.presentation, var1.variant)

    return React.createElement(
        InternalNotice,
        withCommonProps(var1, {
            text = var1.text,
            icon = var1.icon,
            link = var1.link,
            onClose = var1.onClose,
            truncation = true,
            variantProps = variantProps,
            ref = ref
        })
    )
end))
