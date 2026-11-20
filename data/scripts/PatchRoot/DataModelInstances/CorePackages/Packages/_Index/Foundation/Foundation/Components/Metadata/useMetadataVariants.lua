-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local AvatarIconSize = require(Foundation.Enums.AvatarIconSize)

local IconSize = require(Foundation.Enums.IconSize)

local MetadataSize = require(Foundation.Enums.MetadataSize)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function variantsFactory(arg1)
    return {
        common = {
            container = { tag = "row align-y-center auto-xy" },
            item = {
                tag = "row align-y-center gap-xsmall auto-xy",
                gap = arg1.Gap.XSmall
            },
            truncatedItem = { tag = "row align-y-center shrink gap-xsmall auto-xy" },
            text = { tag = "auto-xy content-default", openTypeFeatures = "zero, ss03" },
            truncatedText = { tag = "shrink auto-xy text-truncate-split content-default" },
            wrappedText = {
                tag = "shrink auto-xy text-wrap text-align-x-left text-align-y-top text-truncate-split content-default"
            },
            accessory = {
                iconSize = IconSize.Small,
                avatarSize = AvatarIconSize.Small,
                avatarTag = "auto-xy padding-right-xxsmall",
                style = arg1.Color.Content.Default,
                width = arg1.Size.Size_400,
                avatarWidth = arg1.Size.Size_400 + arg1.Padding.XXSmall
            }
        },
        sizes = {
            [MetadataSize.Medium] = {
                text = {
                    tag = "text-body-medium",
                    fontStyle = arg1.Typography.BodyMedium
                },
                truncatedText = { tag = "text-body-medium" },
                wrappedText = { tag = "text-body-medium" }
            },
            [MetadataSize.Small] = {
                text = {
                    tag = "text-body-small",
                    fontStyle = arg1.Typography.BodySmall
                },
                truncatedText = { tag = "text-body-small" },
                wrappedText = { tag = "text-body-small" }
            }
        },
        spacing = {
            [true] = {
                container = { tag = "gap-small" }
            },
            [false] = {
                container = { tag = "gap-xsmall" }
            }
        }
    }
end

return function(arg1, arg2, bool1: boolean)
    local var1 = VariantsContext.useVariants("Metadata", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.spacing[bool1])
end
