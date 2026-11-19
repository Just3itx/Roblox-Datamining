-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:41:20Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local FillBehavior = require(Foundation.Enums.FillBehavior)

local InputSize = require(Foundation.Enums.InputSize)

local IconSize = require(Foundation.Enums.IconSize)

local SegmentedControlVariant = require(Foundation.Enums.SegmentedControlVariant)

local Flags = require(Foundation.Utility.Flags)
local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function strokeFromStyle(emphasis, thickness: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        Color = emphasis.Color3,
        Transparency = emphasis.Transparency,
        Thickness = thickness,
        BorderStrokePosition = Enum.BorderStrokePosition.Outer
    }
end

local function variantsFactory_DEPRECATED(arg1)
    return {
        common = {
            container = { tag = "row align-y-center auto-x bg-surface-300" },
            segment = { tag = "row align-y-center size-0-full auto-x" },
            text = { tag = "auto-x text-truncate-end content-emphasis" },
            icon = {
                style = arg1.Color.Content.Emphasis
            },
            divider = { tag = "row" }
        },
        sizes = {
            [InputSize.XSmall] = {
                container = { tag = "size-600" },
                segment = { tag = "padding-small" },
                text = { tag = "text-caption-small" },
                icon = {
                    size = IconSize.Small
                },
                divider = {
                    Size = UDim2.new(0, arg1.Stroke.Standard, 1, 0)
                }
            },
            [InputSize.Small] = {
                container = { tag = "size-800" },
                segment = { tag = "padding-small" },
                text = { tag = "text-caption-small" },
                icon = {
                    size = IconSize.Medium
                },
                divider = {
                    Size = UDim2.new(0, arg1.Stroke.Standard, 1, 0)
                }
            },
            [InputSize.Medium] = {
                container = { tag = "size-1000 padding-xsmall" },
                segment = { tag = "padding-small" },
                text = { tag = "text-caption-medium" },
                icon = {
                    size = IconSize.Medium
                },
                divider = {
                    Size = UDim2.new(0, arg1.Stroke.Standard, 1, 0)
                }
            },
            [InputSize.Large] = {
                container = { tag = "size-1200 padding-xsmall" },
                segment = { tag = "padding-medium" },
                text = { tag = "text-caption-medium" },
                icon = {
                    size = IconSize.Large
                },
                divider = {
                    Size = UDim2.new(0, arg1.Stroke.Standard, 1, 0)
                }
            }
        },
        defaultRadius = {
            [InputSize.XSmall] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-medium" }
            },
            [InputSize.Small] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-medium" }
            },
            [InputSize.Medium] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-small" }
            },
            [InputSize.Large] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-small" }
            }
        },
        circularRadius = {
            container = { tag = "radius-circle" },
            segment = { tag = "radius-circle" }
        }
    }
end

local function variantsFactory(arg1)
    local variantStyles = {
        [SegmentedControlVariant.Filled] = {
            container = { tag = "bg-shift-200" }
        },
        [SegmentedControlVariant.Stroke] = {
            container = {
                stroke = strokeFromStyle(arg1.Color.Stroke.Emphasis, arg1.Stroke.Standard)
            }
        },
        [SegmentedControlVariant.Utility] = {}
    }

    local sizes = {
        [InputSize.XSmall] = {
            segment = { tag = "padding-x-small" },
            text = { tag = "text-label-small" },
            icon = {
                size = IconSize.XSmall
            }
        },
        [InputSize.Small] = {
            segment = { tag = "padding-x-medium" },
            text = { tag = "text-label-small" },
            icon = {
                size = IconSize.Small
            }
        },
        [InputSize.Medium] = {
            container = { tag = "padding-xsmall" },
            segment = { tag = "padding-x-medium" },
            text = { tag = "text-label-medium" },
            icon = {
                size = IconSize.Medium
            }
        },
        [InputSize.Large] = {
            container = { tag = "padding-xsmall" },
            segment = { tag = "padding-x-large" },
            text = { tag = "text-label-large" },
            icon = {
                size = IconSize.Large
            }
        }
    }
    local fitSizes = {
        [InputSize.XSmall] = {
            container = { tag = "size-0-600 auto-x" }
        },
        [InputSize.Small] = {
            container = { tag = "size-0-800 auto-x" }
        },
        [InputSize.Medium] = {
            container = { tag = "size-0-1000 auto-x" }
        },
        [InputSize.Large] = {
            container = { tag = "size-0-1200 auto-x" }
        }
    }
    local fillBehaviorStyles = {
        [FillBehavior.Fit] = {
            segment = { tag = "size-0-full auto-xy" }
        },
        [FillBehavior.Fill] = {
            segment = { tag = "grow auto-xy" }
        }
    }

    local fillSizes = {
        [InputSize.XSmall] = {
            container = { tag = "size-full-600" }
        },
        [InputSize.Small] = {
            container = { tag = "size-full-800" }
        },
        [InputSize.Medium] = {
            container = { tag = "size-full-1000" }
        },
        [InputSize.Large] = {
            container = { tag = "size-full-1200" }
        }
    }
    local utilityPadding = {
        [InputSize.XSmall] = {},
        [InputSize.Small] = {
            segment = { tag = "padding-x-medium" }
        },
        [InputSize.Medium] = {
            segment = { tag = "padding-x-large" }
        },
        [InputSize.Large] = {
            segment = { tag = "padding-x-xlarge" }
        }
    }
    return {
        common = {
            container = { tag = "row flex-y-fill align-y-center gap-xxsmall" },
            segment = { tag = "row align-x-center align-y-center" },
            text = { tag = "auto-x text-align-x-center text-truncate-end" },
            icon = {}
        },
        activeStyles = {
            [true] = {
                text = {
                    style = arg1.Color.Content.Emphasis
                },
                icon = {
                    style = arg1.Color.Content.Emphasis
                }
            },
            [false] = {
                text = {
                    style = arg1.Color.Content.Default
                },
                icon = {
                    style = arg1.Color.Content.Default
                }
            }
        },
        variantStyles = variantStyles,
        sizes = sizes,
        fitSizes = fitSizes,
        fillBehaviorStyles = fillBehaviorStyles,
        fillSizes = fillSizes,
        utilityPadding = utilityPadding,
        defaultRadius = {
            [InputSize.XSmall] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-medium" }
            },
            [InputSize.Small] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-medium" }
            },
            [InputSize.Medium] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-small" }
            },
            [InputSize.Large] = {
                container = { tag = "radius-medium" },
                segment = { tag = "radius-small" }
            }
        },
        circularRadius = {
            container = { tag = "radius-circle" },
            segment = { tag = "radius-circle" }
        }
    }
end
return function(arg1, arg2, utility, fill, bool1: boolean?, bool2: boolean?)
    if not Flags.FoundationSegmentedControlBeta then
        local var1 = VariantsContext.useVariants("SegmentedControl", variantsFactory_DEPRECATED, arg1)

        return composeStyleVariant(var1.common, var1.sizes[arg2], if bool1 then var1.circularRadius else var1.defaultRadius[arg2])
    end

    local var1 = VariantsContext.useVariants("SegmentedControl", variantsFactory, arg1)

    return composeStyleVariant(
        var1.common,
        var1.sizes[arg2],
        utility ~= SegmentedControlVariant.Utility and {} or var1.utilityPadding[arg2],
        if fill == FillBehavior.Fill then var1.fillSizes[arg2] else var1.fitSizes[arg2],
        var1.fillBehaviorStyles[fill],
        var1.activeStyles[bool2 == true],
        var1.variantStyles[utility],
        if bool1 then var1.circularRadius else var1.defaultRadius[arg2]
    )
end
