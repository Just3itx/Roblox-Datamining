-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local React = require(Songbird.Parent.React)

local ChromeWindow = require(Songbird.Components.ChromeWindow)
local useCurrentSong = require(Songbird.Hooks.useCurrentSong)

local getFFlagSongbirdMusicIconThumbnail = require(Songbird.Flags.getFFlagSongbirdMusicIconThumbnail)
local useSongAlbumArt = require(Songbird.Hooks.useSongAlbumArt)

local useCallback = React.useCallback
local useMemo = React.useMemo

local function ChromeWindowWrapper(tbl1)
    local var1 = useCurrentSong()

    local var2 = useMemo(function()
        if not var1 then
            return nil
        end

        return tonumber(var1.metadata.AssetId)
    end, { var1 })

    local meetsCriteria = getFFlagSongbirdMusicIconThumbnail() and var1 and var1.meetsCriteria
    local var3 = useSongAlbumArt

    if not meetsCriteria then
        var2 = nil
    end

    local var4 = var3(var2)
    local value = if meetsCriteria then var4.value else nil

    local onToggleLike = useCallback(function()
        if var1 then
            var1.toggleFavorite()
        end
    end, { var1 })

    return React.createElement(ChromeWindow, {
        song = var1
            and {
                title = var1.metadata.Title,
                artists = { var1.metadata.Artist },
                isLiked = var1.isFavorited,
                meetsCriteria = var1.meetsCriteria,
                thumbnailUrl = value
            }
            or nil,
        isFocused = tbl1.isFocused,
        maxSize = tbl1.maxSize,
        onToggleLike = onToggleLike,
        onClose = tbl1.onClose,
        onUnfocus = tbl1.onUnfocus
    })
end

return ChromeWindowWrapper
