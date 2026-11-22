-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)

local Checkbox = Foundation.Checkbox
local FoundationText = Foundation.Text
local View = Foundation.View

local GradientBackdrop = MomentsCommon.Components.GradientBackdrop

local getCaptureContent = require(MomentsCreation.Capture.getCaptureContent)
local getFormatTime = require(MomentsCreation.Utils.getFormatTime)

local FFlagMomentsGalleryCaptureOverlayUpdate = require(MomentsCreation.Flags.FFlagMomentsGalleryCaptureOverlayUpdate)

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
        Overlay = 0,
        CaptureThumbnail = 0
    }

    local createElement2 = React.createElement
    local var4 = View
    local tbl4 = {
        tag = {
            ["size-full padding-small"] = FFlagMomentsGalleryCaptureOverlayUpdate,
            ["size-full padding-medium"] = not FFlagMomentsGalleryCaptureOverlayUpdate
        },
        ZIndex = 3
    }

    local tbl5 = { SelectedIndicator = 0, TimeLengthShadow = 0, TimeLength = 0 }
    local var5

    if tbl1.selected then
        local createElement3 = React.createElement
        local var6 = Checkbox

        local tbl6 = {
            AnchorPoint = Vector2.new(1, 0),
            isChecked = true,
            label = "",
            onActivated = function(_: boolean)
                onActivated()
            end,
            Position = UDim2.fromScale(1, 0),
            size = if FFlagMomentsGalleryCaptureOverlayUpdate then Foundation.Enums.InputSize.XSmall else Foundation.Enums.InputSize.Small
        }

        var5 = createElement3(var6, tbl6)
    else
        var5 = nil
    end

    tbl5.SelectedIndicator = var5
    local element

    if FFlagMomentsGalleryCaptureOverlayUpdate and tbl1.capture.CaptureType == Enum.CaptureType.Video then
        element = React.createElement(FoundationText, {
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, 0, 1, 1),
            tag = "auto-xy text-label-medium",
            Text = getFormatTime(tbl1.capture.TimeLength),
            textStyle = var1.Color.Common.Shadow,
            ZIndex = 1
        })
    else
        element = nil
    end

    tbl5.TimeLengthShadow = element

    tbl5.TimeLength = if tbl1.capture.CaptureType == Enum.CaptureType.Video then React.createElement(FoundationText, {
        tag = "position-bottom-right anchor-bottom-right auto-xy text-label-medium content-emphasis",
        Text = getFormatTime(tbl1.capture.TimeLength),
        ZIndex = if FFlagMomentsGalleryCaptureOverlayUpdate then 2 else nil
    }) else nil
    tbl3.Overlay = createElement2(var4, tbl4, tbl5)

    tbl3.CaptureThumbnail = React.createElement("ImageLabel", {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ImageContent = getCaptureContent(tbl1.capture),
        ScaleType = Enum.ScaleType.Crop,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 1
    })
    return createElement(var3, tbl2, tbl3)
end
