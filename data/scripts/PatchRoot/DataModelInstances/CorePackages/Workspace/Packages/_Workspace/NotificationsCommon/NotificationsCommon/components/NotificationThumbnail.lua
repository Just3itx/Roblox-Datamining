-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local context = scriptParentParent.context
local dependencies = require(scriptParentParent.dependencies)
local React = dependencies.React
local UIBlox = dependencies.UIBlox
local useStyle = UIBlox.Core.Style.useStyle
local LoadableImage = UIBlox.App.Loading.LoadableImage
local type = require(scriptParentParent.type)
local getRbxthumbWithTypeSizeAndOptions = dependencies.getRbxthumbWithTypeSizeAndOptions
local UserLibConstants = dependencies.UserLibConstants
local constants = require(scriptParentParent.constants)
local bool1 = game:DefineFastFlag("EnableStreamAvatarImageUrlThumbnail", false)

local FFlagNotificationThumbnailUseProfileFrameThumbnail = require(scriptParentParent.Flags.FFlagNotificationThumbnailUseProfileFrameThumbnail)

local Images = UIBlox.App.ImageSet.Images
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local iconsLogoBlock = Images["icons/logo/block"]
local iconsCommonSafety = Images["icons/common/safety"]

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

    if idType == type.SENDERThumbnailTypeEnum.GamePass then
        return UserLibConstants.RbxthumbTypes.GamePass
    end

    if bool1 and idType == type.SENDERThumbnailTypeEnum.AvatarImageUrl then
        return UserLibConstants.RbxthumbTypes.AvatarImageUrl
    end

    return UserLibConstants.RbxthumbTypes.GameIcon
end

local function func2(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.idType == type.SENDERThumbnailTypeEnum.User
        or bool1 and arg1.idType == type.SENDERThumbnailTypeEnum.AvatarImageUrl
end

return function()
    local var1 = useNotificationCardState("thumbnail")
    if var1 == nil or #var1 == 0 then
        return nil
    end
    local var2 = var1[1]
    if var2 == nil or not bool1 and var2.idType == type.SENDERThumbnailTypeEnum.AvatarImageUrl then
        return nil
    else
        local var3 = useStyle()

        if var2.idType == type.SENDERThumbnailTypeEnum.Icon then
            if var2.id == constants.SafetyThumbnailId then
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
                BackgroundColor3 = var3.Tokens.Color.System.Emphasis.Color3,
                BorderSizePixel = 0
            }, {
                UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 11) }),
                Icon = React.createElement(ImageSetLabel, {
                    Size = UDim2.fromScale(0.75, 0.75),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5),
                    LayoutOrder = 1,
                    Image = iconsLogoBlock,
                    BackgroundTransparency = 1,
                    ImageColor3 = var3.Tokens.Color.Extended.White.White_100.Color3
                })
            })
        end

        local image = if bool1 and func1(var2.idType) == UserLibConstants.RbxthumbTypes.AvatarImageUrl then var2.id elseif FFlagNotificationThumbnailUseProfileFrameThumbnail then getRbxthumbWithTypeSizeAndOptions(var2.id, func1(var2.idType), 150, nil, nil, (func2(var2))) else getRbxthumbWithTypeSizeAndOptions(var2.id, func1(var2.idType), 150)
        local createElement = React.createElement
        local str1 = "Frame"
        local tbl1 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
            BorderSizePixel = 0
        }
        local tbl2 = {
            Thumbnail = React.createElement(LoadableImage, {
                BackgroundTransparency = 0,
                BackgroundColor3 = var3.Theme.BackgroundDefault.Color,
                Image = image,
                Size = UDim2.fromScale(1, 1),
                cornerRadius = if func2(var2) then UDim.new(0.5, 0) else UDim.new(0, 8),
                showFailedStateWhenLoadingFailed = true,
                useShimmerAnimationWhileLoading = true,
                ZIndex = 1
            })
        }
        return createElement(str1, tbl1, tbl2)
    end
end
