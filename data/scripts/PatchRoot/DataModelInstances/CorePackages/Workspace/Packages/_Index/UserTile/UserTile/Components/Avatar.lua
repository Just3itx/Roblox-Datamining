-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserTile = script:FindFirstAncestor("UserTile")
local UserTileParent = UserTile.Parent
local React = require(UserTileParent.React)
local Foundation = require(UserTileParent.Foundation)
local UserLib = require(UserTileParent.UserLib)
local useTokens = Foundation.Hooks.useTokens
local UserPresence = Foundation.Enums.UserPresence
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local Icon = Foundation.Icon
local Image = Foundation.Image
local View = Foundation.View

local getStandardSizeAvatarHeadShotRbxthumb = UserLib.Utils.getStandardSizeAvatarHeadShotRbxthumb
local FFlagUserTileShowShimmerWhenLoading = require(UserTile.Flags.FFlagUserTileShowShimmerWhenLoading)
local FFlagAddBackplateSupportToUserTile = require(UserTileParent.SharedFlags).FFlagAddBackplateSupportToUserTile
local FFlagUserTileAvatarOverlayIcon = require(UserTileParent.SharedFlags).FFlagUserTileAvatarOverlayIcon
local FFlagUserTileUseProfileFrameThumbnail = require(UserTile.Flags.FFlagUserTileUseProfileFrameThumbnail)
local FFlagUserTileIncludeProfileFrameProp = require(UserTile.Flags.FFlagUserTileIncludeProfileFrameProp)

local function Avatar(tbl1)
    local var1 = FFlagUserTileUseProfileFrameThumbnail
    if FFlagUserTileIncludeProfileFrameProp and tbl1.includeProfileFrame ~= nil then
        var1 = var1 and tbl1.includeProfileFrame
    end

    local image = if FFlagUserTileShowShimmerWhenLoading and tbl1.avatarThumbnailUrl then tbl1.avatarThumbnailUrl else getStandardSizeAvatarHeadShotRbxthumb(tbl1.userId, var1)
    local var3 = useTokens()
    local backgroundStyle = if tbl1.hover then var3.Color.Shift.Shift_400 else var3.Color.Shift.Shift_300
    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = "aspect-1-1 position-center-center anchor-center-center size-full-full",
        ZIndex = tbl1.ZIndex,
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        Backplate = if FFlagAddBackplateSupportToUserTile and tbl1.backplateStyle then React.createElement(View, {
            backgroundStyle = tbl1.backplateStyle,
            tag = "position-center-center anchor-center-center radius-circle",
            Size = UDim2.new(1, 14, 1, 14),
            ZIndex = 0
        }) else nil,
        AvatarThumbnail = 0,
        Icon = 0
    }

    local createElement2 = React.createElement
    local var6 = View
    local tbl4 = { tag = "size-full position-center-center anchor-center-center" }

    local tbl5 = {
        AvatarImage = React.createElement(Image, {
            LayoutOrder = 1,
            backgroundStyle = backgroundStyle,
            tag = "size-full aspect-1-1 radius-circle align-x-center align-y-center row position-center-center anchor-center-center",
            Image = image,
            ZIndex = 3
        }),
        GradientOverlay = 0
    }
    local element

    if FFlagUserTileAvatarOverlayIcon and tbl1.overlayIcon then
        element = React.createElement(View, {
            backgroundStyle = var3.Color.Surface.Surface_0,
            tag = "position-center-center anchor-center-center size-full aspect-1-1 radius-circle",
            ZIndex = 4
        }, {
            Gradient = React.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1),
                    NumberSequenceKeypoint.new(0.6027, 1),
                    NumberSequenceKeypoint.new(0.7682, 0.53),
                    NumberSequenceKeypoint.new(1, 0)
                })
            }),
            OverlayIconContainer = React.createElement(
                View,
                {
                    tag = "position-bottom-center anchor-bottom-center auto-xy padding-bottom-medium",
                    ZIndex = 5
                },
                {
                    OverlayIcon = React.createElement(Icon, {
                        name = tbl1.overlayIcon,
                        variant = IconVariant.Filled,
                        size = IconSize.Medium,
                        style = var3.Color.Content.Emphasis,
                        ZIndex = 5
                    })
                }
            )
        })
    else
        element = nil
    end

    tbl5.GradientOverlay = element
    tbl3.AvatarThumbnail = createElement2(var6, tbl4, tbl5)
    local element2

    if tbl1.userPresenceType == UserPresence.Active or tbl1.userPresenceType == UserPresence.InExperience then
        element2 = React.createElement(Image, {
            tag = "bg-surface-100 radius-circle auto-xy position-absolute",
            Image = "component_assets/circle_16",
            Size = UDim2.new(0.125, 4, 0.125, 4),
            Position = UDim2.new(0.8536, var3.Stroke.Thicker, 0.8536, var3.Stroke.Thicker),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ZIndex = if FFlagUserTileAvatarOverlayIcon then 5 else nil,
            stroke = {
                Thickness = var3.Stroke.Thicker,
                Color = var3.Color.Surface.Surface_100.Color3
            },
            imageStyle = var3.Color.System.Success
        })
    else
        element2 = nil
    end

    tbl3.Icon = element2
    return createElement(var5, tbl2, tbl3)
end

return Avatar
