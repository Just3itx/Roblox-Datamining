-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommonParent = script:FindFirstAncestor("AvatarExperienceCommon").Parent

local Constants = require(AvatarExperienceCommonParent.UserLib).Utils.Constants

local function getRbxThumbType(str1: string)
    if str1 == "Bundle" then
        return Constants.RbxthumbTypes.BundleThumbnail
    elseif str1 == "Asset" then
        return Constants.RbxthumbTypes.Asset
    end

    return nil
end

return getRbxThumbType
