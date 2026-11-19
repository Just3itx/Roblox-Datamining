-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:50:59Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local IconSize = require(Foundation.Enums.IconSize)

local InputSize = require(Foundation.Enums.InputSize)

local ShortcutVariant = require(Foundation.Enums.ShortcutVariant)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        common = {
            container = {
                tag = "auto-xy",
                gap = arg1.Size.Size_150
            },
            keys = { tag = "row align-y-center auto-xy" },
            cap = { tag = "row align-x-center align-y-center auto-x" },
            capless = { tag = "row align-x-center align-y-center auto-xy" },
            text = { tag = "auto-xy text-align-x-center" },
            separator = { tag = "auto-x padding-x-xxsmall text-align-x-center content-emphasis" },
            keybinding = { tag = "auto-xy text-align-x-left content-default" },
            icon = {
                size = IconSize.XSmall
            },
            gamepadIcon = {
                style = arg1.Color.Content.Emphasis
            }
        },
        sizes = {
            [InputSize.XSmall] = {
                keys = { tag = "gap-xxsmall" },
                cap = { tag = "size-400 radius-xsmall" },
                capWide = {
                    padding = arg1.Padding.XSmall
                },
                text = { tag = "text-caption-small" },
                separator = { tag = "size-0-400 text-label-small" },
                keybinding = { tag = "text-label-small" },
                gamepadIcon = {
                    size = arg1.Size.Size_400
                }
            },
            [InputSize.Small] = {
                keys = { tag = "gap-xsmall" },
                cap = { tag = "size-500 radius-small" },
                capWide = {
                    padding = arg1.Size.Size_150
                },
                text = { tag = "text-caption-small" },
                separator = { tag = "size-0-500 text-label-medium" },
                keybinding = { tag = "text-label-medium" },
                gamepadIcon = {
                    size = arg1.Size.Size_500
                }
            },
            [InputSize.Medium] = {
                container = {
                    gap = arg1.Size.Size_200
                },
                keys = { tag = "gap-xsmall" },
                cap = { tag = "size-600 radius-small" },
                capWide = {
                    padding = arg1.Padding.Small
                },
                text = { tag = "text-caption-medium" },
                separator = { tag = "size-0-600 text-label-large" },
                keybinding = { tag = "text-label-medium" },
                icon = {
                    size = IconSize.Small
                },
                gamepadIcon = {
                    size = arg1.Size.Size_600
                }
            }
        },
        variants = {
            [ShortcutVariant.Standard] = {
                cap = { tag = "bg-shift-200" },
                text = { tag = "content-emphasis" },
                icon = {
                    style = arg1.Color.Content.Emphasis
                }
            },
            [ShortcutVariant.Contrast] = {
                cap = { tag = "bg-system-contrast" },
                text = { tag = "content-inverse-emphasis" },
                icon = {
                    style = arg1.Inverse.Content.Emphasis
                }
            }
        }
    }
end

local function useShortcutVariants(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("Shortcut", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.variants[arg3])
end

return useShortcutVariants
