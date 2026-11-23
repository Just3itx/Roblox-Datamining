-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:31:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCommon = script:FindFirstAncestor("AvatarExperienceCommon")
local ItemTypeEnum = require(AvatarExperienceCommon.Parent.AvatarExperienceModel).Enums.ItemTypeEnum

return function(arg1, arg2, arg3)
    if arg3 == ItemTypeEnum.Asset then
        return arg1.AssetInfos[arg2]
    end

    if arg3 == ItemTypeEnum.Bundle then
        return arg1.BundleInfos[arg2]
    end

    return nil
end
