-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:30:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenu = script:FindFirstAncestor("FriendsMenu")
local FriendsMenuParent = FriendsMenu.Parent

local React = require(FriendsMenuParent.React)
local getRbxthumbWithTypeSizeAndOptions = require(FriendsMenuParent.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions
local UserLib = require(FriendsMenuParent.UserLib)
local FFlagFriendsMenuUseProfileFrameThumbnail = require(FriendsMenu.Flags.FFlagFriendsMenuUseProfileFrameThumbnail)
local UIBlox = require(FriendsMenuParent.UIBlox)
local Foundation = require(FriendsMenuParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

local UserModel = require(FriendsMenuParent.UserLib).Models.UserModel
local _friendsMenuModalType = require(FriendsMenu.friendsMenuModalType)

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local IconSize = UIBlox.App.Constant.IconSize
local Images = UIBlox.App.ImageSet.Images
local useStyle = UIBlox.Core.Style.useStyle

local Constants = UserLib.Utils.Constants

local Size150x150 = Constants.RbxThumbnailSizes.Size150x150
local AvatarHeadShot = Constants.RbxthumbTypes.AvatarHeadShot

local tbl1 = {
    [UserModel.PresenceType.ONLINE] = {
        Image = "component_assets/circle_16",
        Color = Color3.fromRGB(0, 180, 109),
        Size = UDim2.new(0, 12, 0, 12)
    },
    [UserModel.PresenceType.IN_GAME] = { Image = "icons/menu/games_small" },
    [UserModel.PresenceType.IN_STUDIO] = { Image = "icons/logo/studiologo_small" }
}

return function(tbl2)
    local friend = tbl2.friend
    assert(friend, "friend should be non-nil. Silence type checker.")
    local var1 = useStyle()

    local image = React.useMemo(function()
        local rbxthumbWithTypeSizeAndOptions

        if friend then
            local var2 = Constants.RbxThumbnailSizeToNumberSize[Size150x150]
            rbxthumbWithTypeSizeAndOptions = getRbxthumbWithTypeSizeAndOptions(friend.id, AvatarHeadShot, var2, nil, nil, FFlagFriendsMenuUseProfileFrameThumbnail)
        else
            rbxthumbWithTypeSizeAndOptions = nil
        end

        return rbxthumbWithTypeSizeAndOptions or "rbxasset://textures/ui/LuaApp/graphic/ph-avatar-portrait.png"
    end, { friend })

    local playerBackgroundDefault = var1.Theme.PlayerBackgroundDefault
    local var3 = if friend.presence == UserModel.PresenceType.OFFLINE then nil else tbl1[UserModel.PresenceType.ONLINE]
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        Size = tbl2.size,
        Position = tbl2.position,
        AnchorPoint = tbl2.anchorPoint,
        BackgroundTransparency = 1
    }
    local tbl4 = {
        Background = playerBackgroundDefault
            and React.createElement("Frame", {
                Size = tbl2.size,
                Position = tbl2.position,
                AnchorPoint = tbl2.anchorPoint,
                BackgroundColor3 = var1.Theme.UIDefault.Color,
                BackgroundTransparency = var1.Theme.UIDefault.Transparency
            }, {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
            }),
        Thumbnail = tbl2.isFetchingFriends and React.createElement(Skeleton, { Size = UDim2.new(1, 0, 1, 0), radius = Radius.Circle })
            or React.createElement(
                ImageSetLabel,
                {
                    Size = tbl2.size,
                    Position = tbl2.position,
                    AnchorPoint = tbl2.anchorPoint,
                    Image = image,
                    BorderSizePixel = 0,
                    BackgroundColor3 = var1 and var1.Theme.UIDefault.Color,
                    BackgroundTransparency = if playerBackgroundDefault then 1 else var1.Theme.UIDefault.Transparency
                },
                {
                    Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
                }
            ),
        PresenceIcon = 0
    }
    local element

    if var3 and not tbl2.isFetchingFriends then
        element = React.createElement(ImageSetLabel, {
            Image = Images[var3.Image],
            BackgroundTransparency = 0,
            BackgroundColor3 = tbl2.isHoverRow and var1.Theme.BackgroundOnHover.Color or var1.Theme.BackgroundDefault.Color,
            ImageColor3 = var3.Color,
            Position = UDim2.new(1, -1, 1, -1),
            AnchorPoint = Vector2.new(1, 1),
            Size = var3.Size or UDim2.new(0, IconSize.Small, 0, IconSize.Small),
            ZIndex = 2
        }, {
            Border = React.createElement("UIStroke", {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                Color = var1.Theme.BackgroundDefault.Color,
                Transparency = var1.Theme.BackgroundDefault.Transparency,
                Thickness = 3
            }),
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
        })
            or nil
    else
        element = nil
    end

    tbl4.PresenceIcon = element
    return createElement(str1, tbl3, tbl4)
end
