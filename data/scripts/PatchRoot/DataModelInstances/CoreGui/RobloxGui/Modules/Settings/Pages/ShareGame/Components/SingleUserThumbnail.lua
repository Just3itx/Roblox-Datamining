-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Modules = game:GetService("CoreGui").RobloxGui.Modules
local COLORS = require(CorePackages.Workspace.Packages.CoreScriptsCommon).Constants.COLORS
local Constants = require(Modules.Settings.Pages.ShareGame.Constants)
local Constants2 = require(CorePackages.Workspace.Packages.UserLib).Utils.Constants

local getRbxthumbWithTypeSizeAndOptions = require(CorePackages.Workspace.Packages.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions

local InviteAvatarThumbnailSize = Constants.InviteAvatarThumbnailSize

return function(tbl1)
    local user = tbl1.user
    local rbxthumbWithTypeSizeAndOptions

    if user then
        local var1 = Constants2.RbxThumbnailSizeToNumberSize[InviteAvatarThumbnailSize]
        rbxthumbWithTypeSizeAndOptions = getRbxthumbWithTypeSizeAndOptions(user.id, Constants.InviteAvatarRbxthumbType, var1)
    else
        rbxthumbWithTypeSizeAndOptions = nil
    end
    return React.createElement(
        "ImageLabel",
        {
            Size = tbl1.size,
            Position = tbl1.position,
            AnchorPoint = tbl1.anchorPoint,
            Image = rbxthumbWithTypeSizeAndOptions or "rbxasset://textures/ui/LuaApp/graphic/ph-avatar-portrait.png",
            BorderSizePixel = 0,
            BackgroundColor3 = COLORS.FLINT,
            BackgroundTransparency = tbl1.backgroundTransparency
        },
        {
            Corner = if tbl1.square then nil else React.createElement("UICorner", { CornerRadius = UDim.new(0.5, 0) })
        }
    )
end
