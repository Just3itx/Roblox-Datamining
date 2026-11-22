-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local React = require(MomentsCreationParent.React)

local View = Foundation.View

local useAudioWaveform = require(MomentsCreation.Hooks.useAudioWaveform)
local useTokens = Foundation.Hooks.useTokens

local Constants = require(MomentsCreation.Constants)

local WaveformWidth = Constants.AudioWaveform.WaveformWidth
local WaveformPadding = Constants.AudioWaveform.WaveformPadding
local WaveformMinHeight = Constants.AudioWaveform.WaveformMinHeight

return React.forwardRef(function(tbl1, ref) -- name: Waveform
    local var1 = useTokens()
    local var2 = useAudioWaveform(tbl1.audioAssetId, tbl1.videoDuration)

    React.useEffect(function()
        if var2 and #var2 > 0 then
            tbl1.onWaveformReady()
        end
    end, { tbl1.audioAssetId, tbl1.onWaveformReady, var2 })

    return React.createElement(
        View,
        {
            Position = tbl1.position,
            tag = "align-x-left align-y-center anchor-center-left auto-x size-0-full row",
            ZIndex = tbl1.zIndex,
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, WaveformPadding)
            },
            ref = ref
        },
        Dash.map(var2, function(yScale: number, num1: number)
            return React.createElement(View, {
                key = num1,
                LayoutOrder = num1,
                Size = UDim2.new(0, WaveformWidth, yScale, WaveformMinHeight),
                backgroundStyle = var1.Color.Content.Muted,
                tag = "radius-circle"
            })
        end)
    )
end)
