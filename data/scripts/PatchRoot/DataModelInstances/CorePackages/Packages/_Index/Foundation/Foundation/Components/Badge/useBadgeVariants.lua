-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BadgeVariant = require(Foundation.Enums.BadgeVariant)
local Dash = require(FoundationParent.Dash)

local BadgeShape = require(Foundation.Enums.BadgeShape)

local BadgeSize = require(Foundation.Enums.BadgeSize)

local IconPosition = require(Foundation.Enums.IconPosition)

local IconSize = require(Foundation.Enums.IconSize)

local _Types = require(Foundation.Components.Types)

local composeStyleVariant = require(Foundation.Utility.composeStyleVariant)

local Flags = require(Foundation.Utility.Flags)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local VariantsContext = require(Foundation.Providers.Style.VariantsContext)

function variantsFactory(arg1)
    local common = {
        container = {
            tag = if Flags.FoundationBadgeBetaUpdate then "row align-x-center align-y-center auto-xy" else "row align-x-center align-y-center gap-xsmall"
        },
        text = {
            tag = if Flags.FoundationBadgeBetaUpdate then "auto-xy text-align-x-left text-truncate-split" else "auto-xy text-label-small text-align-x-left text-truncate-split"
        }
    }

    local variants = {
        [BadgeVariant.Alert] = {
            container = {
                backgroundStyle = Flags.FoundationBadgeBetaUpdate and {
                    Color3 = arg1.Color.System.Alert.Color3,
                    Transparency = 0.8
                }
                    or arg1.Color.System.Alert
            },
            content = {
                style = if Flags.FoundationBadgeBetaUpdate then arg1.Color.Content.Emphasis else arg1.DarkMode.Content.Emphasis
            },
            icon = {
                style = arg1.Color.System.Alert
            }
        },
        [BadgeVariant.Success] = {
            container = {
                backgroundStyle = Flags.FoundationBadgeBetaUpdate and {
                    Color3 = arg1.Color.System.Success.Color3,
                    Transparency = 0.8
                }
                    or arg1.Color.System.Success
            },
            content = {
                style = if Flags.FoundationBadgeBetaUpdate then arg1.Color.Content.Emphasis else arg1.LightMode.Content.Emphasis
            },
            icon = {
                style = arg1.Color.System.Success
            }
        },
        [BadgeVariant.Warning] = {
            container = {
                backgroundStyle = Flags.FoundationBadgeBetaUpdate and {
                    Color3 = arg1.Color.System.Warning.Color3,
                    Transparency = 0.8
                }
                    or arg1.Color.System.Warning
            },
            content = {
                style = if Flags.FoundationBadgeBetaUpdate then arg1.Color.Content.Emphasis else arg1.LightMode.Content.Emphasis
            },
            icon = {
                style = arg1.Color.System.Warning
            }
        },
        [BadgeVariant.Contrast] = {
            container = {
                backgroundStyle = arg1.Color.System.Contrast
            },
            content = {
                style = arg1.Inverse.Content.Emphasis
            },
            icon = {
                style = arg1.Inverse.Content.Emphasis
            }
        },
        [BadgeVariant.Standard] = {
            container = {
                backgroundStyle = arg1.Color.ActionStandard.Background
            },
            content = {
                style = arg1.Color.ActionStandard.Foreground
            },
            icon = {
                style = arg1.Color.ActionStandard.Foreground
            }
        },
        [BadgeVariant.Neutral] = not Flags.FoundationBadgeBetaUpdate
            and {
                container = {
                    backgroundStyle = arg1.Color.Shift.Shift_300
                },
                content = {
                    style = arg1.Color.Content.Emphasis
                },
                icon = {
                    style = arg1.Color.ActionStandard.Foreground
                }
            }
            or nil,
        [BadgeVariant.OverMedia] = {
            container = {
                backgroundStyle = if Flags.FoundationBadgeOverMediaAdaptive then arg1.Color.OverMedia.OverMedia_0 else arg1.LightMode.Surface.Surface_100,
                stroke = not Flags.FoundationBadgeOverMediaAdaptive
                    and {
                        Color = arg1.LightMode.Stroke.Default.Color3,
                        Transparency = arg1.LightMode.Stroke.Default.Transparency
                    }
                    or nil
            },
            content = {
                style = if Flags.FoundationBadgeOverMediaAdaptive then arg1.Inverse.OverMedia.OverMedia_0 else arg1.LightMode.Content.Emphasis
            },
            icon = {
                style = if Flags.FoundationBadgeOverMediaAdaptive then arg1.Inverse.OverMedia.OverMedia_0 else arg1.LightMode.Content.Emphasis
            }
        },
        [BadgeVariant.OverMediaWhite] = {
            container = {
                backgroundStyle = arg1.LightMode.Surface.Surface_100,
                stroke = {
                    Color = arg1.LightMode.Stroke.Default.Color3,
                    Transparency = arg1.LightMode.Stroke.Default.Transparency
                }
            },
            content = {
                style = arg1.LightMode.Content.Emphasis
            },
            icon = {
                style = arg1.LightMode.Content.Emphasis
            }
        },
        [BadgeVariant.Emphasis] = {
            container = {
                backgroundStyle = arg1.Color.System.Emphasis
            },
            content = {
                style = arg1.DarkMode.Content.Emphasis
            },
            icon = {
                style = arg1.DarkMode.Content.Emphasis
            }
        }
    }

    local var1 = not Flags.FoundationBadgeBetaUpdate
        and {
            [true] = {
                container = { tag = "size-600" }
            },
            [false] = {
                container = { tag = "size-0-600 auto-x padding-x-small" }
            }
        }
        or nil
    local tbl3

    if Flags.FoundationBadgeBetaUpdate then
        tbl3 = {
            [BadgeSize.XSmall] = {
                container = { tag = "gap-xxsmall size-0-400 padding-x-xsmall" },
                text = { tag = "text-caption-small" },
                icon = {
                    size = IconSize.XSmall
                }
            },
            [BadgeSize.Small] = {
                container = { tag = "gap-xsmall size-0-600 padding-x-small" },
                text = { tag = "text-caption-medium" },
                icon = {
                    size = IconSize.XSmall
                }
            },
            [BadgeSize.Medium] = {
                container = { tag = "gap-xsmall size-0-600 padding-x-small" },
                text = { tag = "text-caption-medium" },
                icon = {
                    size = IconSize.XSmall
                }
            }
        }
    else
        tbl3 = nil
    end

    local shapes = {
        [BadgeShape.Pill] = {
            container = { tag = "radius-circle" }
        },
        [BadgeShape.Box] = {
            container = { tag = "radius-small" }
        }
    }
    local tbl5 = if Flags.FoundationBadgeBetaUpdate then {
        [IconPosition.Left] = {
            text = { tag = "padding-right-xsmall" }
        },
        [IconPosition.Right] = {
            text = { tag = "padding-left-xsmall" }
        },
        [Dash.None] = {
            text = { tag = "padding-x-xsmall" }
        }
    } else nil
    local tbl6 = {
        common = common,
        variants = variants,
        shapes = shapes,
        iconOnly = 0,
        sizes = 0,
        iconPlacement = 0
    }

    if Flags.FoundationBadgeBetaUpdate then
        var1 = nil
    end

    tbl6.iconOnly = var1
    tbl6.sizes = tbl3
    tbl6.iconPlacement = tbl5
    return tbl6
end

return function(arg1, arg2, arg3, arg4, arg5, bool1: boolean)
    local var1 = VariantsContext.useVariants("Badge", variantsFactory, arg1)
    return composeStyleVariant(
        var1.common,
        var1.variants[arg2],
        var1.shapes[arg3],
        if Flags.FoundationBadgeBetaUpdate then var1.sizes[arg4] else nil,
        if Flags.FoundationBadgeBetaUpdate then var1.iconPlacement[arg5 or Dash.None] else nil,
        if Flags.FoundationBadgeBetaUpdate then nil else var1.iconOnly[bool1]
    )
end
