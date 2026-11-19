-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:11:16Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local Flags = require(Foundation.Utility.Flags)
local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

local AvatarSize = require(Foundation.Enums.AvatarSize)

local UserPresence = require(Foundation.Enums.UserPresence)

local StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)

local StatusIndicatorSize = require(Foundation.Enums.StatusIndicatorSize)

local StatusIndicatorShape = require(Foundation.Enums.StatusIndicatorShape)

local _Types = require(Foundation.Components.Types)

local indexBindable = require(Foundation.Utility.indexBindable)

local function variantsFactory(arg1)
    local common = {
        container = { tag = "radius-circle" },
        avatar = { tag = "size-full radius-circle" },
        statusIndicatorMask = {
            ZIndex = 2,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -arg1.Size.Size_150 / 2, 1, -arg1.Size.Size_150 / 2),
            mask = arg1.Color.Surface.Surface_0
        }
    }

    local sizes = {
        [AvatarSize.XSmall] = {
            statusIndicator = {
                size = StatusIndicatorSize.XSmall
            }
        },
        [AvatarSize.Small] = {
            statusIndicator = {
                size = StatusIndicatorSize.XSmall
            }
        },
        [AvatarSize.Medium] = {
            statusIndicator = {
                size = StatusIndicatorSize.Small
            }
        },
        [AvatarSize.Large] = {
            statusIndicator = {
                size = StatusIndicatorSize.Small
            }
        },
        [AvatarSize.XLarge] = {
            statusIndicator = {
                size = StatusIndicatorSize.Medium
            }
        },
        [AvatarSize.Pictogram] = {
            statusIndicator = {
                size = if Flags.FoundationStatusIndicatorDesignUpdate then StatusIndicatorSize.Large else StatusIndicatorSize.Pictogram
            }
        }
    }

    local presence = {
        [UserPresence.InExperience] = {},
        [UserPresence.Away] = {
            statusIndicator = {
                shape = StatusIndicatorShape.Ring,
                variant = StatusIndicatorVariant.Neutral
            }
        },
        [UserPresence.Active] = {
            statusIndicator = {
                shape = StatusIndicatorShape.Circle,
                variant = StatusIndicatorVariant.Success
            }
        },
        [UserPresence.None] = {}
    }

    local sizeStrokes = {
        [AvatarSize.Small] = arg1.Stroke.Thicker,
        [AvatarSize.Medium] = arg1.Stroke.Thicker,
        [AvatarSize.Large] = arg1.Stroke.Thicker,
        [AvatarSize.XLarge] = arg1.Stroke.Thicker,
        [AvatarSize.Pictogram] = arg1.Stroke.Thicker + arg1.Stroke.Standard
    }

    return {
        common = common,
        sizes = sizes,
        presence = presence,
        iconSizeStrokes = {
            [AvatarSize.XSmall] = arg1.Stroke.Standard,
            [AvatarSize.Small] = arg1.Stroke.Thick,
            [AvatarSize.Medium] = arg1.Stroke.Thick,
            [AvatarSize.Large] = arg1.Stroke.Thicker,
            [AvatarSize.XLarge] = arg1.Stroke.Thicker,
            [AvatarSize.Pictogram] = arg1.Stroke.Thicker
        },
        sizeStrokes = sizeStrokes
    }
end

return function(arg1, arg2, arg3, backgroundStyle, bool1: boolean)
    local var1 = VariantsContext.useVariants("Avatar", variantsFactory, arg1)

    local isVisible = not bool1 and (arg3 == UserPresence.Active or arg3 == UserPresence.Away)
    local var2 = if bool1 or arg3 ~= UserPresence.InExperience then backgroundStyle else arg1.Color.System.Emphasis
    local thickness = if bool1 then var1.iconSizeStrokes[arg2] else var1.sizeStrokes[arg2]
    return composeStyleVariant(var1.common, var1.sizes[arg2], var1.presence[arg3], {
        container = {
            stroke = var2
                and {
                    Color = indexBindable(var2, "Color3"),
                    Transparency = indexBindable(var2, "Transparency"),
                    Thickness = thickness
                }
                or nil,
            backgroundStyle = backgroundStyle
        },
        statusIndicator = { isVisible = isVisible }
    })
end
