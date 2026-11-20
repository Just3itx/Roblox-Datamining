-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local DialogSize = require(Foundation.Enums.DialogSize)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local useTokens = require(Foundation.Providers.Style.useTokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local useDialog = require(script.Parent.useDialog)

local DIALOG_SIZES = {
    [DialogSize.Small] = 320,
    [DialogSize.Medium] = 480,
    [DialogSize.Large] = 640
}

local function variantsFactory(arg1)
    return {
        common = {
            backdrop = {
                backgroundStyle = arg1.Color.Common.Backdrop
            },
            shadow = {
                tag = "auto-xy",
                imageStyle = arg1.Color.Extended.Black.Black_15
            },
            container = { tag = "col align-x-center align-y-center size-full-full" },
            inner = { tag = "shrink-1 size-full-0 auto-y clip bg-surface-100 stroke-default" },
            body = { tag = "col size-full auto-y padding-bottom-xlarge" },
            heroMediaWrapper = { tag = "position-top-center size-full-full auto-y" },
            title = { tag = "size-full-0 auto-y" },
            titleText = { tag = "size-full-0 auto-y text-wrap text-align-x-left content-emphasis" },
            content = { tag = "fill size-full auto-y" },
            contentText = {
                tag = "size-full-0 auto-y text-wrap text-align-x-left text-align-y-top"
            },
            actionsLabel = {
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left text-align-y-top"
            }
        },
        size = {
            [DialogSize.Small] = {
                shadow = { tag = "padding-large" },
                inner = {
                    maxWidth = DIALOG_SIZES[DialogSize.Small],
                    tag = "radius-large"
                },
                body = { tag = "gap-large padding-x-large" },
                closeAffordance = {
                    offset = arg1.Size.Size_300
                },
                heroMedia = {
                    tag = "radius-top-large",
                    offsetX = arg1.Padding.Large
                },
                titleText = { tag = "text-heading-small" },
                contentText = { tag = "text-body-medium" },
                actionsLabel = { tag = "padding-top-large" }
            },
            [DialogSize.Medium] = {
                shadow = { tag = "padding-xlarge" },
                inner = {
                    maxWidth = DIALOG_SIZES[DialogSize.Medium],
                    tag = "radius-large"
                },
                body = { tag = "gap-xlarge padding-x-xlarge" },
                closeAffordance = {
                    offset = arg1.Size.Size_400
                },
                heroMedia = {
                    tag = "radius-top-large",
                    offsetX = arg1.Padding.XLarge
                },
                titleText = { tag = "text-heading-medium" },
                contentText = { tag = "text-body-medium" },
                actionsLabel = { tag = "padding-top-xlarge" }
            },
            [DialogSize.Large] = {
                shadow = { tag = "padding-xlarge" },
                inner = {
                    maxWidth = DIALOG_SIZES[DialogSize.Large],
                    tag = "radius-large"
                },
                body = { tag = "gap-xlarge padding-x-xlarge" },
                closeAffordance = {
                    offset = arg1.Size.Size_400
                },
                heroMedia = {
                    tag = "radius-top-large",
                    offsetX = arg1.Padding.XLarge
                },
                titleText = { tag = "text-heading-large" },
                contentText = { tag = "text-body-large" },
                actionsLabel = { tag = "padding-top-xlarge" }
            }
        }
    }
end

function useDialogVariants()
    local var1 = useTokens()
    local var2 = VariantsContext.useVariants("Dialog", variantsFactory, var1)
    local var3 = useDialog()

    return composeStyleVariant(var2.common, var2.size[var3.responsiveSize])
end

return {
    useDialogVariants = useDialogVariants,
    DIALOG_SIZES = DIALOG_SIZES
}
