-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)
local SignalsReact = require(MomentsCommonParent.SignalsReact)
local _MomentsTypes = require(MomentsCommonParent.MomentsTypes)

local useSignalState = SignalsReact.useSignalState

local StickerOverlay = require(MomentsCommon.Components.StickerOverlay)
local OverlayDisplay = require(MomentsCommon.Components.OverlayDisplay)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local _mediaNodeRegistry = require(MomentsCommon.Media.mediaNodeRegistry)
local overlayScale = require(MomentsCommon.Media.overlayScale)

local GetFFlagMomentsStickerOverlayMediaRect = require(MomentsCommon.Flags.GetFFlagMomentsStickerOverlayMediaRect)

local signal = Signals.createSignal(Enum.ScaleType.Crop)

local function StickerOverlayLayer(tbl1)
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

    return React.createElement(OverlayDisplay, {
        overlayComponent = StickerOverlay,
        itemResolution = var3,
        itemSize = itemSize,
        scaleType = scaleType,
        overlayEdits = { tbl1.overlay },
        draggable = false,
        editable = false
    })
end

local function LegacyStickerOverlayLayer(tbl1)
    local var1 = useSignalState(tbl1.getItemSize)
    local additionalScale = overlayScale(1, var1.X)

    return React.createElement(
        StickerOverlay,
        {
            additionalScale = additionalScale,
            draggable = false,
            editable = false,
            overlayEdit = tbl1.overlay
        }
    )
end
return {
    kind = "sticker",
    create = function(arg1, _) -- name: createStickerOverlayNode
        local overlay = arg1.overlay
        assert(overlay ~= nil, "createStickerOverlayNode: spec.overlay (a StickerOverlayEdit) is required")

        local zIndex = arg1.zIndex or overlay.zIndex

        return {
            id = arg1.id,
            kind = "sticker",
            assets = function()
                return {}
            end,
            download = function() end,
            usesDecoder = false,
            zIndex = zIndex,
            render = function(arg2)
                if not GetFFlagMomentsStickerOverlayMediaRect() then
                    return React.createElement(LegacyStickerOverlayLayer, { overlay = overlay, getItemSize = arg2.getItemSize })
                end

                return React.createElement(StickerOverlayLayer, {
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
