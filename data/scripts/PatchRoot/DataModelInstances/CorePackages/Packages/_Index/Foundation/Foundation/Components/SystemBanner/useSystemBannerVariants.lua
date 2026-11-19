-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)

local AlertVariant = require(Foundation.Enums.AlertVariant)

local AlertSeverity = require(Foundation.Enums.AlertSeverity)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function createStandardVariantStyles(arg1, style)
    return {
        container = {
            tag = "bg-shift-200",
            colorNamespace = ColorNamespace.Color
        },
        title = {
            style = arg1.Color.Content.Emphasis
        },
        description = {
            style = arg1.Color.Content.Default
        },
        icon = { style = style }
    }
end

local function createEmphasisVariantStyles(arg1, tag: string, colorNamespace)
    return {
        container = { tag = tag, colorNamespace = colorNamespace },
        title = {
            style = arg1[colorNamespace].Content.Emphasis
        },
        description = {
            style = arg1[colorNamespace].Content.Default
        },
        icon = {
            style = arg1[colorNamespace].Content.Emphasis
        }
    }
end

local function variantsFactory(arg1)
    return {
        common = {
            container = {
                tag = "row gap-medium size-full-0 auto-y padding-x-medium padding-y-large"
            },
            title = {
                tag = "auto-xy padding-y-xxsmall text-title-medium text-wrap text-align-x-left"
            },
            description = { tag = "auto-xy text-body-medium text-wrap text-align-x-left" }
        },
        severity = {
            [AlertVariant.Standard] = {
                [AlertSeverity.Info] = createStandardVariantStyles(arg1, arg1.Color.System.Emphasis),
                [AlertSeverity.Warning] = createStandardVariantStyles(arg1, arg1.Color.System.Warning),
                [AlertSeverity.Success] = createStandardVariantStyles(arg1, arg1.Color.System.Success),
                [AlertSeverity.Error] = createStandardVariantStyles(arg1, arg1.Color.System.Alert)
            },
            [AlertVariant.Emphasis] = {
                [AlertSeverity.Info] = createEmphasisVariantStyles(arg1, "bg-system-emphasis", ColorNamespace.DarkMode),
                [AlertSeverity.Warning] = createEmphasisVariantStyles(arg1, "bg-system-warning", ColorNamespace.LightMode),
                [AlertSeverity.Success] = createEmphasisVariantStyles(arg1, "bg-system-success", ColorNamespace.LightMode),
                [AlertSeverity.Error] = createEmphasisVariantStyles(arg1, "bg-system-alert", ColorNamespace.DarkMode)
            }
        }
    }
end

return function(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("SystemBanner", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.severity[arg2][arg3])
end
