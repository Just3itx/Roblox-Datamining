-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)

local _Types = require(Foundation.Components.Types)

local ControlState = require(Foundation.Enums.ControlState)

local InputSize = require(Foundation.Enums.InputSize)

local IconSize = require(Foundation.Enums.IconSize)

local _InputLabelSize = require(Foundation.Enums.InputLabelSize)

local InputVariant = require(Foundation.Enums.InputVariant)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local getInputVariantsFactory = require(Foundation.Components.InputField.getInputVariantsFactory)

local function variantsFactory()
    local sizes = {
        [InputSize.XSmall] = {
            container = { tag = "gap-small size-full-600 padding-small radius-small" },
            text = { tag = "text-body-small" },
            arrow = {
                size = IconSize.XSmall
            }
        },
        [InputSize.Small] = {
            container = { tag = "gap-small size-full-800 padding-medium radius-medium" },
            text = { tag = "text-body-small" },
            arrow = {
                size = IconSize.Small
            }
        },
        [InputSize.Medium] = {
            container = { tag = "gap-small size-full-1000 padding-medium radius-medium" },
            text = { tag = "text-body-medium" },
            arrow = {
                size = IconSize.Medium
            }
        },
        [InputSize.Large] = {
            container = { tag = "gap-small size-full-1200 padding-medium radius-medium" },
            text = { tag = "text-body-large" },
            arrow = {
                size = IconSize.Large
            }
        }
    }
    local states = {
        [ControlState.Disabled] = {
            container = nil,
            text = { tag = "content-muted" }
        },
        [ControlState.Initialize] = {
            container = nil,
            text = { tag = "content-default" }
        },
        [ControlState.Default] = nil,
        [ControlState.Hover] = nil,
        [ControlState.Pressed] = nil
    }

    return {
        common = {
            container = { tag = "row flex-x-between align-y-center" },
            text = { tag = "shrink auto-xy text-truncate-split content-emphasis" }
        },
        sizes = sizes,
        states = states,
        placeholderStates = Dash.map(states, function(arg1)
            return Dash.join(arg1, { text = { tag = "content-muted" } })
        end)
    }
end
return function(arg1, arg2, utility, arg3, bool1: boolean, bool2: boolean, bool3: boolean, bool4: boolean)
    local var1 = VariantsContext.useVariants("Dropdown", variantsFactory, arg1)
    local var2 = VariantsContext.useVariants("InputField", getInputVariantsFactory, arg1)
    local variant = var2.variants[utility or InputVariant.Standard]

    return composeStyleVariant(
        var2.common,
        var1.common,
        var2.sizes[arg2],
        var1.sizes[arg2],
        utility == InputVariant.Utility and {} or variant,
        var2.hoverState[bool4],
        var2.focusedState[bool3],
        var2.errorState[bool2],
        if bool1 then var1.placeholderStates[arg3] else var1.states[arg3],
        utility ~= InputVariant.Utility and {} or variant
    )
end
