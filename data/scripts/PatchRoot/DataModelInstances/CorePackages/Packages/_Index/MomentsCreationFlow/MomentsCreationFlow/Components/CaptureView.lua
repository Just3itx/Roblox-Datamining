-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlowParent = script:FindFirstAncestor("MomentsCreationFlow").Parent

local BuilderIcons = require(MomentsCreationFlowParent.BuilderIcons)
local Dash = require(MomentsCreationFlowParent.Dash)
local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Image = BuilderIcons.Icon.Image

local Icon = Foundation.Icon
local View = Foundation.View

local LoadableVideo = MomentsCommon.LoadableVideo

local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()

    if not tbl1.capture then
        return React.createElement(View, { tag = "bg-shift-200 radius-large size-full" }, {
            EmptyState = React.createElement(Icon, {
                AnchorPoint = Vector2.new(0.5, 0.5),
                LayoutOrder = 2,
                name = Image,
                Position = UDim2.fromScale(0.5, 0.5),
                size = var1.Size.Size_1200,
                style = var1.Color.Shift.Shift_400
            })
        })
    end

    local createElement = React.createElement
    local var2 = View
    local tbl2 = { tag = "size-full" }

    local tbl3 = {
        UIPadding = if tbl1.scaleType == Enum.ScaleType.Fit then React.createElement("UIPadding", {
            PaddingTop = UDim.new(0, 0),
            PaddingBottom = UDim.new(0, 0),
            PaddingLeft = UDim.new(0, 0),
            PaddingRight = UDim.new(0, 0)
        }) else nil,
        Overlay = React.createElement(React.Fragment, {}, tbl1.children),
        VideoPreview = 0,
        ImagePreview = 0
    }
    local element

    if tbl1.capture.CaptureType == Enum.CaptureType.Video then
        element = React.createElement(LoadableVideo, {
            cornerRadius = var1.Radius.Large,
            Looped = false,
            onLoaded = Dash.noop,
            onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
            onResolutionChanged = tbl1.onResolutionChanged,
            Playing = true,
            renderOnFailed = tbl1.onRenderFailed,
            Size = UDim2.fromScale(1, 1),
            scaleType = tbl1.scaleType,
            videoRef = tbl1.playbackController.videoRef
        })
    else
        element = nil
    end

    tbl3.VideoPreview = element
    local element2

    if tbl1.capture.CaptureType == Enum.CaptureType.Screenshot then
        element2 = React.createElement("ImageLabel", {
            BackgroundTransparency = 1,
            ref = tbl1.playbackController.imageRef,
            ScaleType = tbl1.scaleType,
            Size = UDim2.fromScale(1, 1),
            [React.Change.AbsoluteSize] = tbl1.onAbsoluteSizeChanged
        })
    else
        element2 = nil
    end

    tbl3.ImagePreview = element2
    return createElement(var2, tbl2, tbl3)
end
