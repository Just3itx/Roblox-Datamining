-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKit = script:FindFirstAncestor("AvatarExperienceUIKit")
local AvatarExperienceUIKitParent = AvatarExperienceUIKit.Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local BackgroundLayers = require(AvatarExperienceUIKit.BackgroundLayers.BackgroundLayers)

local function ItemCardBackgroundsWrapper(tbl1)
    local var1 = useTokens()
    return React.createElement(React.Fragment, nil, {
        ItemCardBackgrounds = React.createElement(BackgroundLayers, {
            backgroundLayers = tbl1.backgroundLayers,
            cornerRadius = UDim.new(0, var1.Radius.Medium),
            ZIndex = 0,
            imageScaleType = tbl1.imageScaleType
        }),
        ItemCardContent = React.createElement(
            View,
            { tag = "col gap-small size-full-0 auto-y padding-small", ZIndex = 1 },
            {
                ItemCardHeaderSlot = tbl1.headerSlot,
                ItemCardFooterSlot = tbl1.footerSlot
            }
        )
    })
end
return ItemCardBackgroundsWrapper
