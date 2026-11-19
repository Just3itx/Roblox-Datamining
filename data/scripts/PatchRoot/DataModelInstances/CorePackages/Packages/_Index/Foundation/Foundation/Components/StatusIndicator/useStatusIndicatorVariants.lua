-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:01:07Z
-- Luau bytecode version: 9 | Luau type version: 3
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
    local sizes = {
        [StatusIndicatorSize.XSmall] = {
            container = {
                size = UDim2.fromOffset(arg1.Size.Size_150, arg1.Size.Size_150)
            },
            ring = {
                size = UDim2.fromOffset(arg1.Size.Size_150 / 2, arg1.Size.Size_150 / 2)
            },
            stroke = not Flags.FoundationStatusIndicatorDesignUpdate and {
                Thickness = arg1.Stroke.Standard
            } or nil
        },
        [StatusIndicatorSize.Small] = {
            container = {
                size = UDim2.fromOffset(arg1.Size.Size_200, arg1.Size.Size_200)
            },
            ring = {
                size = UDim2.fromOffset(arg1.Size.Size_200 / 2, arg1.Size.Size_200 / 2)
            },
            stroke = not Flags.FoundationStatusIndicatorDesignUpdate and {
                Thickness = arg1.Size.Size_50
            } or nil
        },
        [StatusIndicatorSize.Medium] = {
            container = {
                size = UDim2.fromOffset(arg1.Size.Size_250, arg1.Size.Size_250)
            },
            ring = {
                size = UDim2.fromOffset(arg1.Size.Size_250 / 2, arg1.Size.Size_250 / 2)
            },
            stroke = not Flags.FoundationStatusIndicatorDesignUpdate and {
                Thickness = arg1.Size.Size_50
            } or nil
        },
        [StatusIndicatorSize.Large] = {
            container = {
                size = UDim2.fromOffset(arg1.Size.Size_500, arg1.Size.Size_500)
            },
            ring = {
                size = UDim2.fromOffset(arg1.Size.Size_500 / 2, arg1.Size.Size_500 / 2)
            },
            stroke = {
                Thickness = arg1.Stroke.Thicker
            }
        },
        [StatusIndicatorSize.Pictogram] = {
            container = {
                size = UDim2.fromOffset(arg1.Size.Size_500, arg1.Size.Size_500)
            },
            ring = {
                size = UDim2.fromOffset(arg1.Size.Size_500 / 2, arg1.Size.Size_500 / 2)
            },
            stroke = {
                Thickness = arg1.Stroke.Thicker
            }
        }
    }
    local tbl6 = {
        container = {
            size = UDim2.fromOffset(arg1.Size.Size_400, arg1.Size.Size_400)
        }
    }
    local tbl7 = {
        container = {
            size = UDim2.fromOffset(arg1.Size.Size_500, arg1.Size.Size_500)
        },
        content = {
            typography = arg1.Typography.LabelMedium
        }
    }
    local tbl8 = {
        [StatusIndicatorSize.XSmall] = tbl6,
        [StatusIndicatorSize.Small] = tbl6,
        [StatusIndicatorSize.Medium] = tbl6,
        [StatusIndicatorSize.Large] = tbl7,
        [StatusIndicatorSize.Pictogram] = tbl7
    }

    local tbl9 = {
        common = common,
        variants = variants,
        hasValue = hasValue,
        shape = shape,
        sizes = sizes,
        numericSizes = 0
    }

    if not Flags.FoundationStatusIndicatorDesignUpdate then
        tbl8 = nil
    end

    tbl9.numericSizes = tbl8
    return tbl9
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
