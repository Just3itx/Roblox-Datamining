-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local Foundation = require(Songbird.Parent.Foundation)
local React = require(Songbird.Parent.React)

local createNextOrder = require(Songbird.Parent.ReactUtils).createNextOrder

local getFFlagSongbirdMusicIconThumbnail = require(Songbird.Flags.getFFlagSongbirdMusicIconThumbnail)

local function MusicIcon(tbl1)
    local nextOrder = createNextOrder()
    local var1 = Foundation.Hooks.useTokens()
    local size900 = var1.Size.Size_900

    local thumbnailUrl = getFFlagSongbirdMusicIconThumbnail() and tbl1.thumbnailUrl

    return React.createElement(Foundation.View, {
        Size = UDim2.fromOffset(size900, size900),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = if thumbnailUrl then true else nil,
        backgroundStyle = not thumbnailUrl and {
            Color3 = Color3.fromRGB(43, 45, 50),
            Transparency = 0
        } or nil,
        cornerRadius = UDim.new(0, var1.Radius.Medium),
        LayoutOrder = if getFFlagSongbirdMusicIconThumbnail() then tbl1.layoutOrder else nil,
        ZIndex = nextOrder()
    }, {
        Thumbnail = if thumbnailUrl then React.createElement(Foundation.Image, { tag = "size-full", Image = tbl1.thumbnailUrl, ZIndex = nextOrder() }) else nil,
        Icon = if thumbnailUrl then nil else React.createElement(Foundation.Icon, {
            name = "icons/common/music",
            size = Foundation.Enums.IconSize.Medium,
            Position = UDim2.new(0.5, -1, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            ZIndex = nextOrder()
        })
    })
end

return MusicIcon
