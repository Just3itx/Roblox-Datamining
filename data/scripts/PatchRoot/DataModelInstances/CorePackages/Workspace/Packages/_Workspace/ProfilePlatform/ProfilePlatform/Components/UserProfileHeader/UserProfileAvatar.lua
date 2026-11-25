-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local UIBlox = require(ProfilePlatformParent.UIBlox)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images
local React = require(ProfilePlatformParent.React)
local useStyle = UIBlox.Core.Style.useStyle
local useStyleMetadata = UIBlox.Core.Style.useStyleMetadata
local Foundation = require(ProfilePlatformParent.Foundation)
local View = Foundation.View
local Image = Foundation.Image

local Constants = require(ProfilePlatform.Common.Constants)
local DisplayBackground = require(ProfilePlatformParent.EditProfileBackground).DisplayBackground
local Enums = require(ProfilePlatform.Common.Enums)
local useAvatarBackgroundFromWrapper = require(ProfilePlatform.Hooks.useAvatarBackgroundFromWrapper)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)

local FFlagProfilePlatformMeTabMobileProfileHero = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformMeTabMobileProfileHero

local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformNewProfileHeader
local FFlagPPVBackgroundUse2DAsLoadingState = require(ProfilePlatformParent.SharedFlags).FFlagPPVBackgroundUse2DAsLoadingState
local FFlagPPVEnable3DBackground = require(ProfilePlatformParent.SharedFlags).FFlagPPVEnable3DBackground

local FFlagProfilePlatformEnableAvatarBackground = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformEnableAvatarBackground

local function UserProfileAvatar(tbl1)
    local var1 = useStyle()
    local var2 = useStyleMetadata()

    local var3 = useProfileJsonComponent(Enums.Components.ProfileBackground)
    local image = if FFlagPPVEnable3DBackground or not FFlagProfilePlatformEnableAvatarBackground then nil else useAvatarBackgroundFromWrapper()
    local assetId = if FFlagPPVEnable3DBackground then var3 and var3.assetId or -1 else nil
    local var5 = FFlagProfilePlatformEnableAvatarBackground and image ~= nil

    local numberSequence = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.25, 0.75),
        NumberSequenceKeypoint.new(0.55, 0.4),
        NumberSequenceKeypoint.new(0.8, 0.15),
        NumberSequenceKeypoint.new(1, 0)
    })

    local numberSequence2 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
    local height = if FFlagProfilePlatformNewProfileHeader and tbl1.height then tbl1.height else Constants.USER_PROFILE_HEADER_HEIGHT
    local var6 = if FFlagProfilePlatformMeTabMobileProfileHero and tbl1.layoutVariant == Enums.ProfileAvatarLayoutVariant.MeTabMobile then math.floor(
        height * Constants.ME_TAB_MOBILE_TOP_BACKGROUND_INSET_RATIO / (Constants.ME_TAB_MOBILE_AVATAR_HEIGHT_ASPECT + Constants.ME_TAB_MOBILE_TOP_BACKGROUND_INSET_RATIO)
    ) else 0
    local var7 = if FFlagProfilePlatformMeTabMobileProfileHero and tbl1.layoutVariant == Enums.ProfileAvatarLayoutVariant.MeTabMobile then math.floor(height * Constants.ME_TAB_MOBILE_AVATAR_OFFSET_Y_RATIO) else 0
    local yOffset2 = if FFlagProfilePlatformMeTabMobileProfileHero and tbl1.layoutVariant == Enums.ProfileAvatarLayoutVariant.MeTabMobile then height - var6 + Constants.ME_TAB_MOBILE_AVATAR_EXTRA_HEIGHT else height - var6
    local yOffset3 = if not FFlagProfilePlatformMeTabMobileProfileHero or tbl1.layoutVariant ~= Enums.ProfileAvatarLayoutVariant.MeTabMobile then 0 else Constants.ME_TAB_MOBILE_AVATAR_DOWN_OFFSET - var7
    local element

    if FFlagPPVEnable3DBackground then
        element = nil
    elseif FFlagProfilePlatformEnableAvatarBackground and image ~= nil then
        local xScale = if not FFlagProfilePlatformMeTabMobileProfileHero or tbl1.layoutVariant ~= Enums.ProfileAvatarLayoutVariant.MeTabMobile then 1.35 else Constants.ME_TAB_MOBILE_BACKGROUND_SCALE_X

        local yScale = if not FFlagProfilePlatformMeTabMobileProfileHero or tbl1.layoutVariant ~= Enums.ProfileAvatarLayoutVariant.MeTabMobile then 1.35 else Constants.ME_TAB_MOBILE_BACKGROUND_SCALE_Y
        local vector2 = if FFlagProfilePlatformMeTabMobileProfileHero and tbl1.layoutVariant == Enums.ProfileAvatarLayoutVariant.MeTabMobile then Vector2.new(0.5, 0) else Vector2.new(0.5, 0.5)
        local uDim2 = if FFlagProfilePlatformMeTabMobileProfileHero and tbl1.layoutVariant == Enums.ProfileAvatarLayoutVariant.MeTabMobile then UDim2.fromScale(0.5, Constants.ME_TAB_MOBILE_BACKGROUND_OFFSET_Y_RATIO) else UDim2.fromScale(0.5, 0.4)
        element = React.createElement(Image, {
            Size = UDim2.fromScale(xScale, yScale),
            AnchorPoint = vector2,
            Position = uDim2,
            Image = image,
            ScaleType = Enum.ScaleType.Crop,
            ZIndex = 1
        })
    else
        element = React.createElement(ImageSetLabel, {
            Size = UDim2.fromScale(1, 1),
            BorderSizePixel = 0,
            Image = Images[var1.Theme.PlayerBackgroundDefault.Image],
            ImageColor3 = if var2 and var2.HasSurfaceOverrides then var1.Theme.BackgroundUIDefault.Color:Lerp(var1.Theme.PlayerBackgroundDefault.Color, var1.Theme.Overlay.Transparency) else nil,
            ZIndex = 1
        })
    end

    local createElement = React.createElement
    local var8 = if FFlagProfilePlatformNewProfileHeader then View else React.Fragment
    local tbl2 = {
        Size = if FFlagProfilePlatformNewProfileHeader then UDim2.new(1, 0, 0, height) else nil,
        ClipsDescendants = if FFlagProfilePlatformMeTabMobileProfileHero and tbl1.layoutVariant == Enums.ProfileAvatarLayoutVariant.MeTabMobile then true else nil
    }

    local tbl3 = {
        Background = element,
        AvatarThumbnail = 0,
        TopGradient = 0,
        BottomGradient = 0,
        CornerRadius = 0
    }
    local element2

    if FFlagProfilePlatformMeTabMobileProfileHero and tbl1.layoutVariant == Enums.ProfileAvatarLayoutVariant.MeTabMobile then
        local createElement2 = React.createElement
        local var9 = View
        local tbl4 = {
            Size = UDim2.new(1, 0, 0, yOffset2),
            Position = UDim2.new(0, 0, 1, yOffset3),
            AnchorPoint = Vector2.new(0, 1),
            ZIndex = 2
        }
        local tbl5 = {
            DisplayBackground = React.createElement(DisplayBackground, {
                height = yOffset2,
                currentBackgroundId = assetId,
                userId = tbl1.userId,
                userThumbnail = if FFlagPPVBackgroundUse2DAsLoadingState then tbl1.userThumbnail else nil,
                cameraDistanceScale = Constants.ME_TAB_MOBILE_CAMERA_DISTANCE_SCALE
            })
        }
        element2 = createElement2(var9, tbl4, tbl5)
    else
        element2 = React.createElement(DisplayBackground, {
            height = height,
            currentBackgroundId = assetId,
            userId = tbl1.userId,
            userThumbnail = if FFlagPPVBackgroundUse2DAsLoadingState then tbl1.userThumbnail else nil
        })
    end

    tbl3.AvatarThumbnail = element2
    local element3

    if FFlagPPVEnable3DBackground
        or FFlagProfilePlatformEnableAvatarBackground and var5
        or FFlagProfilePlatformNewProfileHeader
    then
        element3 = nil
    else
        element3 = React.createElement("Frame", {
            Size = UDim2.new(1, 0, 0, Constants.USER_PROFILE_GRADIENT_HEIGHT),
            Position = UDim2.fromScale(0, 0),
            BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
            BorderSizePixel = 0,
            ZIndex = 3
        }, {
            UIGradient = React.createElement("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
            })
        })
    end

    tbl3.TopGradient = element3
    local var9

    if FFlagProfilePlatformEnableAvatarBackground and var5 then
        var9 = nil
    else
        local createElement2 = React.createElement
        local str1 = "Frame"
        local tbl4 = {
            Size = if FFlagProfilePlatformNewProfileHeader then UDim2.new(1, 0, 0, Constants.USER_PROFILE_GRADIENT_HEIGHT) else UDim2.new(1, 0, 0, height / 2),
            Position = UDim2.fromScale(0, 1),
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = var1.Theme.BackgroundDefault.Color,
            BorderSizePixel = 0,
            ZIndex = 3
        }

        local tbl5 = { UIGradient = 0 }
        local createElement3 = React.createElement
        local str2 = "UIGradient"
        local tbl6 = { Rotation = 90, Transparency = 0 }

        if FFlagPPVEnable3DBackground then
            numberSequence2 = numberSequence
        end

        tbl6.Transparency = numberSequence2
        tbl5.UIGradient = createElement3(str2, tbl6)
        var9 = createElement2(str1, tbl4, tbl5)
    end

    tbl3.BottomGradient = var9

    tbl3.CornerRadius = if FFlagProfilePlatformNewProfileHeader and tbl1.isPeekView then React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }) else nil
    return createElement(var8, tbl2, tbl3)
end

return UserProfileAvatar
