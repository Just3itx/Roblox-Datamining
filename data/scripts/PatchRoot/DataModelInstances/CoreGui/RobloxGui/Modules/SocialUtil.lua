-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local CorePackages = game:GetService("CorePackages")

local getRbxthumbWithTypeSizeAndOptions = require(CorePackages.Workspace.Packages.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions
local Constants = require(CorePackages.Workspace.Packages.UserLib).Utils.Constants

local Size100x100 = Enum.ThumbnailSize.Size100x100
local AvatarThumbnail = Enum.ThumbnailType.AvatarThumbnail

function module.GetPlayerImage(arg1, arg2, arg3, _)
    arg2 = arg2 or Size100x100
    arg3 = arg3 or AvatarThumbnail

    local num1 = 0

    if arg3 == Enum.ThumbnailType.HeadShot or arg3 == Enum.ThumbnailType.AvatarBust then
        local num2 = if arg2 == Enum.ThumbnailSize.Size48x48 then 48 elseif arg2 == Enum.ThumbnailSize.Size60x60 then 60 else 150

        return getRbxthumbWithTypeSizeAndOptions(arg1, Constants.RbxthumbTypes.AvatarHeadShot, num2)
    end
    if arg3 ~= Enum.ThumbnailType.AvatarThumbnail then
        return "ThumbnailErrorForSocialUtil.GetPlayerImage"
    end

    if arg2 == Enum.ThumbnailSize.Size48x48 or arg2 == Enum.ThumbnailSize.Size60x60 or arg2 == Enum.ThumbnailSize.Size100x100 then
        num1 = 100
    elseif arg2 == Enum.ThumbnailSize.Size150x150
        or arg2 == Enum.ThumbnailSize.Size180x180
        or arg2 == Enum.ThumbnailSize.Size352x352
    then
        num1 = 352
    elseif arg2 == Enum.ThumbnailSize.Size420x420 then
        num1 = 720
    end

    return getRbxthumbWithTypeSizeAndOptions(arg1, Constants.RbxthumbTypes.Avatar, num1)
end

return module
