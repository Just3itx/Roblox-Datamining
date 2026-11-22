-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:10:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommonParent = script:FindFirstAncestor("MomentsCommon").Parent

local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)
local View = Foundation.View

local Image = Foundation.Image

local useCallback = React.useCallback

local _MomentsTypes = require(MomentsCommonParent.MomentsTypes)

local function StickerOverlay(tbl1)
    local ref = React.useRef(nil)
    local var2 = React.useRef(nil)

    local var3 = useCallback(function(_, vector2: Vector2)
        if tbl1.containerRef and tbl1.containerRef.current then
            var2.current = vector2
        end
    end, { tbl1.containerRef })

    local var4 = useCallback(function(_, vector2: Vector2)
        if var2.current == vector2 and tbl1.onActivated then
            tbl1.onActivated()
        end

        if tbl1.onDragEnd then
            tbl1.onDragEnd()
        end
    end, { tbl1.onActivated, tbl1.onDragEnd })

    local uiDragDetector = React.useMemo(function()
        if not tbl1.draggable then
            return nil
        end

        return React.createElement("UIDragDetector", {
            BoundingBehavior = Enum.UIDragDetectorBoundingBehavior.EntireObject,
            BoundingUI = tbl1.boundingUI,
            DragStyle = Enum.UIDragDetectorDragStyle.TranslatePlane,
            ref = ref,
            ReferenceUIInstance = tbl1.referenceUI or tbl1.boundingUI,
            ResponseStyle = Enum.UIDragDetectorResponseStyle.Scale,
            [React.Event.DragStart] = var3,
            [React.Event.DragEnd] = var4
        })
    end, {
        tbl1.boundingUI,
        tbl1.draggable,
        tbl1.referenceUI,
        var3,
        var4
    })
    return React.createElement(View, {
        ref = tbl1.containerRef,
        onActivated = tbl1.onActivated,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        Position = tbl1.overlayEdit.position,
        Rotation = tbl1.overlayEdit.rotation,
        scale = tbl1.overlayEdit.scale * (tbl1.additionalScale or 1),
        stateLayer = {
            affordance = Foundation.Enums.StateLayerAffordance.None
        },
        tag = "position-center-center anchor-center-center auto-xy",
        ZIndex = tbl1.overlayEdit.zIndex
    }, {
        UIDragDetector = uiDragDetector,
        StickerImage = React.createElement(Image, {
            Image = tbl1.overlayEdit.stickerURI,
            Size = UDim2.fromOffset(tbl1.overlayEdit.stickerSize, tbl1.overlayEdit.stickerSize),
            ZIndex = tbl1.overlayEdit.zIndex or 1
        })
    })
end

return StickerOverlay
