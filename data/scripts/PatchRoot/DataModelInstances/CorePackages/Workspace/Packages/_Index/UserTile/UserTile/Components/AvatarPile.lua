-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserTileParent = script:FindFirstAncestor("UserTile").Parent
local React = require(UserTileParent.React)
local Foundation = require(UserTileParent.Foundation)
local UserLib = require(UserTileParent.UserLib)

local Image = Foundation.Image
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local useCumulativeBackground = Foundation.Hooks.useCumulativeBackground
local UserPresence = Foundation.Enums.UserPresence
local getStandardSizeAvatarHeadShotRbxthumb = UserLib.Utils.getStandardSizeAvatarHeadShotRbxthumb

local function AvatarPile(tbl1)
    local var1 = useTokens()
    local image = getStandardSizeAvatarHeadShotRbxthumb(tbl1.primaryUserId)
    local standardSizeAvatarHeadShotRbxthumb = getStandardSizeAvatarHeadShotRbxthumb(tbl1.secondUserId)
    local var2 = if tbl1.hover then var1.Color.Shift.Shift_400 else var1.Color.Shift.Shift_300
    local backgroundStyle = useCumulativeBackground(tbl1.altSurfaceBackground or var1.Color.Surface.Surface_0, var2)

    local createElement = React.createElement
    local var4 = View
    local tbl2 = {
        tag = "aspect-1-1 position-center-center anchor-center-center size-full-full",
        ZIndex = tbl1.ZIndex,
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        AvatarImage1 = React.createElement(Image, {
            LayoutOrder = 1,
            backgroundStyle = backgroundStyle,
            tag = {
                ["aspect-1-1 radius-circle row position-bottom-left anchor-bottom-left"] = true
            },
            Size = UDim2.fromScale(0.7, 0.7),
            Image = image,
            ZIndex = 2
        }),
        AvatarImage2 = React.createElement(Image, {
            LayoutOrder = 2,
            backgroundStyle = backgroundStyle,
            tag = { ["aspect-1-1 radius-circle row position-top-right anchor-top-right"] = true },
            Size = UDim2.fromScale(0.7, 0.7),
            Image = standardSizeAvatarHeadShotRbxthumb,
            ZIndex = 1
        }),
        Icon = 0
    }
    local element

    if tbl1.userPresenceType == UserPresence.Active or tbl1.userPresenceType == UserPresence.InExperience then
        element = React.createElement(Image, {
            tag = "bg-surface-100 radius-circle auto-xy position-absolute",
            Image = "component_assets/circle_16",
            Size = UDim2.new(0.125, 4, 0.125, 4),
            Position = UDim2.new(0.8536, var1.Stroke.Thicker, 0.8536, var1.Stroke.Thicker),
            AnchorPoint = Vector2.new(0.5, 0.5),
            stroke = {
                Thickness = var1.Stroke.Thicker,
                Color = var1.Color.Surface.Surface_100.Color3
            },
            imageStyle = var1.Color.System.Success
        })
    else
        element = nil
    end

    tbl3.Icon = element
    return createElement(var4, tbl2, tbl3)
end

return AvatarPile
