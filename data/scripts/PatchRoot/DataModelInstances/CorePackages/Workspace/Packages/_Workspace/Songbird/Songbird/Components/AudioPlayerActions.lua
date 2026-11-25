-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local CoreGui = game:GetService("CoreGui")

local React = require(Songbird.Parent.React)
local ReactUtils = require(Songbird.Parent.ReactUtils)
local ReactRoblox = require(Songbird.Parent.ReactRoblox)
local Foundation = require(Songbird.Parent.Foundation)
local Localization = require(Songbird.Parent.Localization)

local CustomFoundationChip = require(Songbird.Components.CustomFoundationChip)
local AnalyticActions = require(Songbird.Analytics.AnalyticActions)
local sendAudioPlayerAnalytics = require(Songbird.Analytics.sendAudioPlayerAnalytics)
local _types = require(Songbird.types)
local ReportSongDialog = require(Songbird.Components.ReportSongDialog)

local GetFFlagSongDetailsPageDesignPass = require(Songbird.Parent.SharedFlags).GetFFlagSongDetailsPageDesignPass

local useLocalization = Localization.Hooks.useLocalization
local useCallback = React.useCallback
local useState = React.useState
local createNextOrder = ReactUtils.createNextOrder

local function AudioPlayerActions(tbl1)
    local var1 = useLocalization({ favorite = "Feature.SongDetails.Action.Favorite", report = "Feature.SongDetails.Action.Report" })

    local var2, var3 = useState(false)
    local nextOrder = createNextOrder()

    local var4 = useCallback(function(action)
        local songId = tbl1.audio.assetId:gsub("rbxassetid://", "")
        local thumbnailId = if tbl1.audio.thumbnailAssetId then tbl1.audio.thumbnailAssetId:gsub("rbxassetid://", "") else nil
        sendAudioPlayerAnalytics(
            {
                action = action,
                songId = songId,
                thumbnailId = thumbnailId or "-1",
                source = tbl1.analyticsSource
            }
        )
    end, {
        tbl1.audio.assetId,
        tbl1.audio.thumbnail,
        tbl1.audio.thumbnailAssetId,
        tbl1.analyticsSource
    })

    local onActivated = useCallback(function()
        if tbl1.audio.isLiked then
            if tbl1.onUnlike then
                var4(AnalyticActions.Unlike)
                tbl1.onUnlike()
            end
        elseif tbl1.onLike then
            var4(AnalyticActions.Like)
            tbl1.onLike()
        end
    end, {
        tbl1.audio.isLiked,
        tbl1.onLike,
        tbl1.onUnlike,
        var4
    })

    local var5 = useCallback(function()
        var4(AnalyticActions.StartAudioReport)
        var3(true)
    end, {})

    local var7 = useCallback(function()
        var3(false)
    end, {})

    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "auto-xy row gap-small",
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = { Favorite = 0, Report = 0, ReportDialog = 0 }
    local element

    if GetFFlagSongDetailsPageDesignPass() then
        element = React.createElement(Foundation.Chip, {
            text = var1.favorite,
            leading = {
                iconName = Foundation.Enums.IconName.Star,
                iconVariant = if tbl1.audio.isLiked then Foundation.Enums.IconVariant.Filled else nil
            },
            onActivated = onActivated,
            LayoutOrder = nextOrder()
        })
    else
        element = React.createElement(CustomFoundationChip, {
            LayoutOrder = nextOrder(),
            text = var1.favorite,
            icon = if tbl1.audio.isLiked then "icons/actions/favoriteOn" else "icons/actions/favoriteOff",
            onActivated = onActivated
        })
    end

    tbl3.Favorite = element

    tbl3.Report = if GetFFlagSongDetailsPageDesignPass() then React.createElement(Foundation.Chip, {
        text = var1.report,
        leading = {
            iconName = Foundation.Enums.IconName.Flag
        },
        onActivated = var5,
        LayoutOrder = nextOrder()
    }) else React.createElement(
        CustomFoundationChip,
        {
            LayoutOrder = nextOrder(),
            text = var1.report,
            icon = "icons/actions/feedback",
            onActivated = var5
        }
    )

    tbl3.ReportDialog = var2
        and ReactRoblox.createPortal(
            React.createElement("ScreenGui", {
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = 2
            }, {
                Background = React.createElement(Foundation.View, {
                    tag = "size-full row align-y-center align-x-center bg-over-media-100",
                    stateLayer = {
                        affordance = Foundation.Enums.StateLayerAffordance.None
                    },
                    onActivated = var7
                }, {
                    Dialog = React.createElement(
                        ReportSongDialog,
                        {
                            audio = tbl1.audio,
                            analyticsSource = tbl1.analyticsSource or "unknown",
                            onClose = var7
                        }
                    )
                })
            }),
            CoreGui
        )
    return createElement(view, tbl2, tbl3)
end

return AudioPlayerActions
