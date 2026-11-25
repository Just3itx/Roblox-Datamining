-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local constants = require(Songbird.constants)
local Cryo = require(Songbird.Parent.Cryo)
local Foundation = require(Songbird.Parent.Foundation)
local React = require(Songbird.Parent.React)
local ReactUtils = require(Songbird.Parent.ReactUtils)
local Localization = require(Songbird.Parent.Localization)

local ChromeWindowFrame = require(Songbird.Components.ChromeWindowFrame)
local MarqueeScroller = require(Songbird.Components.MarqueeScroller)
local MusicIcon = require(Songbird.Components.MusicIcon)
local LikeButton = require(Songbird.Components.LikeButton)
local TrackingAudioIcon = require(Songbird.Components.TrackingAudioIcon)

local useLocalization = Localization.Hooks.useLocalization
local createNextOrder = ReactUtils.createNextOrder
local useCallback = React.useCallback
local useMemo = React.useMemo

local tbl1 = {
    isLoading = false,
    maxSize = Vector2.new(300, math.huge)
}

local function ChromeWindow(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local nextOrder = createNextOrder()

    local var2 = useMemo(function(): string
        if var1.isLoading then
            return "Loading"
        end

        if var1.song then
            if var1.song.meetsCriteria then
                return "MeetsCriteria"
            end

            return "Unverified"
        end

        return "Loading"
    end, { var1.isLoading, var1.song })

    local bool1 = var2 ~= "MeetsCriteria"

    local var3 = useLocalization({
        windowTitle = "CoreScripts.TopBar.Music",
        musicLoading = "CoreScripts.TopBar.MusicLoading",
        musicUnverified = "CoreScripts.TopBar.MusicNotVerified"
    })

    local onFavorite = useCallback(function()
        if var1.onToggleLike then
            var1.onToggleLike()
        end
    end, { var1.onToggleLike })

    local var5 = useMemo(function()
        if var1.song then
            return table.concat(var1.song.artists, ", ")
        end
        return nil
    end, { var1.song })

    local tbl3

    if bool1 then
        tbl3 = {}
    else
        tbl3 = { LikeButtonWrapper = 0 }
        local createElement = React.createElement
        local view = Foundation.View
        local tbl4 = { tag = "auto-xy padding-right-xsmall" }

        local tbl5 = {
            LikeButton = React.createElement(
                LikeButton,
                {
                    isFavorited = if var1.song then var1.song.isLiked else false,
                    onFavorite = onFavorite
                }
            )
        }
        tbl3.LikeButtonWrapper = createElement(view, tbl4, tbl5)
    end

    local createElement = React.createElement
    local var6 = ChromeWindowFrame
    local tbl4 = {
        title = var3.windowTitle,
        maxSize = var1.maxSize,
        actions = tbl3,
        isFocused = var1.isFocused,
        onClose = var1.onClose,
        onUnfocus = var1.onUnfocus
    }
    local tbl5 = { Body = 0 }
    local createElement2 = React.createElement
    local view = Foundation.View
    local tbl6 = {
        Size = UDim2.new(1, 0, 0, constants.WINDOW_HEIGHT),
        tag = "col auto-x align-y-center"
    }
    local tbl7 = { InvalidAudio = 0, NowPlaying = 0 }
    local var7

    if var2 == "MeetsCriteria" then
        var7 = nil
    else
        local createElement3 = React.createElement
        local view2 = Foundation.View
        local tbl8 = { tag = "auto-x size-0-full gap-medium row align-y-center" }

        local tbl9 = {
            Icon = React.createElement(TrackingAudioIcon, { isMoving = var2 == "Unverified" }),
            Alert = React.createElement(Foundation.Text, {
                tag = "auto-xy text-body-medium content-emphasis shrink text-wrap text-align-x-left text-align-y-center",
                Text = if var2 == "Unverified" then var3.musicUnverified else var3.musicLoading,
                LayoutOrder = nextOrder()
            })
        }
        var7 = createElement3(view2, tbl8, tbl9)
    end

    tbl7.InvalidAudio = var7
    local var8

    if var2 == "MeetsCriteria" then
        local createElement3 = React.createElement
        local view2 = Foundation.View
        local tbl8 = { tag = "auto-xy row gap-medium flex-between align-y-center" }

        local tbl9 = {
            Icon = React.createElement(
                MusicIcon,
                {
                    layoutOrder = nextOrder(),
                    thumbnailUrl = if var1.song then var1.song.thumbnailUrl else nil
                }
            ),
            SongInfo = React.createElement(
                Foundation.View,
                {
                    tag = "auto-xy col gap-xsmall shrink clip",
                    LayoutOrder = nextOrder()
                },
                {
                    Title = React.createElement(MarqueeScroller, {
                        speed = if bool1 then 0 else nil,
                        LayoutOrder = nextOrder()
                    }, {
                        Label = React.createElement(
                            Foundation.Text,
                            {
                                tag = "auto-xy shrink text-title-medium content-emphasis",
                                Text = if var1.song then var1.song.title else ""
                            }
                        )
                    }),
                    Artists = React.createElement(Foundation.Text, {
                        tag = "auto-xy shrink text-body-small content-default",
                        Text = var5,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        LayoutOrder = nextOrder()
                    })
                }
            )
        }
        var8 = createElement3(view2, tbl8, tbl9)
    else
        var8 = false
    end

    tbl7.NowPlaying = var8
    tbl5.Body = createElement2(view, tbl6, tbl7)
    return createElement(var6, tbl4, tbl5)
end

return ChromeWindow
