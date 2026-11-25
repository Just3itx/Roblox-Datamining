-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T20:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserLib = script:FindFirstAncestor("UserLib")

local Constants = require(UserLib.Utils.Constants)

local module = ({})

function module.new()
    return {
        thumbnailType = Constants.RbxAvatarThumbnailTypesFromEnum.HeadShot,
        thumbnailSize = Constants.RbxThumbnailSizes.Size150x150
    }
end

function module.fromData(thumbnailType, thumbnailSize)
    local module2 = module.new()
    module2.thumbnailType = thumbnailType
    module2.thumbnailSize = thumbnailSize
    return module2
end

return module
