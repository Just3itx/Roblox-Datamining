-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTileParent = script:FindFirstAncestor("GameTile").Parent
local Roact = require(GameTileParent.Roact)
local UserLib = require(GameTileParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions
local Constants2 = require(GameTileParent.AppChat.Constants)
local ImageSetLabel = require(GameTileParent.UIBlox).Core.ImageSet.ImageSetLabel
local GetImageData = require(GameTileParent.RobloxAppAssets).GetImageData
local Colors = require(GameTileParent.Style).Colors

local var1 = Roact.PureComponent:extend("FriendIcon")

var1.defaultProps = {
    layoutOrder = 0,
    maskColor = Colors.White,
    showBackground = true
}

function var1.render(arg1)
    local user = arg1.props.user
    local dotSize = arg1.props.dotSize
    local itemSize = arg1.props.itemSize
    local layoutOrder = arg1.props.layoutOrder
    local showBackground = arg1.props.showBackground

    local maskColor = arg1.props.maskColor

    local bool1 = dotSize ~= nil

    local presenceIndicatorSizeKey = Constants2:GetPresenceIndicatorSizeKey(dotSize)

    local var2 = nil
    local rbxthumbWithTypeSizeAndOptions

    if user then
        if bool1 then
            var2 = Constants2.PresenceIndicatorImagesBySize[presenceIndicatorSizeKey][user.presence]
        end

        rbxthumbWithTypeSizeAndOptions = getRbxthumbWithTypeSizeAndOptions(user.id, Constants.RbxthumbTypes.AvatarHeadShot, 48)
    else
        rbxthumbWithTypeSizeAndOptions = nil
    end

    return Roact.createElement("Frame", {
        BackgroundColor3 = Color3.fromRGB(209, 209, 209),
        BackgroundTransparency = if showBackground then 0 else 1,
        BorderSizePixel = 0,
        LayoutOrder = layoutOrder,
        Size = UDim2.new(0, itemSize, 0, itemSize)
    }, {
        Profile = Roact.createElement(ImageSetLabel, {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Image = GetImageData(rbxthumbWithTypeSizeAndOptions) or rbxthumbWithTypeSizeAndOptions,
            Size = UDim2.new(0, itemSize, 0, itemSize),
            ZIndex = 1
        }),
        Mask = showBackground
            and Roact.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Image = "rbxasset://textures/ui/LuaApp/graphic/gr-avatar-frame-36x36.png",
                ImageColor3 = maskColor,
                Size = UDim2.new(0, itemSize, 0, itemSize),
                ZIndex = 2
            })
            or nil,
        Dot = showBackground
            and bool1
            and Roact.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Image = var2,
                Position = UDim2.new(1, -dotSize, 1, -dotSize),
                Size = UDim2.new(0, dotSize, 0, dotSize),
                ZIndex = 3
            })
            or nil
    })
end

return var1
