-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CapturesCommon = require(scriptParentParentParentParent.CapturesCommon)
local Cryo = require(scriptParentParentParentParent.Cryo)
local Foundation = require(scriptParentParentParentParent.Foundation)
local Checkbox = Foundation.Checkbox

local React = require(scriptParentParentParentParent.React)
local RoactUtils = require(scriptParentParentParentParent.RoactUtils)
local Images = require(scriptParentParentParentParent.UIBlox).App.ImageSet.Images
local FoundationText = Foundation.Text

local useAnalytics = require(scriptParentParentParent.Analytics.useAnalytics)
local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector

local CaptureType = require(scriptParentParentParent.Enums.CaptureType)
local Constants = require(scriptParentParentParent.Constants)
local EventNames = require(scriptParentParentParent.Analytics.EventNames)
local getContentFromObject = CapturesCommon.Utils.getContentFromObject
local getCropSize = CapturesCommon.Utils.getCropSize
local getFormatTime = require(scriptParentParentParent.Utils.getFormatTime)
local SelectCapture = require(scriptParentParentParent.Thunks.SelectCapture)
local _Types = require(scriptParentParentParent.Types)

local FFlagUseRbxstorageInGallery = require(scriptParentParentParent.Flags.FFlagUseRbxstorageInGallery)

local FFlagEnableCapturesGalleryRetrievalCoreScript = require(scriptParentParentParent.Flags.FFlagEnableCapturesGalleryRetrievalCoreScript)

return function(tbl1)
    local var1 = useAnalytics()
    local var2 = useDispatch()
    local var3, var4 = React.useState(Vector2.new(0, 0))
    local var5, var6 = React.useState(Vector2.new(0, 0))
    local var7, var8 = React.useState(UDim2.fromScale(1, 1))
    local var9, var10 = React.useState(false)

    local var11 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].CaptureManager.SelectedCaptures
    end)

    local onActivated = React.useCallback(function()
        var10(not var9)
        var1.fireEvent(EventNames.CapturesManagerItemActivated)
        var2(SelectCapture(tbl1.capture))
    end, { var9, tbl1.capture })

    local var13 = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize)
    end, {})

    local var14 = React.useCallback(function(arg1)
        local resolution = arg1.Resolution
        var6(resolution)
    end, {})

    React.useEffect(function()
        var8(getCropSize(var3, var5))
    end, { var3, var5 })

    React.useEffect(function()
        var10(Cryo.List.find(var11, tbl1.capture) ~= nil)
    end, { var11, tbl1.capture })

    local createElement = React.createElement
    local str1 = "ImageButton"
    local tbl2 = {
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Image = if FFlagEnableCapturesGalleryRetrievalCoreScript then nil elseif tbl1.capture.type == CaptureType.Screenshot then tbl1.capture.contentId elseif FFlagUseRbxstorageInGallery then tbl1.capture.thumbnailKey else nil,
        ImageContent = if FFlagEnableCapturesGalleryRetrievalCoreScript then getContentFromObject(tbl1.capture) else nil,
        ImageTransparency = if var9 then 0.5 else 0,
        ScaleType = Enum.ScaleType.Crop,
        Size = UDim2.fromScale(1, 1)
    }
    local absoluteSize = React.Change.AbsoluteSize

    if FFlagUseRbxstorageInGallery then
        var13 = nil
    end

    tbl2[absoluteSize] = var13
    tbl2[React.Event.Activated] = onActivated
    local tbl3 = { CheckboxFrame = 0, TimeLength = 0, VideoPreview = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -34, 0, 8),
        Size = UDim2.fromOffset(26, 26),
        ZIndex = 2
    }
    local tbl5 = { Checkbox = 0 }
    local element

    if var9 then
        element = React.createElement(
            Checkbox,
            {
                isChecked = true,
                isDisabled = false,
                LayoutOrder = 1,
                label = "",
                onActivated = onActivated
            }
        )
    else
        element = React.createElement("ImageButton", {
            BackgroundTransparency = 1,
            Image = Images["squircles/hollow"].Image,
            ImageRectOffset = Images["squircles/hollow"].ImageRectOffset,
            ImageRectSize = Images["squircles/hollow"].ImageRectSize,
            ImageTransparency = 0.7,
            Size = UDim2.fromOffset(26, 26),
            [React.Event.Activated] = onActivated
        })
    end

    tbl5.Checkbox = element
    tbl3.CheckboxFrame = createElement2(str2, tbl4, tbl5)
    local element2

    if FFlagEnableCapturesGalleryRetrievalCoreScript and tbl1.capture.CaptureType == Enum.CaptureType.Video then
        element2 = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = getFormatTime(tbl1.capture.TimeLength),
            tag = "text-title-large content-emphasis auto-xy size-full text-align-x-right text-align-y-bottom padding-x-small padding-y-xsmall"
        })
    elseif FFlagEnableCapturesGalleryRetrievalCoreScript and tbl1.capture.CaptureType == Enum.CaptureType.Screenshot
        or not FFlagUseRbxstorageInGallery
        or tbl1.capture.type ~= CaptureType.Video
    then
        element2 = nil
    else
        element2 = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = getFormatTime(tbl1.capture.videoCapture.TimeLength),
            tag = "text-title-large content-emphasis auto-xy size-full text-align-x-right text-align-y-bottom padding-x-small padding-y-xsmall"
        })
    end

    tbl3.TimeLength = element2
    local element3

    if FFlagUseRbxstorageInGallery or tbl1.capture.type ~= CaptureType.Video then
        element3 = nil
    else
        element3 = React.createElement("VideoFrame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            Playing = false,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = var7,
            Video = tbl1.capture.contentId,
            [React.Event.Loaded] = var14
        })
    end

    tbl3.VideoPreview = element3
    return createElement(str1, tbl2, tbl3)
end
