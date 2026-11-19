-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:11:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local AlertSeverity = require(Foundation.Enums.AlertSeverity)

local AlertVariant = require(Foundation.Enums.AlertVariant)

local ColorMode = require(Foundation.Enums.ColorMode)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function createSeverityVariant(arg1, transparency: number, style, backgroundStyle)
    return {
        container = {
            backgroundStyle = {
                Color3 = arg1.Color3,
                Transparency = transparency
            }
        },
        icon = { style = style },
        border = { backgroundStyle = backgroundStyle }
    }
end

local function variantsFactory(arg1)
    local padding = {
        top = UDim.new(0, arg1.Size.Size_150 + 1)
    }
    local tbl1 = {
        top = UDim.new(0, arg1.Size.Size_150),
        bottom = UDim.new(0, arg1.Size.Size_150)
    }
    local size500 = arg1.Size.Size_500

    local tbl3 = {
        tag = "text-body-medium text-wrap text-align-x-left content-emphasis",
        padding = padding
    }
    local common = {
        main = {
            tag = "row align-y-top gap-medium size-full-0 auto-y padding-x-large padding-y-medium"
        },
        stack = { tag = "col fill gap-small auto-y" },
        iconFrame = {
            Size = UDim2.fromOffset(size500, size500)
        },
        message = tbl3,
        link = tbl3,
        border = {
            Size = UDim2.new(1, 0, 0, arg1.Stroke.Standard)
        }
    }

    local severity = {
        [AlertSeverity.Info] = createSeverityVariant(arg1.Color.System.Neutral, 0.9, arg1.Color.System.Emphasis, arg1.Color.Stroke.Emphasis),
        [AlertSeverity.Success] = createSeverityVariant(arg1.Color.System.Success, 0.9, arg1.Color.System.Success, arg1.Color.Stroke.Emphasis),
        [AlertSeverity.Warning] = createSeverityVariant(arg1.Color.System.Warning, 0.84, arg1.Color.System.Warning, arg1.Color.System.Warning),
        [AlertSeverity.Error] = createSeverityVariant(arg1.Color.System.Alert, 0.84, arg1.Color.System.Alert, arg1.Color.System.Alert)
    }

    local variants = {
        [AlertVariant.Feedback] = {
            container = {
                tag = "radius-medium row align-y-top gap-medium size-full-0 auto-y padding-x-large padding-y-medium"
            }
        },
        [AlertVariant.System] = {
            container = { tag = "col size-full-0 auto-y" }
        }
    }

    local tbl7 = {
        container = { tag = "stroke-standard stroke-emphasis" }
    }
    local strokes = {
        [AlertSeverity.Info] = tbl7,
        [AlertSeverity.Success] = tbl7,
        [AlertSeverity.Warning] = {
            container = { tag = "stroke-standard stroke-system-warning" }
        },
        [AlertSeverity.Error] = {
            container = { tag = "stroke-standard stroke-system-alert" }
        }
    }

    local var1 = size500 - arg1.Size.Size_100
    local iconBackplate = {
        Size = UDim2.fromOffset(var1, var1),
        Position = UDim2.fromOffset((size500 - var1) / 2, (size500 - var1) / 2),
        tag = "radius-circle",
        backgroundStyle = arg1.Color.Extended.White.White_100
    }
    return {
        common = common,
        severity = severity,
        variants = variants,
        strokes = strokes,
        backplates = {
            [AlertSeverity.Info] = { iconBackplate = iconBackplate },
            [AlertSeverity.Success] = { iconBackplate = iconBackplate },
            [AlertSeverity.Warning] = {},
            [AlertSeverity.Error] = { iconBackplate = iconBackplate }
        },
        isStacked = {
            [false] = {
                message = { tag = "fill auto-y" },
                link = { tag = "auto-xy" },
                linkContainer = { tag = "auto-xy" }
            },
            [true] = {
                message = { tag = "size-full-0 auto-y" },
                link = { tag = "size-full-0 auto-y", padding = tbl1 },
                linkContainer = { tag = "size-full-0 auto-y" }
            }
        }
    }
end

local function useAlertVariants(arg1, arg2, feedback, bool1: boolean)
    local var1 = VariantsContext.useVariants("Alert", variantsFactory, arg1)

    local bool2 = arg1.Config.ColorMode.Name == ColorMode.Dark
    return composeStyleVariant(
        var1.common,
        var1.severity[arg2],
        var1.variants[feedback],
        var1.isStacked[bool1],
        feedback ~= AlertVariant.Feedback and {} or var1.strokes[arg2],
        not bool2 and {} or var1.backplates[arg2]
    )
end

return useAlertVariants
