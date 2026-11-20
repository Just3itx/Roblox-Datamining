-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ThumbnailType = require(Foundation.Enums.ThumbnailType)

local ThumbnailSize = require(Foundation.Enums.ThumbnailSize)

local getAssetIdAsNumeric = require(Foundation.Utility.getAssetIdAsNumeric)

local tbl1 = {
    [ThumbnailType.Asset] = {
        [ThumbnailSize.Medium] = Vector2.new(150, 150),
        [ThumbnailSize.Large] = Vector2.new(420, 420)
    },
    [ThumbnailType.Avatar] = {
        [ThumbnailSize.Small] = Vector2.new(48, 48),
        [ThumbnailSize.Medium] = Vector2.new(150, 150),
        [ThumbnailSize.Large] = Vector2.new(420, 420),
        [ThumbnailSize.XLarge] = Vector2.new(720, 720)
    },
    [ThumbnailType.AvatarBust] = {
        [ThumbnailSize.Small] = Vector2.new(50, 50),
        [ThumbnailSize.Medium] = Vector2.new(150, 150),
        [ThumbnailSize.Large] = Vector2.new(420, 420)
    },
    [ThumbnailType.AvatarHeadShot] = {
        [ThumbnailSize.Small] = Vector2.new(48, 48),
        [ThumbnailSize.Medium] = Vector2.new(150, 150),
        [ThumbnailSize.Large] = Vector2.new(420, 420)
    },
    [ThumbnailType.BadgeIcon] = {
        [ThumbnailSize.Medium] = Vector2.new(150, 150)
    },
    [ThumbnailType.BundleThumbnail] = {
        [ThumbnailSize.Medium] = Vector2.new(150, 150),
        [ThumbnailSize.Large] = Vector2.new(420, 420)
    },
    [ThumbnailType.FontFamily] = {
        [ThumbnailSize.Medium] = Vector2.new(1200, 80)
    },
    [ThumbnailType.GameIcon] = {
        [ThumbnailSize.Small] = Vector2.new(50, 50),
        [ThumbnailSize.Medium] = Vector2.new(150, 150)
    },
    [ThumbnailType.GamePass] = {
        [ThumbnailSize.Medium] = Vector2.new(150, 150)
    },
    [ThumbnailType.GameThumbnail] = {
        [ThumbnailSize.Small] = Vector2.new(256, 144),
        [ThumbnailSize.Medium] = Vector2.new(384, 216),
        [ThumbnailSize.Large] = Vector2.new(480, 270),
        [ThumbnailSize.XLarge] = Vector2.new(768, 432)
    },
    [ThumbnailType.GroupIcon] = {
        [ThumbnailSize.Medium] = Vector2.new(150, 150),
        [ThumbnailSize.Large] = Vector2.new(420, 420)
    },
    [ThumbnailType.Outfit] = {
        [ThumbnailSize.Medium] = Vector2.new(150, 150),
        [ThumbnailSize.Large] = Vector2.new(420, 420)
    }
}

return function(avatarHeadShot, arg1, arg2, tbl2): string
    local var1 = tbl1[avatarHeadShot][arg2 or ThumbnailSize.Medium]

    local assetIdAsNumeric = getAssetIdAsNumeric(arg1)

    if not var1 then
        warn(`Unsupported size {arg2} for media type: {avatarHeadShot}, defaulting to {ThumbnailSize.Medium}`)
        var1 = tbl1[avatarHeadShot][ThumbnailSize.Medium]
    end

    local str1 = `rbxthumb://type={avatarHeadShot}&id={assetIdAsNumeric}&w={var1.X}&h={var1.Y}`

    if avatarHeadShot == ThumbnailType.AvatarHeadShot and tbl2 and tbl2.includeProfileFrame then
        str1 ..= "&includeprofileframe=true"
    end

    return str1
end
