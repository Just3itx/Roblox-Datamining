-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:31:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local Dash = require(FoundationParent.Dash)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)

local InputSize = require(Foundation.Enums.InputSize)

local _Types = require(Foundation.Components.Types)

local IconSize = require(Foundation.Enums.IconSize)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local CloseAffordanceVariant = require(Foundation.Enums.CloseAffordanceVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local Constants = require(Foundation.Constants)
local getSharedVariants = require(Foundation.Components.Button.getSharedVariants)

local function func1(arg1)
    local sharedVariants = getSharedVariants(arg1)

    local sizes = {
        [true] = {
            [InputSize.XSmall] = {
                container = {
                    size = UDim2.fromOffset(
                        sharedVariants.sizes[InputSize.XSmall].container.height,
                        sharedVariants.sizes[InputSize.XSmall].container.height
                    ),
                    padding = UDim.new(0, arg1.Size.Size_100)
                },
                content = {
                    iconSize = IconSize.Small
                }
            },
            [InputSize.Small] = {
                container = {
                    size = UDim2.fromOffset(
                        sharedVariants.sizes[InputSize.Small].container.height,
                        sharedVariants.sizes[InputSize.Small].container.height
                    ),
                    padding = UDim.new(0, arg1.Size.Size_150)
                },
                content = {
                    iconSize = IconSize.Medium
                }
            },
            [InputSize.Medium] = {
                container = {
                    size = UDim2.fromOffset(
                        sharedVariants.sizes[InputSize.Medium].container.height,
                        sharedVariants.sizes[InputSize.Medium].container.height
                    ),
                    padding = UDim.new(0, arg1.Size.Size_200)
                },
                content = {
                    iconSize = IconSize.Large
                }
            }
        },
        [false] = {
            [InputSize.XSmall] = {
                content = {
                    iconSize = IconSize.XSmall
                }
            },
            [InputSize.Small] = {
                content = {
                    iconSize = IconSize.Small
                }
            },
            [InputSize.Medium] = {
                content = {
                    iconSize = IconSize.Large
                }
            }
        }
    }

    local types = {
        [CloseAffordanceVariant.OverMedia] = Dash.map(ColorNamespace, function()
            return {
                container = { tag = "bg-over-media-100" },
                content = {
                    style = arg1.Color.Content.Emphasis
                }
            }
        end),
        [CloseAffordanceVariant.Utility] = Dash.map(ColorNamespace, function(arg2)
            return {
                container = {
                    stateLayer = {
                        mode = Constants.COLOR_NAMESPACE_TO_STATE_LAYER_MODE[false][arg2]
                    }
                },
                content = {
                    style = arg1[arg2].Content.Emphasis
                }
            }
        end)
    }

    return {
        common = {
            container = { tag = "row align-x-center align-y-center auto-xy clip" }
        },
        types = types,
        sizes = sizes,
        padding = {
            [true] = {
                container = {
                    radius = arg1.Radius.Medium
                }
            },
            [false] = {
                container = { radius = 0 }
            }
        },
        circular = {
            [true] = {
                container = {
                    radius = arg1.Radius.Circle
                }
            },
            [false] = {}
        }
    }
end
return function(arg1, arg2, overMedia, arg3, bool1: boolean, bool2: boolean)
    local var1 = VariantsContext.useVariants("CloseAffordance", func1, arg1)
    local bool3 = overMedia == CloseAffordanceVariant.OverMedia or bool2

    return composeStyleVariant(
        var1.common,
        var1.types[overMedia][arg3 or ColorNamespace.Color],
        var1.sizes[bool1][arg2],
        var1.padding[bool1],
        var1.circular[bool3]
    )
end
