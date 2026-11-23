-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CapturesCommon = require(scriptParentParentParentParent.CapturesCommon)
local Foundation = require(scriptParentParentParentParent.Foundation)
local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local CaptureType = require(scriptParentParentParent.Enums.CaptureType)
local CarouselOpened = require(scriptParentParentParent.Actions.CarouselOpened)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local getContentFromObject = CapturesCommon.Utils.getContentFromObject
local getCropSize = CapturesCommon.Utils.getCropSize
local getFormatTime = require(scriptParentParentParent.Utils.getFormatTime)
local _Types = require(scriptParentParentParent.Types)

local FoundationText = Foundation.Text

local FFlagUseRbxstorageInGallery = require(scriptParentParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()

    local var3, var4 = React.useState(Vector2.new(0, 0))
    local var5, var6 = React.useState(Vector2.new(0, 0))
    local var7, var8 = React.useState(UDim2.fromScale(1, 1))

    local var9 = React.useCallback(function()
        var1.fireEvent(EventNames.CapturesCarouselOpened)
        var2(CarouselOpened(tbl1.captureIndex))
    end, {})

    local var10 = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize)
    end, {})

    local var11 = React.useCallback(function(arg1)
        local resolution = arg1.Resolution
        var6(resolution)
    end, {})

    React.useEffect(function()
        var8(getCropSize(var3, var5))
    end, { var3, var5 })

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl2 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Image = if FFlagEnableCapturesGalleryRetrievalCoreScript then nil elseif tbl1.capture.type == CaptureType.Screenshot then tbl1.capture.contentId elseif tbl1.capture.type == CaptureType.Video then tbl1.capture.thumbnailKey else nil,
        ImageContent = if FFlagEnableCapturesGalleryRetrievalCoreScript then getContentFromObject(tbl1.capture) else nil,
        ScaleType = Enum.ScaleType.Crop,
        Size = UDim2.fromScale(1, 1)
    }
    local absoluteSize = React.Change.AbsoluteSize

    if FFlagUseRbxstorageInGallery then
        var10 = nil
    end

    tbl2[absoluteSize] = var10
    tbl2[React.Event.Activated] = var9
    local tbl3 = { TimeLength = 0, VideoPreview = 0 }
    local element

    if FFlagEnableCapturesGalleryRetrievalCoreScript and tbl1.capture.CaptureType == Enum.CaptureType.Video then
        element = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = getFormatTime(tbl1.capture.TimeLength),
            tag = "text-title-large content-emphasis auto-xy size-full text-align-x-right text-align-y-bottom padding-x-small padding-y-xsmall"
        })
    elseif FFlagEnableCapturesGalleryRetrievalCoreScript and tbl1.capture.CaptureType == Enum.CaptureType.Screenshot
        or not FFlagUseRbxstorageInGallery
        or tbl1.capture.type ~= CaptureType.Video
    then
        element = nil
    else
        element = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = getFormatTime(tbl1.capture.videoCapture.TimeLength),
            tag = "text-title-large content-emphasis auto-xy size-full text-align-x-right text-align-y-bottom padding-x-small padding-y-xsmall"
        })
    end

    tbl3.TimeLength = element
    local element2

    if FFlagUseRbxstorageInGallery or tbl1.capture.type ~= CaptureType.Video then
        element2 = nil
    else
        element2 = React.createElement("VideoFrame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Playing = false,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = var7,
            Video = tbl1.capture.contentId,
            [React.Event.Loaded] = var11
        })
    end

    tbl3.VideoPreview = element2
    return createElement(str1, tbl2, tbl3)
end
