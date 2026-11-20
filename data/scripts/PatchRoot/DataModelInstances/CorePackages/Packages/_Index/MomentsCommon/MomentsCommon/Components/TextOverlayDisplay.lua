-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local Dash = require(MomentsCommonParent.Dash)
local Foundation = require(MomentsCommonParent.Foundation)
local React = require(MomentsCommonParent.React)

local useCallback = React.useCallback
local useMemo = React.useMemo

local View = Foundation.View

local TextOverlay = require(MomentsCommon.Components.TextOverlay)

local getCropSize = require(MomentsCommon.Utils.getCropSize)
local getFitSize = require(MomentsCommon.Utils.getFitSize)
local getScale = require(MomentsCommon.Utils.getScale)

local _Types = require(MomentsCommon.Types)

local function TextOverlayDisplay(tbl1)
    local ref = React.useRef(nil)
    local containerRef = React.useRef(nil)
    local textOverlayEdit = if tbl1.textOverlayEdits then tbl1.textOverlayEdits[1] or nil else nil

    local var3, additionalScale = useMemo(function()
        if not tbl1.itemResolution then
            return UDim2.fromScale(1, 1), 1
        end

        local fitSize = getFitSize(tbl1.itemSize, tbl1.itemResolution)
        local cropSize = getCropSize(tbl1.itemSize, tbl1.itemResolution)
        local scale = getScale(tbl1.itemSize, tbl1.itemResolution, tbl1.scaleType)

        if tbl1.scaleType == Enum.ScaleType.Fit then
            return fitSize, scale
        end
        return cropSize, scale
    end, { tbl1.scaleType, tbl1.itemResolution, tbl1.itemSize })

    local onDragEnd = useCallback(function()
        if not (containerRef.current and tbl1.onTextOverlayDragEnd) then
            return
        end
        local var5 = Dash.joinDeep(textOverlayEdit, { position = containerRef.current.Position })

        tbl1.onTextOverlayDragEnd({ var5 })
    end, { tbl1.onTextOverlayDragEnd, textOverlayEdit })

    local var6 = useCallback(function(textOverlayEdit2)
        return React.createElement(TextOverlay, {
            additionalScale = additionalScale,
            boundingUI = ref.current,
            containerRef = containerRef,
            draggable = tbl1.draggable,
            onActivated = tbl1.onTextOverlayActivated,
            onDragEnd = onDragEnd,
            textOverlayEdit = textOverlayEdit2
        })
    end, { tbl1.draggable, tbl1.onTextOverlayActivated, additionalScale })

    if not tbl1.textOverlayEdits or #tbl1.textOverlayEdits == 0 then
        return nil
    end

    return React.createElement(
        View,
        {
            ref = ref,
            Size = var3,
            tag = "anchor-center-center position-center-center",
            ZIndex = tbl1.zIndex or 1
        },
        {
            TextOverlay = var6(textOverlayEdit)
        }
    )
end
return TextOverlayDisplay
