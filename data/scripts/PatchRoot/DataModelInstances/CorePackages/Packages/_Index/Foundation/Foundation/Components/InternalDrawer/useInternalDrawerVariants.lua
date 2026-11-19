-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:10:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local InternalDrawerLayout = require(Foundation.Enums.InternalDrawerLayout)
local InternalDrawerSide = require(Foundation.Enums.InternalDrawerSide)
local _Tokens = require(Foundation.Providers.Style.Tokens)
local _Types = require(Foundation.Components.Types)
local VariantsContext = require(Foundation.Providers.Style.VariantsContext)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function variantsFactory(arg1)
    return {
        common = {
            innerEdge = {
                backgroundStyle = arg1.Color.Stroke.Default,
                thickness = arg1.Stroke.Standard
            },
            shadow = { tag = "shadow-overlay-300" }
        },
        layout = {
            [InternalDrawerLayout.FullBleed] = {
                surface = { margin = 0 },
                innerEdge = { isVisible = true }
            },
            [InternalDrawerLayout.Inset] = {
                surface = {
                    tag = "stroke-standard stroke-default radius-large",
                    margin = arg1.Padding.Medium
                },
                innerEdge = { isVisible = false },
                shadow = { tag = "radius-large" }
            }
        },
        side = {
            [InternalDrawerSide.Start] = {
                surface = {
                    tag = "anchor-top-left",
                    anchorScaleX = 0,
                    openOffsetSign = 1,
                    hiddenOffsetSign = -1
                },
                innerEdge = { tag = "position-top-right anchor-top-right" },
                shadow = { tag = "anchor-top-left" }
            },
            [InternalDrawerSide.End] = {
                surface = {
                    tag = "anchor-top-left",
                    anchorScaleX = 1,
                    openOffsetSign = -1,
                    hiddenOffsetSign = 1
                },
                innerEdge = { tag = "position-top-left anchor-top-left" },
                shadow = { tag = "anchor-top-left" }
            }
        }
    }
end

local function useInternalDrawerVariants(arg1, arg2)
    local var1 = useTokens()
    local var2 = VariantsContext.useVariants("InternalDrawer", variantsFactory, var1)

    return composeStyleVariant(var2.common, var2.layout[arg1], var2.side[arg2])
end

return useInternalDrawerVariants
