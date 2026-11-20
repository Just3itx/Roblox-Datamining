-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local IconButton = Foundation.IconButton
local Skeleton = Foundation.Skeleton
local FoundationText = Foundation.Text
local View = Foundation.View

local PlayLarge = BuilderIcons.Icon.PlayLarge
local PauseLarge = BuilderIcons.Icon.PauseLarge

local MusicThumbnailIcon = MomentsCommon.MusicThumbnailIcon
local RadialProgressBar = require(MomentsCreationFlow.Components.RadialProgressBar)

local useBinding = React.useBinding
local useEffect = React.useEffect
local useMusicInfo = require(MomentsCreationFlow.Hooks.useMusicInfo)

local MusicThumbnailIconSize = MomentsCommon.Enums.MusicThumbnailIconSize

return function(tbl1)
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

    if not var1 then
        return React.createElement(Skeleton, { Size = UDim2.new(1, 0, 0, 64) })
    end

    local createElement = React.createElement
    local var6 = View
    local tbl2 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = 0,
        tag = "align-x-left align-y-center auto-y row gap-medium padding-x-xsmall padding-y-small radius-medium",
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
            tag = "auto-y col gap-xsmall size-full-0 shrink"
        }, {
            Title = React.createElement(FoundationText, {
                Text = var1.Title,
                tag = "auto-xy text-body-medium content-emphasis text-truncate-end text-align-x-left text-align-y-top"
            }),
            Artist = React.createElement(FoundationText, {
                Text = var1.Artist,
                tag = "auto-xy text-body-small content-neutral text-truncate-end text-align-x-left text-align-y-top"
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
            tag = "anchor-center-center clip position-center-center radius-circle size-900-900 padding-xxsmall"
        }

        local tbl5 = {
            PlaybackIndicator = React.createElement(IconButton, {
                icon = if tbl1.isPreviewing then PauseLarge else PlayLarge,
                isCircular = true,
                onActivated = onActivated,
                size = Foundation.Enums.IconSize.Small,
                variant = Foundation.Enums.ButtonVariant.Standard
            }),
            ProgressBar = if tbl1.progress then React.createElement(RadialProgressBar, { progress = progress }) else nil
        }
        var7 = createElement2(var8, tbl4, tbl5)
    else
        var7 = nil
    end

    tbl3.PlaybackButton = var7
    return createElement(var6, tbl2, tbl3)
end
