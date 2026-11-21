-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)

local CaptureType = require(scriptParentParent.Enums.CaptureType)
local MediaPlayer = require(scriptParentParent.Components.MediaPlayer)
local _Types = require(scriptParentParent.Types)
local getCropSize = require(scriptParentParent.Utils.getCropSize)
local getFitSize = require(scriptParentParent.Utils.getFitSize)

local FFlagUseRbxStorageInCapturesCommon = require(scriptParentParent.Flags.FFlagUseRbxStorageInCapturesCommon)

return function(tbl1)
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3, var4 = React.useState(Vector2.new(0, 0))
    local var5, var6 = React.useState(UDim2.fromScale(1, 1))

    local var7 = React.useCallback(function(arg1)
        local resolution = arg1.Resolution
        var4(resolution)
    end, {})

    local var8 = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
    end, {})

    React.useEffect(function()
        if tbl1.scaleType == Enum.ScaleType.Fit then
            var6(getFitSize(var1, var3))
            return
        end
        var6(getCropSize(var1, var3))
    end, { var1, var3 })

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl2 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Image = if tbl1.capture.type == CaptureType.Screenshot then tbl1.capture.contentId elseif FFlagUseRbxStorageInCapturesCommon then tbl1.capture.thumbnailKey else nil,
        ScaleType = tbl1.scaleType or Enum.ScaleType.Crop,
        Size = UDim2.fromScale(1, 1)
    }
    local absoluteSize = React.Change.AbsoluteSize

    if FFlagUseRbxStorageInCapturesCommon then
        var8 = nil
    end

    tbl2[absoluteSize] = var8
    tbl2[React.Event.Activated] = tbl1.onActivated
    local tbl3 = {
        Overlay = tbl1.overlay,
        VideoPreview = 0
    }
    local element

    if FFlagUseRbxStorageInCapturesCommon
        and tbl1.capture.type == CaptureType.Video
        and tbl1.shouldUseMediaPlayer
        and tbl1.mediaPlayerProps
    then
        element = React.createElement(MediaPlayer, tbl1.mediaPlayerProps)
    elseif FFlagUseRbxStorageInCapturesCommon or tbl1.capture.type ~= CaptureType.Video then
        element = nil
    elseif tbl1.shouldUseMediaPlayer and tbl1.mediaPlayerProps then
        element = React.createElement(MediaPlayer, tbl1.mediaPlayerProps)
    else
        element = React.createElement("VideoFrame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Playing = tbl1.isVideoPlaying == true,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = var5,
            Video = tbl1.capture.contentId,
            [React.Event.Loaded] = var7
        })
    end

    tbl3.VideoPreview = element
    return createElement(str1, tbl2, tbl3)
end
