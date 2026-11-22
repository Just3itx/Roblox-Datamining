-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)

local View = Foundation.View

local MusicThumbnailIcon = MomentsCommon.Components.MusicThumbnailIcon
local MusicThumbnailIconSize = MomentsCommon.Enums.MusicThumbnailIconSize

local useMusicInfo = require(Moments.Hooks.useMusicInfo)
local MusicModal = require(Moments.Components.MusicModal)
local FFlagMomentsActionRailSpacing = require(Moments.Flags.FFlagMomentsActionRailSpacing)

return React.memo(function(tbl1) -- name: MusicButton
    local moment = tbl1.moment
    local var1, var2 = React.useState(false)

    local var3 = React.useMemo(function()
        if moment == nil then
            return nil
        end
        local edits = moment.metadata.edits
        if edits == nil then
            return nil
        end
        local music = edits.music
        return if music == nil then nil else music.assetId
    end, { moment })

    local musicInfo = useMusicInfo(var3)

    local onActivated = React.useCallback(function()
        var2(true)
    end, {})

    local onClose = React.useCallback(function()
        var2(false)
    end, {})

    if musicInfo == nil then
        return nil
    end

    return React.createElement(React.Fragment, nil, {
        Button = React.createElement("CanvasGroup", {
            BackgroundTransparency = 1,
            GroupTransparency = tbl1.animationRatio,
            LayoutOrder = tbl1.LayoutOrder,
            Size = UDim2.fromOffset(0, 0),
            AutomaticSize = Enum.AutomaticSize.XY
        }, {
            Inner = React.createElement(View, {
                isDisabled = tbl1.isDisabled,
                onActivated = onActivated,
                tag = if FFlagMomentsActionRailSpacing then "align-x-center align-y-center size-1000-1000 radius-medium" else "align-x-center align-y-center size-1200-1200 radius-medium"
            }, {
                MusicThumbnail = React.createElement(MusicThumbnailIcon, { assetId = musicInfo.AssetId, size = MusicThumbnailIconSize.Small })
            })
        }),
        Modal = if var1 then React.createElement(MusicModal, { musicInfo = musicInfo, onClose = onClose }) else nil
    })
end)
