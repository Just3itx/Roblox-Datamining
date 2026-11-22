-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:00:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local Dash = require(MomentsCreationParent.Dash)
local Foundation = require(MomentsCreationParent.Foundation)
local MomentsCommon = require(MomentsCreationParent.MomentsCommon)
local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)
local SignalsReact = require(MomentsCreationParent.SignalsReact)

local View = Foundation.View

local useCallback = React.useCallback
local useMemo = React.useMemo
local useSignalState = SignalsReact.useSignalState

local OverlayDisplay = MomentsCommon.Components.OverlayDisplay
local StickerOverlay = MomentsCommon.Components.StickerOverlay

local CreationFlowState = require(MomentsCreation.Enums.CreationFlowState)
local _CreationFlowTypes = require(MomentsCreation.Types.CreationFlowTypes)
local _MomentsTypes = require(MomentsCreationParent.MomentsTypes)

local function StickerOverlayLayer(tbl1)
    local controller = tbl1.controller

    local var1 = useSignalState(controller.getStep)
    local itemSize = useSignalState(tbl1.ctx.getItemSize)
    local stickerOverlays = useSignalState(controller.getComposedEdits).stickerOverlays

    local var3 = useMemo(function()
        return Signals.createComputed(function(arg1)
            local activeSession = controller.getActiveSession(arg1)
            if activeSession ~= nil then
                return (activeSession.getDraft(arg1))
            end

            return nil
        end)
    end, { controller })
    local var4 = useSignalState(var3)

    local bool1 = var1 == CreationFlowState.StickerOverlay
    local var5 = var4 and var4[1]

    local var6 = useCallback(function()
        controller.beginTool("sticker")
    end, { controller })

    local var7 = useCallback(function(tbl2)
        controller.updateCommittedEdit("sticker", tbl2)
    end, { controller })

    if bool1 then
        return React.createElement(View, {
            stateLayer = {
                affordance = Foundation.Enums.StateLayerAffordance.None
            },
            tag = "size-full bg-over-media-0",
            ZIndex = tbl1.zIndex or 1
        }, {
            ImageOverlay = if var5 == nil or var5.stickerURI == nil then nil else React.createElement(
                StickerOverlay,
                {
                    overlayEdit = Dash.joinDeep(var5, { position = UDim2.fromScale(0.5, 0.5), rotation = 0 })
                }
            )
        })
    end

    if stickerOverlays == nil or #stickerOverlays == 0 then
        return nil
    end

    local draggable = var1 == CreationFlowState.Preview

    local createElement = React.createElement
    local var8 = OverlayDisplay
    local tbl2 = {
        draggable = draggable,
        editable = false,
        itemResolution = nil,
        itemSize = itemSize,
        scaleType = Enum.ScaleType.Crop,
        onOverlayActivated = 0,
        onOverlayDragEnd = 0,
        overlayEdits = 0,
        overlayComponent = 0,
        zIndex = 0
    }

    if not draggable then
        var6 = nil
    end

    tbl2.onOverlayActivated = var6
    if not draggable then
        var7 = nil
    end

    tbl2.onOverlayDragEnd = var7
    tbl2.overlayEdits = stickerOverlays
    tbl2.overlayComponent = StickerOverlay
    tbl2.zIndex = tbl1.zIndex
    return createElement(var8, tbl2)
end

return StickerOverlayLayer
