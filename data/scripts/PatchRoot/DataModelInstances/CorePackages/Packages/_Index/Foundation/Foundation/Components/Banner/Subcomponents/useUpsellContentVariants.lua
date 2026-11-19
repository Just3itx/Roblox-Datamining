-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:20:46Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Types = require(Foundation.Components.Types)

local CardDensity = require(Foundation.Enums.CardDensity)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local _Thumbnail = require(script.Parent.Thumbnail)

local function variantsFactory(arg1)
    local bodySmall = arg1.Typography.BodySmall

    local function descriptionSizeConstraint(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        return {
            MaxSize = Vector2.new(math.huge, bodySmall.FontSize * bodySmall.LineHeight * num1)
        }
    end

    return {
        common = {
            container = { tag = "row align-y-center gap-medium size-full-0 auto-y" },
            content = { tag = "col fill auto-y" },
            title = {
                tag = "size-full-0 auto-y text-title-medium text-wrap text-align-x-left content-emphasis"
            },
            description = {
                tag = "size-full-0 auto-y text-body-small text-wrap text-align-x-left content-emphasis"
            }
        },
        densities = {
            [CardDensity.Compact] = {
                description = {
                    sizeConstraint = descriptionSizeConstraint(1)
                }
            },
            [CardDensity.Default] = {
                description = {
                    sizeConstraint = descriptionSizeConstraint(2)
                }
            }
        }
    }
end

return function(arg1, arg2)
    local var1 = VariantsContext.useVariants("Banner.UpsellContent", variantsFactory, arg1)
    return composeStyleVariant(var1.common, var1.densities[arg2])
end
