-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local CapturesCommon = require(scriptParentParentParentParent.CapturesCommon)
local Foundation = require(scriptParentParentParentParent.Foundation)
local React = require(scriptParentParentParentParent.React)

local Checkbox = Foundation.Checkbox
local View = Foundation.View

local getCropSize = CapturesCommon.Utils.getCropSize
local getFitSize = CapturesCommon.Utils.getFitSize

local FFlagCapturePromptItemUseFit = require(scriptParentParentParent.Flags.FFlagCapturePromptItemUseFit)

return function(tbl1)
    local var1, var2 = React.useState(Vector2.new(0, 0))
    local var3 = React.useRef(nil)
    local var4, var5 = React.useState(Vector2.new(0, 0))

    local onActivated = React.useCallback(function()
        tbl1.updateSelected(not tbl1.isSelected)
    end, { tbl1.isSelected, tbl1.updateSelected })

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var2(arg1.AbsoluteSize)
    end, {})

    local var8 = React.useCallback(function(current)
        var3.current = current
        var5(current.Resolution)
    end, {})

    React.useEffect(function()
        return function()
            if var3.current then
                var3.current.Video = ""
            end
        end
    end, {})

    local isVideoCapture = typeof(tbl1.content) == "Content" and tbl1.content.Object ~= nil and tbl1.content.Object:IsA("VideoCapture")

    local createElement = React.createElement
    local var9 = View
    local tbl2 = { tag = "clip size-full", onAbsoluteSizeChanged = onAbsoluteSizeChanged }
    local tbl3 = { CheckboxOverlay = 0, Image = 0, Video = 0 }
    local element

    if tbl1.showCheckbox then
        element = React.createElement(View, {
            tag = "size-full padding-small",
            onActivated = onActivated,
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            ZIndex = 2
        }, {
            Checkbox = React.createElement(Checkbox, {
                AnchorPoint = Vector2.new(1, 0),
                isChecked = tbl1.isSelected,
                label = "",
                onActivated = onActivated,
                Position = UDim2.fromScale(1, 0)
            })
        })
    else
        element = nil
    end

    tbl3.CheckboxOverlay = element
    local element2

    if isVideoCapture then
        element2 = nil
    else
        element2 = React.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            ImageContent = tbl1.content,
            Position = UDim2.fromScale(0.5, 0.5),
            ScaleType = if FFlagCapturePromptItemUseFit then Enum.ScaleType.Fit else Enum.ScaleType.Crop,
            Size = UDim2.fromScale(1, 1)
        })
    end

    tbl3.Image = element2
    local element3 = if isVideoCapture then React.createElement("VideoFrame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Looped = true,
        Playing = true,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = if FFlagCapturePromptItemUseFit then getFitSize(var1, var4) else getCropSize(var1, var4),
        VideoContent = tbl1.content,
        Volume = 0,
        [React.Event.Loaded] = var8
    }) else nil
    tbl3.Video = element3
    return createElement(var9, tbl2, tbl3)
end
