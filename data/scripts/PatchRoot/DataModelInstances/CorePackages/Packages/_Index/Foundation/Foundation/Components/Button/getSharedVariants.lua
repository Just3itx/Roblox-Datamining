-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:21:18Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Constants = require(Foundation.Constants)
local Dash = require(FoundationParent.Dash)
local _Types = require(Foundation.Components.Types)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)

local _StateLayerMode = require(Foundation.Enums.StateLayerMode)

local _composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local InputSize = require(Foundation.Enums.InputSize)

local function toStroke(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        Color = arg1.Color3,
        Transparency = arg1.Transparency
    }
end

local function createButtonVariantStyles(arg1, arg2, bool1: boolean?)
    local buttonVariantStyles = ({})
    for value in ColorNamespace do
        local var1 = arg1[value]
        local tbl1 = if type(arg2) == "table" then {
            Foreground = Dash.get(var1, arg2)
        } else var1[arg2]
        local tbl2 = { container = 0, content = 0 }
        local container = {
            style = tbl1.Background,
            stroke = 0,
            stateLayer = 0
        }
        local tbl4

        if tbl1.Border then
            tbl4 = toStroke(tbl1.Border)
        else
            tbl4 = nil
        end

        container.stroke = tbl4
        container.stateLayer = {
            mode = Constants.COLOR_NAMESPACE_TO_STATE_LAYER_MODE[bool1 or false][value]
        }
        tbl2.container = container

        tbl2.content = {
            style = tbl1.Foreground
        }
        buttonVariantStyles[value] = tbl2
    end

    return buttonVariantStyles
end

local function getButtonTypes(arg1)
    return {
        [ButtonVariant.Utility] = createButtonVariantStyles(arg1, "ActionUtility"),
        [ButtonVariant.Standard] = createButtonVariantStyles(arg1, "ActionStandard"),
        [ButtonVariant.Emphasis] = createButtonVariantStyles(arg1, "ActionEmphasis"),
        [ButtonVariant.Alert] = createButtonVariantStyles(arg1, "ActionAlert"),
        [ButtonVariant.SubEmphasis] = createButtonVariantStyles(arg1, "ActionSubEmphasis", true),
        [ButtonVariant.SoftEmphasis] = createButtonVariantStyles(arg1, "ActionSoftEmphasis"),
        [ButtonVariant.Subtle] = createButtonVariantStyles(arg1, "ActionSubtle"),
        [ButtonVariant.Text] = createButtonVariantStyles(arg1, { "Content", "Emphasis" }),
        [ButtonVariant.Link] = createButtonVariantStyles(arg1, { "Content", "Link" }),
        [ButtonVariant.OverMedia] = createButtonVariantStyles(arg1, "ActionOverMedia", true)
    }
end

local function getSizes(arg1)
    return {
        [InputSize.XSmall] = {
            container = {
                radius = arg1.Radius.Small,
                height = arg1.Size.Size_600
            }
        },
        [InputSize.Small] = {
            container = {
                radius = arg1.Radius.Medium,
                height = arg1.Size.Size_800
            }
        },
        [InputSize.Medium] = {
            container = {
                radius = arg1.Radius.Medium,
                height = arg1.Size.Size_1000
            }
        },
        [InputSize.Large] = {
            container = {
                radius = arg1.Radius.Medium,
                height = arg1.Size.Size_1200
            }
        }
    }
end

local function getSharedVariants(arg1)
    return {
        sizes = getSizes(arg1),
        types = getButtonTypes(arg1)
    }
end
return getSharedVariants
