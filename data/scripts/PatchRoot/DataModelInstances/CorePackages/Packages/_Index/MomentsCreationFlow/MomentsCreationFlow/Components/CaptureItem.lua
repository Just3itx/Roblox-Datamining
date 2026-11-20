-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local Foundation = require(MomentsCreationFlowParent.Foundation)
local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local Checkbox = Foundation.Checkbox
local FoundationText = Foundation.Text
local View = Foundation.View

local GradientBackdrop = MomentsCommon.GradientBackdrop

local getContentFromCapture = require(MomentsCreationFlow.Utils.getContentFromCapture)
local getFormatTime = MomentsCommon.Utils.getFormatTime

local useCallback = React.useCallback
local useTokens = Foundation.Hooks.useTokens

return function(tbl1)
    local var1 = useTokens()

    local onActivated = useCallback(function()
        tbl1.onActivated(tbl1.capture)
    end, { tbl1.capture, tbl1.onActivated })

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        onActivated = onActivated,
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "size-full",
        ZIndex = tbl1.zIndex
    }
    local tbl3 = {
        GradientBackdrop = React.createElement(GradientBackdrop, {
            anchorPoint = Vector2.new(0, 1),
            color3 = var1.Color.Common.Scrim.Color3,
            position = UDim2.fromScale(0, 1),
            rotation = 270,
            size = UDim2.fromScale(1, 1),
            startingTransparency = 0.6,
            zIndex = 2
        }),
        Overlay = React.createElement(View, { tag = "padding-medium size-full", ZIndex = 3 }, {
            SelectedIndicator = if tbl1.selected then React.createElement(Checkbox, {
                AnchorPoint = Vector2.new(1, 0),
                isChecked = true,
                onActivated = onActivated,
                Position = UDim2.fromScale(1, 0),
                size = Foundation.Enums.InputSize.Small
            }) else nil,
            TimeLength = if tbl1.capture.CaptureType == Enum.CaptureType.Video then React.createElement(FoundationText, {
                tag = "anchor-bottom-right auto-xy content-emphasis position-bottom-right text-label-medium",
                Text = getFormatTime(tbl1.capture.TimeLength)
            }) else nil
        }),
        CaptureThumbnail = React.createElement("ImageLabel", {
            BorderSizePixel = 0,
            ImageContent = getContentFromCapture(tbl1.capture),
            ScaleType = Enum.ScaleType.Crop,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 1
        })
    }
    return createElement(var3, tbl2, tbl3)
end
