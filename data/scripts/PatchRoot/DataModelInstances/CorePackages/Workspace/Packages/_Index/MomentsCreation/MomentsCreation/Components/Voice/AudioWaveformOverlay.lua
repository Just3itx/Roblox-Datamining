-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local View = Foundation.View

local useTokens = Foundation.Hooks.useTokens

local useState = React.useState
local useMemo = React.useMemo
local useCallback = React.useCallback

local resampleWaveformPeaks = require(MomentsCreation.Utils.resampleWaveformPeaks)

local GetFIntMomentsTTSWaveformMinBarHeightPercent = require(MomentsCreation.Flags.GetFIntMomentsTTSWaveformMinBarHeightPercent)

local GetFIntMomentsTTSWaveformMaxBarHeightPercent = require(MomentsCreation.Flags.GetFIntMomentsTTSWaveformMaxBarHeightPercent)
local GetFFlagMomentsTTSStartTimePositioning = require(MomentsCreation.Flags.GetFFlagMomentsTTSStartTimePositioning)

local function AudioWaveformOverlay(tbl1)
    local var1 = useTokens()
    local var2, var3 = useState(0)

    local var4 = useCallback(function(arg1)
        var3(arg1.AbsoluteSize.X)
    end, {})

    local var5 = useMemo(function(): number
        if var2 <= 0 then
            return 0
        end

        return math.max(1, math.floor((var2 - 8) / 4))
    end, { var2 })

    local samples = tbl1.samples

    local samplesLen = #samples
    if GetFFlagMomentsTTSStartTimePositioning and tbl1.audioDuration > 0 and tbl1.videoDuration > 0 then
        local num1 = math.clamp((tbl1.videoDuration - (tbl1.startTime or 0)) / tbl1.audioDuration, 0, 1)
        samplesLen = math.floor(#samples * num1 + 0.5)
    end

    local var6 = useMemo(function()
        local result = ({})

        local var6 = GetFIntMomentsTTSWaveformMinBarHeightPercent() / 100
        local var7 = GetFIntMomentsTTSWaveformMaxBarHeightPercent() / 100
        local var8 = if samplesLen >= #samples then samples else table.move(samples, 1, samplesLen, 1, {})

        for layoutOrder, value2 in (resampleWaveformPeaks(var8, var5, var6, var7)) do
            local var9 = "bar_" .. layoutOrder
            local createElement = React.createElement
            local tbl2 = {
                Size = UDim2.new(0, 2, value2, 0),
                BackgroundColor3 = var1.Color.Content.Emphasis.Color3,
                BackgroundTransparency = 0.3,
                BorderSizePixel = 0,
                LayoutOrder = layoutOrder
            }
            local tbl3 = {
                Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 2) })
            }
            result[var9] = createElement("Frame", tbl2, tbl3)
        end

        return result
    end, {
        var5,
        samples,
        samplesLen,
        var1
    })
    if tbl1.videoDuration <= 0 then
        return nil
    end

    local xScale = math.clamp(tbl1.audioDuration / tbl1.videoDuration, 0, 1)
    local xScale2, num1

    if GetFFlagMomentsTTSStartTimePositioning then
        xScale2 = math.clamp((tbl1.startTime or 0) / tbl1.videoDuration, 0, 1)

        xScale = math.clamp(tbl1.audioDuration / tbl1.videoDuration, 0, 1 - xScale2)
        num1 = 2
    else
        xScale2 = 0
        num1 = 1
    end

    return React.createElement("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.fromScale(xScale2, 0.5),
        Size = UDim2.new(xScale, 0, 1, 0),
        BackgroundColor3 = var1.Color.ActionEmphasis.Background.Color3,
        BackgroundTransparency = 0.4,
        BorderSizePixel = 0,
        ZIndex = 2,
        [React.Change.AbsoluteSize] = var4
    }, {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 6) }),
        Stroke = React.createElement(
            "UIStroke",
            {
                Color = Color3.new(1, 1, 1),
                Transparency = if tbl1.isSelected then 0 else 0.6,
                Thickness = num1
            }
        ),
        DragDetector = if GetFFlagMomentsTTSStartTimePositioning and tbl1.dragDetectorRef ~= nil then React.createElement(
            "UIDragDetector",
            {
                DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine,
                ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomScale,
                ref = tbl1.dragDetectorRef
            }
        ) else nil,
        BarsContainer = React.createElement(View, {
            tag = "size-full-full clip",
            ZIndex = 1,
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 2),
                SortOrder = Enum.SortOrder.LayoutOrder
            },
            padding = {
                left = UDim.new(0, 4),
                right = UDim.new(0, 4)
            }
        }, {
            Bars = React.createElement(React.Fragment, nil, var6)
        })
    })
end

return AudioWaveformOverlay
