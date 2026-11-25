-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local context = scriptParentParent.context
local dependencies = require(scriptParentParent.dependencies)
local ImagePile = dependencies.AppBlox.ImagePile
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local LoadableImage = UIBlox.App.Loading.LoadableImage
local useStyle = UIBlox.Core.Style.useStyle
local type = require(scriptParentParent.type)
local getRbxthumbWithTypeSizeAndOptions = dependencies.getRbxthumbWithTypeSizeAndOptions
local UserLibConstants = dependencies.UserLibConstants

local scriptParentParentParent = scriptParentParent.Parent
local NotificationsCommon = require(scriptParentParentParent.NotificationsCommon)
local constants = NotificationsCommon.constants
local SharedFlags = require(scriptParentParentParent.SharedFlags)

local utils = scriptParentParent.utils
local toastNotificationHelper = require(utils.toastNotificationHelper)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local iconsGraphicLogomarkGradient_xlarge = Images["icons/graphic/logomark-gradient_xlarge"]
local iconsCommonSafety = Images["icons/common/safety"]
local GetFFlagEnableToastIconSupport = SharedFlags.GetFFlagEnableToastIconSupport

local FFlagNotificationThumbnailUseProfileFrameThumbnail = NotificationsCommon.FFlagNotificationThumbnailUseProfileFrameThumbnail

local useNotificationCardState = require(context.useNotificationCardState)

local function func1(idType)
    if idType == type.SENDERThumbnailTypeEnum.Game then
        return UserLibConstants.RbxthumbTypes.GameIcon
    end

    if idType == type.SENDERThumbnailTypeEnum.User then
        return UserLibConstants.RbxthumbTypes.AvatarHeadShot
    end

    if idType == type.SENDERThumbnailTypeEnum.Group then
        return UserLibConstants.RbxthumbTypes.GroupIcon
    end

    if idType == type.SENDERThumbnailTypeEnum.Asset then
        return UserLibConstants.RbxthumbTypes.Asset
    end

    if idType == type.SENDERThumbnailTypeEnum.Bundle then
        return UserLibConstants.RbxthumbTypes.BundleThumbnail
    end

    return UserLibConstants.RbxthumbTypes.GameIcon
end

local var1 = not toastNotificationHelper.isUserThumbnail and function(arg1): boolean
    return arg1.idType == type.SENDERThumbnailTypeEnum.User
end or toastNotificationHelper.isUserThumbnail

return function()
    local var2 = useNotificationCardState("thumbnail")
    if var2 == nil or #var2 == 0 then
        return nil
    end

    local var3 = useStyle()
    local tbl1 = ({})
    local bool1 = false
    for _, value in ipairs(var2) do
        if not var1(value) then
            bool1 = true
        end

        local str1 = tostring(value.id)
        tbl1[str1] = if FFlagNotificationThumbnailUseProfileFrameThumbnail then getRbxthumbWithTypeSizeAndOptions(value.id, func1(value.idType), 150, nil, nil, var1(value)) else getRbxthumbWithTypeSizeAndOptions(value.id, func1(value.idType), 150)
    end

    local images = {}

    if GetFFlagEnableToastIconSupport() then
        local var4 = var2[1]

        if var4.idType == type.SENDERThumbnailTypeEnum.Icon then
            if var4.id == constants.SafetyThumbnailId then
                return React.createElement("Frame", {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    SizeConstraint = Enum.SizeConstraint.RelativeXX,
                    BorderSizePixel = 0
                }, {
                    Icon = React.createElement(ImageSetLabel, {
                        Size = UDim2.fromScale(1, 1),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.fromScale(0.5, 0.5),
                        LayoutOrder = 1,
                        Image = iconsCommonSafety,
                        BackgroundTransparency = 1,
                        ImageColor3 = var3.Theme.IconDefault.Color
                    })
                })
            end

            return React.createElement("Frame", {
                BackgroundTransparency = 0,
                Size = UDim2.fromScale(1, 1),
                SizeConstraint = Enum.SizeConstraint.RelativeXX,
                BackgroundColor3 = var3.Tokens.Color.Extended.Black.Black_100.Color3,
                BorderSizePixel = 0
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
                Icon = React.createElement(ImageSetLabel, {
                    Size = UDim2.fromScale(0.8, 0.8),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    LayoutOrder = 1,
                    Image = iconsGraphicLogomarkGradient_xlarge,
                    BackgroundTransparency = 1
                })
            })
        end
    end

    if not bool1 then
        for _, image in tbl1 do
            table.insert(images, { Image = image, BackgroundColor3 = Color3.fromRGB(101, 102, 104) })
        end
        return React.createElement(ImagePile, {
            images = images,
            imageBorderColor = var3.Theme.BackgroundUIDefault.Color,
            imageBorderThickness = if #images > 1 then 2 else 0
        })
    end

    local var4 = var2[1]
    if var4 == nil then
        return nil
    end

    local image = if FFlagNotificationThumbnailUseProfileFrameThumbnail then getRbxthumbWithTypeSizeAndOptions(var4.id, func1(var4.idType), 150, nil, nil, var1(var4)) else getRbxthumbWithTypeSizeAndOptions(var4.id, func1(var4.idType), 150)
    local uDim = UDim.new(0.5, 0)

    local createElement = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        SizeConstraint = Enum.SizeConstraint.RelativeXX,
        BorderSizePixel = 0
    }
    local tbl4 = { Thumbnail = 0 }
    local createElement2 = React.createElement
    local var5 = LoadableImage
    local tbl5 = {
        BackgroundTransparency = 1,
        Image = image,
        Size = UDim2.fromScale(1, 1),
        cornerRadius = 0,
        showFailedStateWhenLoadingFailed = true,
        useShimmerAnimationWhileLoading = true,
        ZIndex = 1
    }

    if not var1(var4) then
        uDim = UDim.new(0, 8)
    end

    tbl5.cornerRadius = uDim
    tbl4.Thumbnail = createElement2(var5, tbl5)
    return createElement(str1, tbl3, tbl4)
end
