-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local Songbird = require(MomentsParent.Songbird)

local IconButton = Foundation.IconButton
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View

local useLocalization = Localization.Hooks.useLocalization
local sendAudioPlayerAnalytics = Songbird.Analytics.sendAudioPlayerAnalytics
local AnalyticActions = Songbird.Analytics.AnalyticActions

local MusicThumbnailIcon = MomentsCommon.Components.MusicThumbnailIcon
local MusicThumbnailIconSize = MomentsCommon.Enums.MusicThumbnailIconSize
local FFlagMomentsAudioSaveButton = MomentsCommon.Flags.FFlagMomentsAudioSaveButton
local FFlagMomentsAudioSaveSongbirdAnalytics = require(Moments.Flags.FFlagMomentsAudioSaveSongbirdAnalytics)

local _useMusicInfo = require(Moments.Hooks.useMusicInfo)

local tbl1 = { title = "Feature.Moments.Label.Music" }

local function SaveButtonWithAnalytics(tbl2)
    local var1, var2 = React.useState(false)
    local onActivated = React.useCallback(function()
        sendAudioPlayerAnalytics({
            action = if var1 then AnalyticActions.Unlike else AnalyticActions.Like,
            songId = tostring(tbl2.assetId),
            thumbnailId = "-1",
            source = "moments"
        })

        var2(not var1)
    end, { var1, tbl2.assetId })

    return React.createElement(IconButton, {
        icon = {
            name = BuilderIcons.Icon.Bookmark,
            variant = if var1 then BuilderIcons.IconVariant.Filled else BuilderIcons.IconVariant.Regular
        },
        LayoutOrder = 3,
        onActivated = onActivated,
        size = Foundation.Enums.InputSize.Medium,
        testId = "MomentsMusicSaveButton"
    })
end

local function MusicModal(tbl2)
    local var1 = useLocalization(tbl1)
    local musicInfo = tbl2.musicInfo

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl3 = {
        isOpen = true,
        onClose = tbl2.onClose,
        preferCenterSheet = true
    }
    local tbl4 = {
        Header = React.createElement(Sheet.Header, nil, {
            Title = React.createElement(FoundationText, { Text = var1.title, tag = "auto-xy text-heading-small content-emphasis" })
        }),
        Content = 0
    }

    local createElement2 = React.createElement
    local content = Sheet.Content
    local var2 = nil
    local tbl5 = { MusicInfoContainer = 0 }
    local createElement3 = React.createElement
    local var3 = View
    local tbl6 = { tag = "row align-y-center gap-medium size-full-0 auto-y padding-bottom-large" }

    local tbl7 = {
        MusicThumbnail = React.createElement(MusicThumbnailIcon, { assetId = musicInfo.AssetId, size = MusicThumbnailIconSize.Large }),
        MusicInfo = React.createElement(View, {
            tag = "col shrink gap-xsmall size-full-0 auto-y",
            LayoutOrder = 2
        }, {
            Title = React.createElement(FoundationText, {
                tag = "auto-xy text-title-medium text-align-x-left text-align-y-top text-truncate-end content-emphasis",
                Text = musicInfo.Title or "",
                LayoutOrder = 1
            }),
            Artist = if musicInfo.Artist then React.createElement(FoundationText, {
                tag = "auto-xy text-body-small text-align-x-left text-align-y-top text-truncate-end content-neutral",
                Text = musicInfo.Artist,
                LayoutOrder = 2
            }) else nil
        }),
        SaveButton = if FFlagMomentsAudioSaveButton and FFlagMomentsAudioSaveSongbirdAnalytics then React.createElement(SaveButtonWithAnalytics, { assetId = musicInfo.AssetId }) elseif FFlagMomentsAudioSaveButton then React.createElement(
            IconButton,
            {
                icon = BuilderIcons.Icon.Bookmark,
                LayoutOrder = 3,
                onActivated = function() end,
                size = Foundation.Enums.InputSize.Medium,
                testId = "MomentsMusicSaveButton"
            }
        ) else nil
    }
    tbl5.MusicInfoContainer = createElement3(var3, tbl6, tbl7)
    tbl4.Content = createElement2(content, var2, tbl5)
    return createElement(root, tbl3, tbl4)
end

return MusicModal
