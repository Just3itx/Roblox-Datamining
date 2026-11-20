-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local AlertSeverity = require(Foundation.Enums.AlertSeverity)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local function createSeverityStyles(_, style)
    return {
        icon = { style = style },
        stroke = {
            Color = style.Color3,
            Transparency = style.Transparency,
            Thickness = 1
        },
        backgroundStyle = {
            Color3 = style.Color3,
            Transparency = 0.95
        }
    }
end

local function variantsFactory(arg1)
    return {
        common = {
            container = {
                tag = "col align-x-left align-y-center gap-medium size-full-0 auto-y padding-large radius-medium"
            },
            headerRow = { tag = "row align-y-center gap-medium size-full-0 auto-y" },
            title = {
                tag = "shrink auto-xy text-title-medium text-truncate-split content-emphasis"
            },
            subtitle = {
                tag = "shrink auto-xy text-body-medium text-truncate-split content-default"
            },
            description = {
                tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left text-truncate-split content-default"
            },
            link = { tag = "shrink auto-xy text-body-medium text-truncate-split content-emphasis" }
        },
        severity = {
            [AlertSeverity.Info] = createSeverityStyles(arg1, arg1.Color.System.Emphasis),
            [AlertSeverity.Warning] = createSeverityStyles(arg1, arg1.Color.System.Warning),
            [AlertSeverity.Success] = createSeverityStyles(arg1, arg1.Color.System.Success),
            [AlertSeverity.Error] = createSeverityStyles(arg1, arg1.Color.System.Alert)
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("FeedbackAlert", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.severity[arg2])
end
