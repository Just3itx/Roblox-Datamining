-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:51:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local DividerVariant = require(Foundation.Enums.DividerVariant)

local Orientation = require(Foundation.Enums.Orientation)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    local common = {
        container = { tag = "col" },
        stroke = {
            backgroundStyle = arg1.Color.Stroke.Default
        },
        line = {
            tag = "size-full-200",
            position = UDim2.fromOffset(0, arg1.Size.Size_50),
            backgroundStyle = arg1.Color.Common.HeavyDivider
        }
    }

    local orientation = {
        [Orientation.Horizontal] = {
            container = { tag = "size-full-0 auto-y" },
            stroke = {
                Size = UDim2.new(1, 0, 0, arg1.Stroke.Standard)
            }
        },
        [Orientation.Vertical] = {
            container = { tag = "size-0-full auto-x" },
            stroke = {
                Size = UDim2.new(0, arg1.Stroke.Standard, 1, 0)
            }
        }
    }

    return {
        common = common,
        padding = {
            [DividerVariant.Inset] = {
                container = { tag = "padding-x-xlarge" }
            },
            [DividerVariant.InsetLeft] = {
                container = { tag = "padding-left-xlarge" }
            },
            [DividerVariant.InsetRight] = {
                container = { tag = "padding-right-xlarge" }
            }
        },
        orientation = orientation
    }
end
return function(arg1, arg2, horizontal)
    local var1 = VariantsContext.useVariants("Divider", variantsFactory, arg1)
    return composeStyleVariant(
        var1.common,
        horizontal ~= Orientation.Horizontal and {} or var1.padding[arg2],
        var1.orientation[horizontal]
    )
end
