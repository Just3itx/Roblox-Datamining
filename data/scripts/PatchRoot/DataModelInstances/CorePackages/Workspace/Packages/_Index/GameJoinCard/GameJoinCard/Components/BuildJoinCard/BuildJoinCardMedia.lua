-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local Foundation = require(GameJoinCardParent.Foundation)

local Image = Foundation.Image
local getRbxThumb = Foundation.Utility.getRbxThumb
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize

local function BuildJoinCardMedia(tbl1)
    local bool1 = tbl1.slot == "Banner"
    return React.createElement(Image, {
        Image = if bool1 then getRbxThumb(ThumbnailType.Avatar, tbl1.userId, ThumbnailSize.Large) else getRbxThumb(ThumbnailType.AvatarHeadShot, tbl1.userId, ThumbnailSize.Medium),
        ScaleType = Enum.ScaleType.Fit,
        tag = {
            ["size-full"] = true,
            ["radius-small bg-surface-200"] = not bool1
        }
    }, {
        BottomFade = if bool1 then React.createElement("UIGradient", {
            Rotation = 90,
            Transparency = NumberSequence.new(
                { NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.7, 0), NumberSequenceKeypoint.new(1, 1) }
            )
        }) else nil
    })
end

return BuildJoinCardMedia
