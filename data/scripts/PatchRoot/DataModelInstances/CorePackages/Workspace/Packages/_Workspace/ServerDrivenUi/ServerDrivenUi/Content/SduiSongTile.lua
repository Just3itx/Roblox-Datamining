-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:21:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUi = script:FindFirstAncestor("ServerDrivenUi")
local ServerDrivenUiParent = ServerDrivenUi.Parent
local React = require(ServerDrivenUiParent.React)
local useTokens = require(ServerDrivenUiParent.Foundation).Hooks.useTokens
local Cryo = require(ServerDrivenUiParent.Cryo)
local useSongAlbumArt = require(ServerDrivenUiParent.Songbird).useSongAlbumArt
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiActionType = SduiCoreSystem.SduiActionType
local executeAction = SduiCoreSystem.executeAction

local SduiTile = require(ServerDrivenUi.Content.SduiTile)
local SduiTileFooter = require(ServerDrivenUi.Content.SduiTileFooter)

return React.memo(function(arg1) -- name: SduiSongTile
    local var1 = useTokens()
    local songId = arg1.songId

    local var2 = useSongAlbumArt(songId)
    local image = if arg1.image and arg1.image ~= "" then arg1.image else var2.value

    local onActivated = React.useCallback(function()
        if arg1.onActivated then
            arg1.onActivated()
            return
        end
        local tbl1 = {
            actionType = SduiActionType.OpenSongDetail,
            actionParams = { songId = songId }
        }

        executeAction(tbl1, arg1.analyticsContext, arg1.sduiContext)
    end, {
        arg1.onActivated,
        arg1.sduiContext,
        arg1.analyticsContext,
        songId
    })
    local footerComponent = React.useMemo(function()
        if arg1.footerComponent then
            return arg1.footerComponent
        end
        return React.createElement(SduiTileFooter, { leftText = arg1.artistText, testId = "--sdui-song-tile-footer-artist" })
    end, { arg1.footerComponent, arg1.artistText, var1 })

    return React.createElement(
        SduiTile,
        Cryo.Dictionary.join(
            arg1,
            {
                image = image,
                onActivated = onActivated,
                footerComponent = footerComponent,
                testId = "--sdui-song-tile"
            }
        )
    )
end)
