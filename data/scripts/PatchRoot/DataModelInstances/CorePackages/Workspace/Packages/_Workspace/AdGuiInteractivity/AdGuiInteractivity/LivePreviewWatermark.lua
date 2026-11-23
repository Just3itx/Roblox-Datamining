-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T05:11:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Roact = require(scriptParentParent.Roact)

local Flags = require(script.Parent.Flags)
local fStringAdGuiLivePreviewWatermark = Flags.GetFStringAdGuiLivePreviewWatermark()
local fStringAdGuiLivePreviewWatermarkV2 = Flags.GetFStringAdGuiLivePreviewWatermarkV2()
local fStringLivePreviewPlaceId = Flags.GetFStringLivePreviewPlaceId()
local fFlagUseV2LivePreviewWatermark = Flags.GetFFlagUseV2LivePreviewWatermark()

local var1 = Roact.PureComponent:extend("LivePreviewWatermark")

function var1.init(arg1)
    arg1.placeId = tostring(game.PlaceId)
end

function var1.render(arg1)
    if fStringLivePreviewPlaceId ~= arg1.placeId or not arg1.props.IsVisible then
        return nil
    end

    return Roact.createElement("ImageLabel", {
        Image = fFlagUseV2LivePreviewWatermark and fStringAdGuiLivePreviewWatermarkV2 or fStringAdGuiLivePreviewWatermark,
        Size = fFlagUseV2LivePreviewWatermark and UDim2.new(1, 0, 1, 0) or UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = -999,
        Transparency = 1,
        ImageTransparency = if fFlagUseV2LivePreviewWatermark then 0 else 0.7,
        Rotation = if fFlagUseV2LivePreviewWatermark then 0 else 15
    })
        or nil
end

return var1
