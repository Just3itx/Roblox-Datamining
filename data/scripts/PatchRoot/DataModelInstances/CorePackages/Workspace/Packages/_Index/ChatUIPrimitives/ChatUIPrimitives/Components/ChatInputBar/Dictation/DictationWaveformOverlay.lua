-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitivesParent = script:FindFirstAncestor("ChatUIPrimitives").Parent
local React = require(ChatUIPrimitivesParent.React)
local ReactIs = require(ChatUIPrimitivesParent.ReactIs)
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local Components = require(ChatUIPrimitivesParent.DictationCore.Components)

return React.memo(function(tbl1) -- name: DictationWaveformOverlay
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "position-center-left anchor-center-left",
        Size = UDim2.new(1, 0, 0, tbl1.lineHeight),
        Visible = tbl1.isAudioActiveBinding,
        ZIndex = 3
    }
    local tbl3 = {
        Waveform = React.createElement(Components.Waveform, {
            isActive = tbl1.isAudioActive,
            audioDeviceInput = tbl1.audioDeviceInput,
            onSample = tbl1.onWaveformSample,
            transcribedSamplesBinding = tbl1.transcribedSamplesBinding,
            transparencyValue = if ReactIs.isBinding(tbl1.transparencyValue) then tbl1.transparencyValue else nil
        })
    }
    return createElement(view, tbl2, tbl3)
end)
