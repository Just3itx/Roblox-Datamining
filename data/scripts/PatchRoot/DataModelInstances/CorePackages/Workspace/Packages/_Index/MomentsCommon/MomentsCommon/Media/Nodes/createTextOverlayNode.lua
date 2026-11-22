-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)
local SignalsReact = require(MomentsCommonParent.SignalsReact)
local _MomentsTypes = require(MomentsCommonParent.MomentsTypes)

local useSignalState = SignalsReact.useSignalState

local TextOverlayDisplay = require(MomentsCommon.Components.TextOverlayDisplay)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)

local signal = Signals.createSignal(Enum.ScaleType.Crop)

local function TextOverlayLayer(tbl1)
    local getResolution = tbl1.getResolution
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return getResolution(arg1)
        end)
    end, { getResolution })

    local itemSize = useSignalState(tbl1.getItemSize)
    local var3 = useSignalState(var1)
    local scaleType = useSignalState(tbl1.getScaleType or signal)

    if var3 == nil then
        var3 = itemSize
    end

    return React.createElement(TextOverlayDisplay, {
        itemResolution = var3,
        itemSize = itemSize,
        scaleType = scaleType,
        textOverlayEdits = { tbl1.overlay },
        draggable = false,
        editable = false
    })
end

return {
    kind = "text",
    create = function(arg1, _) -- name: createTextOverlayNode
        local overlay = arg1.overlay
        assert(overlay ~= nil, "createTextOverlayNode: spec.overlay (a TextOverlayEdit) is required")

        local zIndex = arg1.zIndex or overlay.zIndex

        return {
            id = arg1.id,
            kind = "text",
            assets = function()
                return {}
            end,
            download = function() end,
            usesDecoder = false,
            zIndex = zIndex,
            render = function(arg2)
                return React.createElement(TextOverlayLayer, {
                    overlay = overlay,
                    getItemSize = arg2.getItemSize,
                    getResolution = arg2.getResolution,
                    getScaleType = arg2.getScaleType
                })
            end,
            dispose = function() end
        }
    end
}
