-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local AvatarSize = require(Foundation.Enums.AvatarSize)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local function getAvatarSize(arg1, arg2, bool1: boolean)
    if bool1 then
        return ({
            [AvatarSize.XSmall] = arg1.Size.Size_300,
            [AvatarSize.Small] = arg1.Size.Size_400,
            [AvatarSize.Medium] = arg1.Size.Size_500,
            [AvatarSize.Large] = arg1.Size.Size_600,
            [AvatarSize.XLarge] = arg1.Size.Size_600
        })[arg2]
    end
    return ({
        [AvatarSize.XSmall] = arg1.Size.Size_600,
        [AvatarSize.Small] = arg1.Size.Size_800,
        [AvatarSize.Medium] = arg1.Size.Size_1000,
        [AvatarSize.Large] = arg1.Size.Size_1200,
        [AvatarSize.XLarge] = arg1.Size.Size_1400,
        [AvatarSize.Pictogram] = arg1.Size.Size_2400
    })[arg2]
end

return getAvatarSize
