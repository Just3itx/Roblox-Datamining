-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local BuilderIcons = require(MomentsCreationParent.BuilderIcons)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local IconButton = Foundation.IconButton
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local PlayLarge = BuilderIcons.Icon.PlayLarge
local PauseLarge = BuilderIcons.Icon.PauseLarge

local MusicThumbnailIcon = MomentsCommon.Components.MusicThumbnailIcon
local RadialProgressBar = require(MomentsCreation.Components.RadialProgressBar)

local useBinding = React.useBinding
local useEffect = React.useEffect
local useMusicInfo = require(MomentsCreation.Hooks.useMusicInfo)

local MusicThumbnailIconSize = MomentsCommon.Enums.MusicThumbnailIconSize

local function MusicPreviewItem(tbl1)
    local var1 = useMusicInfo(tbl1.musicAssetId)
    local progress, var3 = useBinding(tbl1.progress or 0)

    useEffect(function()
        var3(tbl1.progress or 0)
    end, { tbl1.progress })

    local var4 = React.useCallback(function()
        if tbl1.onMusicSelected then
            tbl1.onMusicSelected(tbl1.musicAssetId)
        end
    end, { tbl1.onMusicSelected, tbl1.musicAssetId })

    local onActivated = React.useCallback(function()
        if tbl1.togglePreviewMusic then
            tbl1.togglePreviewMusic(tbl1.musicAssetId)
        end
    end, { tbl1.togglePreviewMusic, tbl1.musicAssetId })

    if var1 == nil then
        return React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 64) })
    end

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = 0,
        tag = "row align-x-left align-y-center gap-medium auto-y padding-x-xsmall padding-y-small radius-medium",
        Size = 0
    }

    if not tbl1.onMusicSelected then
        var4 = nil
    end

    tbl2.onActivated = var4

    tbl2.Size = UDim2.fromScale(1, 0)
    local tbl3 = {
        MusicThumbnail = React.createElement(MusicThumbnailIcon, { assetId = var1.AssetId, size = MusicThumbnailIconSize.Large }),
        MusicInfo = React.createElement(View, {
            LayoutOrder = 2,
            tag = "col shrink gap-xsmall size-full-0 auto-y"
        }, {
            Title = React.createElement(FoundationText, {
                Text = var1.Title or "",
                tag = "auto-xy text-body-medium text-align-x-left text-align-y-top text-truncate-end content-emphasis"
            }),
            Artist = React.createElement(FoundationText, {
                Text = var1.Artist or "",
                tag = "auto-xy text-body-small text-align-x-left text-align-y-top text-truncate-end content-neutral"
            })
        }),
        PlaybackButton = 0
    }
    local var7

    if tbl1.togglePreviewMusic then
        local createElement2 = React.createElement
        local var8 = View
        local tbl4 = {
            LayoutOrder = 3,
            tag = "position-center-center anchor-center-center size-900-900 padding-xxsmall radius-circle clip"
        }

        local tbl5 = {
            PlaybackIndicator = React.createElement(IconButton, {
                icon = if tbl1.isPreviewing then PauseLarge else PlayLarge,
                isCircular = true,
                onActivated = onActivated,
                size = Foundation.Enums.IconSize.Small,
                variant = Foundation.Enums.ButtonVariant.Standard
            }),
            ProgressBar = if tbl1.progress == nil then nil else React.createElement(RadialProgressBar, { progress = progress })
        }
        var7 = createElement2(var8, tbl4, tbl5)
    else
        var7 = nil
    end

    tbl3.PlaybackButton = var7
    return createElement(var6, tbl2, tbl3)
end

return MusicPreviewItem
