-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local React = require(ProfilePlatformParent.React)
local Constants = require(ProfilePlatformParent.UserLib).Utils.Constants

local Enums = require(ProfilePlatform.Common.Enums)
local useProfileFormFactor = require(ProfilePlatform.Hooks.useProfileFormFactor)
local useProfileJsonComponent = require(ProfilePlatform.Hooks.useProfileJsonComponent)
local useProfileScrollContext = require(ProfilePlatform.Contexts.ProfileScrollContext.useProfileScrollContext)

local CoverPhoto = require(ProfilePlatform.Components.CoverPhoto.CoverPhoto)

local function CoverPhotoContainer(tbl1)
    local var1 = useProfileJsonComponent(Enums.Components.CoverPhoto) or {}
    local profileFormFactorInfo = useProfileFormFactor()
    local var3 = useProfileScrollContext()
    local parallaxOffset = var3.scrollY / 2

    if var1.coverPhotoId == nil then
        return nil
    end

    local coverPhotoThumbnail = string.format("rbxthumb://type=%s&id=%s&w=%d&h=%d", Constants.RbxthumbTypes.Asset, var1.coverPhotoId, 1440, 456)

    return React.createElement(CoverPhoto, {
        layoutOrder = tbl1.layoutOrder,
        coverPhotoThumbnail = coverPhotoThumbnail,
        profileFormFactorInfo = profileFormFactorInfo,
        parallaxOffset = parallaxOffset,
        peekViewOpenPercent = var3.peekViewOpenPercent
    })
end

return CoverPhotoContainer
