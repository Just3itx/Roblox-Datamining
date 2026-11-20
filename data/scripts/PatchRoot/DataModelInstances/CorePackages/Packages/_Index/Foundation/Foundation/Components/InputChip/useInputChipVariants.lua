-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputSize = require(Foundation.Enums.InputSize)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function variantsFactory(arg1)
    return {
        common = {
            container = {
                tag = "row align-x-center align-y-center auto-x radius-small bg-action-standard clip"
            },
            text = {
                tag = "shrink size-0-full auto-x text-truncate-end",
                contentStyle = arg1.Color.ActionStandard.Foreground
            },
            close = { tag = "auto-xy" }
        },
        sizes = {
            [InputSize.XSmall] = {
                container = { tag = "size-0-400" },
                text = {
                    tag = "text-caption-small",
                    padding = {
                        left = UDim.new(0, arg1.Size.Size_150),
                        right = UDim.new(0, arg1.Padding.XSmall)
                    }
                },
                close = {
                    padding = {
                        right = UDim.new(0, arg1.Size.Size_150)
                    }
                }
            },
            [InputSize.Small] = {
                container = { tag = "size-0-500" },
                text = {
                    tag = "text-label-small",
                    padding = {
                        left = UDim.new(0, arg1.Padding.Small),
                        right = UDim.new(0, arg1.Size.Size_150)
                    }
                },
                close = {
                    padding = {
                        right = UDim.new(0, arg1.Padding.Small)
                    }
                }
            },
            [InputSize.Medium] = {
                container = { tag = "size-0-600" },
                text = {
                    tag = "text-label-small",
                    padding = {
                        left = UDim.new(0, arg1.Padding.Small),
                        right = UDim.new(0, arg1.Size.Size_150)
                    }
                },
                close = {
                    padding = {
                        right = UDim.new(0, arg1.Padding.Small)
                    }
                }
            },
            [InputSize.Large] = {
                container = { tag = "size-0-800" },
                text = {
                    tag = "text-label-medium",
                    padding = {
                        left = UDim.new(0, arg1.Padding.Medium),
                        right = UDim.new(0, arg1.Padding.Small)
                    }
                },
                close = {
                    padding = {
                        right = UDim.new(0, arg1.Padding.Medium)
                    }
                }
            }
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("InputChip", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.sizes[arg2])
end
