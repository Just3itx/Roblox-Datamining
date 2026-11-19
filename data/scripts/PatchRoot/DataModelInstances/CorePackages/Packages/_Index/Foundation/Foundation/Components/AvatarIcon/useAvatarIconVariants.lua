-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:20:27Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local AvatarIconSize = require(Foundation.Enums.AvatarIconSize)

local _Types = require(Foundation.Components.Types)

local indexBindable = require(Foundation.Utility.indexBindable)

local function composeStroke(arg1, thickness: number?): {[any]: any} | {container: {stroke: {Color: any, Thickness: number, Transparency: any}}}
    return if arg1 and thickness then {
        container = {
            stroke = {
                Color = indexBindable(arg1, "Color3"),
                Transparency = indexBindable(arg1, "Transparency"),
                Thickness = thickness
            }
        }
    } else {}
end

local function variantsFactory(arg1)
    return {
        strokes = {
            [true] = {
                [AvatarIconSize.XSmall] = arg1.Stroke.Standard,
                [AvatarIconSize.Small] = arg1.Stroke.Standard,
                [AvatarIconSize.Medium] = arg1.Stroke.Thick,
                [AvatarIconSize.Large] = arg1.Stroke.Thicker,
                [AvatarIconSize.XLarge] = arg1.Stroke.Thicker
            },
            [false] = {}
        },
        common = {
            container = { tag = "radius-circle" },
            avatar = { tag = "size-full radius-circle" }
        },
        sizes = {
            [AvatarIconSize.XSmall] = {
                container = {
                    size = arg1.Size.Size_300
                }
            },
            [AvatarIconSize.Small] = {
                container = {
                    size = arg1.Size.Size_400
                }
            },
            [AvatarIconSize.Medium] = {
                container = {
                    size = arg1.Size.Size_500
                }
            },
            [AvatarIconSize.Large] = {
                container = {
                    size = arg1.Size.Size_600
                }
            },
            [AvatarIconSize.XLarge] = {
                container = {
                    size = arg1.Size.Size_700
                }
            }
        }
    }
end

return function(arg1, arg2, arg3)
    local var1 = VariantsContext.useVariants("AvatarIcon", variantsFactory, arg1)

    return composeStyleVariant(var1.common, var1.sizes[arg2], (composeStroke(arg3, var1.strokes[arg3 ~= nil][arg2])))
end
