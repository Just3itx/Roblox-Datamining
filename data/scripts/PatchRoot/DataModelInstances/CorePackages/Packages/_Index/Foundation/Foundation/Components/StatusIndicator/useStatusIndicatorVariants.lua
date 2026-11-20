-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local Flags = require(Foundation.Utility.Flags)

local StatusIndicatorSize = require(Foundation.Enums.StatusIndicatorSize)

local StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)

local StatusIndicatorShape = require(Foundation.Enums.StatusIndicatorShape)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local indexBindable = require(Foundation.Utility.indexBindable)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local devAssert = require(Foundation.Utility.devAssert)

local Constants = require(Foundation.Constants)
local getStatusIndicatorSize = require(script.Parent.getStatusIndicatorSize)

local font = Font.new(Constants.BUILDER_SANS_FONT_ASSET, Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)

function variantsFactory(arg1)
    local common = {
        content = {
            tag = "auto-xy text-align-x-left",
            font = font,
            typography = arg1.Typography.LabelSmall
        },
        stroke = Flags.FoundationStatusIndicatorDesignUpdate and {
            Thickness = arg1.Stroke.Thicker
        } or nil
    }

    local variants = {
        [StatusIndicatorVariant.Alert] = {
            container = { tag = "bg-system-alert" },
            content = {
                style = arg1.DarkMode.Content.Emphasis
            }
        },
        [StatusIndicatorVariant.Success] = {
            container = { tag = "bg-system-success" },
            content = {
                style = arg1.LightMode.Content.Emphasis
            }
        },
        [StatusIndicatorVariant.Warning] = {
            container = { tag = "bg-system-warning" },
            content = {
                style = arg1.LightMode.Content.Emphasis
            }
        },
        [StatusIndicatorVariant.Emphasis] = {
            container = { tag = "bg-system-emphasis" },
            content = {
                style = arg1.DarkMode.Content.Emphasis
            }
        },
        [StatusIndicatorVariant.Neutral] = {
            container = { tag = "bg-system-neutral" },
            content = {
                style = arg1.Inverse.Content.Emphasis
            }
        },
        [StatusIndicatorVariant.Standard] = {
            container = { tag = "bg-action-standard" },
            content = {
                style = arg1.Color.Content.Emphasis
            }
        },
        [StatusIndicatorVariant.Contrast_Experiment] = {
            container = { tag = "bg-system-contrast" },
            content = {
                style = arg1.Inverse.Content.Emphasis
            }
        },
        [StatusIndicatorVariant.Voice] = {
            container = {
                backgroundStyle = arg1.Color.Extended.Orange.Orange_600
            }
        }
    }

    local hasValue = {
        [true] = {
            container = {
                tag = if Flags.FoundationStatusIndicatorDesignUpdate then "row align-x-center align-y-center auto-x padding-xsmall" else "row align-x-center align-y-center size-400-400 auto-x padding-xsmall"
            }
        }
    }

    local shape = {
        [StatusIndicatorShape.Circle] = {
            container = { tag = "radius-circle" },
            stroke = {
                LineJoinMode = Enum.LineJoinMode.Round
            }
        },
        [StatusIndicatorShape.Ring] = {
            container = { tag = "align-x-center align-y-center radius-circle" },
            ring = { tag = "radius-circle bg-surface-100" },
            stroke = {
                LineJoinMode = Enum.LineJoinMode.Round
            }
        },
        [StatusIndicatorShape.Square] = {
            container = { tag = "radius-none" },
            stroke = {
                LineJoinMode = Enum.LineJoinMode.Miter
            }
        }
    }
    local function squareSize(arg2, bool1: boolean, num1: number?): UDim2 -- Luacid: unused: defined but never referenced
        local var1 = getStatusIndicatorSize(arg1, arg2, bool1) * (num1 or 1)
        return UDim2.fromOffset(var1, var1)
    end

    local sizes = {}
    local xSmall = StatusIndicatorSize.XSmall
    local tbl6 = { container = 0, ring = 0, stroke = 0 }
    local container = { size = 0 }
    local xSmall2 = StatusIndicatorSize.XSmall
    local var1 = getStatusIndicatorSize(arg1, xSmall2, false) * 1
    container.size = UDim2.fromOffset(var1, var1)
    tbl6.container = container
    local ring = { size = 0 }
    local xSmall3 = StatusIndicatorSize.XSmall
    local var2 = getStatusIndicatorSize(arg1, xSmall3, false) * 0.5
    ring.size = UDim2.fromOffset(var2, var2)
    tbl6.ring = ring
    tbl6.stroke = not Flags.FoundationStatusIndicatorDesignUpdate and {
        Thickness = arg1.Stroke.Standard
    } or nil
    sizes[xSmall] = tbl6

    local small = StatusIndicatorSize.Small
    local tbl9 = { container = 0, ring = 0, stroke = 0 }
    local tbl1 = { size = 0 }
    local small2 = StatusIndicatorSize.Small
    local var3 = getStatusIndicatorSize(arg1, small2, false) * 1
    tbl1.size = UDim2.fromOffset(var3, var3)
    tbl9.container = tbl1
    local tbl2 = { size = 0 }
    local small3 = StatusIndicatorSize.Small
    local var4 = getStatusIndicatorSize(arg1, small3, false) * 0.5
    tbl2.size = UDim2.fromOffset(var4, var4)
    tbl9.ring = tbl2
    tbl9.stroke = not Flags.FoundationStatusIndicatorDesignUpdate and {
        Thickness = arg1.Size.Size_50
    } or nil
    sizes[small] = tbl9

    local medium = StatusIndicatorSize.Medium
    local tbl12 = { container = 0, ring = 0, stroke = 0 }
    local tbl3 = { size = 0 }
    local medium2 = StatusIndicatorSize.Medium
    local var5 = getStatusIndicatorSize(arg1, medium2, false) * 1
    tbl3.size = UDim2.fromOffset(var5, var5)
    tbl12.container = tbl3
    local tbl4 = { size = 0 }
    local medium3 = StatusIndicatorSize.Medium
    local var6 = getStatusIndicatorSize(arg1, medium3, false) * 0.5
    tbl4.size = UDim2.fromOffset(var6, var6)
    tbl12.ring = tbl4
    tbl12.stroke = not Flags.FoundationStatusIndicatorDesignUpdate and {
        Thickness = arg1.Size.Size_50
    } or nil
    sizes[medium] = tbl12

    local large = StatusIndicatorSize.Large
    local tbl15 = { container = 0, ring = 0, stroke = 0 }
    local tbl5 = { size = 0 }
    local large2 = StatusIndicatorSize.Large
    local var7 = getStatusIndicatorSize(arg1, large2, false) * 1
    tbl5.size = UDim2.fromOffset(var7, var7)
    tbl15.container = tbl5
    local tbl7 = { size = 0 }
    local large3 = StatusIndicatorSize.Large
    local var8 = getStatusIndicatorSize(arg1, large3, false) * 0.5
    tbl7.size = UDim2.fromOffset(var8, var8)
    tbl15.ring = tbl7
    tbl15.stroke = {
        Thickness = arg1.Stroke.Thicker
    }
    sizes[large] = tbl15

    local pictogram = StatusIndicatorSize.Pictogram
    local tbl18 = { container = 0, ring = 0, stroke = 0 }
    local tbl8 = { size = 0 }
    local pictogram2 = StatusIndicatorSize.Pictogram
    local var9 = getStatusIndicatorSize(arg1, pictogram2, false) * 1
    tbl8.size = UDim2.fromOffset(var9, var9)
    tbl18.container = tbl8
    local tbl10 = { size = 0 }
    local pictogram3 = StatusIndicatorSize.Pictogram
    local var10 = getStatusIndicatorSize(arg1, pictogram3, false) * 0.5
    tbl10.size = UDim2.fromOffset(var10, var10)
    tbl18.ring = tbl10
    tbl18.stroke = {
        Thickness = arg1.Stroke.Thicker
    }
    sizes[pictogram] = tbl18

    local tbl21 = { container = 0 }
    local tbl11 = { size = 0 }
    local small4 = StatusIndicatorSize.Small
    local var11 = getStatusIndicatorSize(arg1, small4, true) * 1
    tbl11.size = UDim2.fromOffset(var11, var11)
    tbl21.container = tbl11

    local tbl23 = { container = 0, content = 0 }
    local tbl13 = { size = 0 }
    local large4 = StatusIndicatorSize.Large
    local var12 = getStatusIndicatorSize(arg1, large4, true) * 1
    tbl13.size = UDim2.fromOffset(var12, var12)
    tbl23.container = tbl13
    tbl23.content = {
        typography = arg1.Typography.LabelMedium
    }

    local tbl25 = {
        [StatusIndicatorSize.XSmall] = tbl21,
        [StatusIndicatorSize.Small] = tbl21,
        [StatusIndicatorSize.Medium] = tbl21,
        [StatusIndicatorSize.Large] = tbl23,
        [StatusIndicatorSize.Pictogram] = tbl23
    }

    local tbl26 = {
        common = common,
        variants = variants,
        hasValue = hasValue,
        shape = shape,
        sizes = sizes,
        numericSizes = 0
    }

    if not Flags.FoundationStatusIndicatorDesignUpdate then
        tbl25 = nil
    end

    tbl26.numericSizes = tbl25
    return tbl26
end

return function(arg1, arg2, bool1: boolean, arg3, arg4, arg5)
    devAssert(arg2 ~= StatusIndicatorVariant.Contrast_Experiment, "Contrast is not a supported StatusIndicator variant.")

    devAssert(
        not (arg2 == StatusIndicatorVariant.Alert and bool1),
        "Alert is not a supported numeric StatusIndicator variant."
    )

    local var1 = arg5 and {
        stroke = {
            Color = indexBindable(arg5, "Color3"),
            Transparency = indexBindable(arg5, "Transparency")
        }
    }
        or nil

    local var2 = VariantsContext.useVariants("StatusIndicator", variantsFactory, arg1)

    return composeStyleVariant(
        var2.common,
        var2.variants[arg2],
        var2.hasValue[bool1],
        var2.shape[arg3],
        if Flags.FoundationStatusIndicatorDesignUpdate then if bool1 then var2.numericSizes[arg4] else var2.sizes[arg4] else bool1 and {} or var2.sizes[arg4],
        var1
    )
end
