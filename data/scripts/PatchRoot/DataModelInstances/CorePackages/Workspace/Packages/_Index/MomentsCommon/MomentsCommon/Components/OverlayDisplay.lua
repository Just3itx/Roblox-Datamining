-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:27Z
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

local clampOverlayPosition = require(MomentsCommon.Utils.clampOverlayPosition)
local getCropSize = require(MomentsCommon.Utils.getCropSize)
local getFitSize = require(MomentsCommon.Utils.getFitSize)
local getScale = require(MomentsCommon.Utils.getScale)

local function getAbsoluteSize(uDim2: UDim2, vector2: Vector2): Vector2
    return Vector2.new(vector2.X * uDim2.X.Scale + uDim2.X.Offset, vector2.Y * uDim2.Y.Scale + uDim2.Y.Offset)
end

local function getVisibleBounds(vector2: Vector2, vector2_2: Vector2)
    return Vector2.new(math.max((vector2.X - vector2_2.X) / 2, 0), math.max((vector2.Y - vector2_2.Y) / 2, 0)), Vector2.new(math.min(vector2.X, vector2_2.X), math.min(vector2.Y, vector2_2.Y))
end

local function arePositionsEqual(uDim2: UDim2, uDim2_2: UDim2): boolean
    local var1 = uDim2.X.Scale - uDim2_2.X.Scale

    if math.abs(var1) < 0.0001
        and math.abs(uDim2.X.Offset - uDim2_2.X.Offset) < 0.0001
        and math.abs(uDim2.Y.Scale - uDim2_2.Y.Scale) < 0.0001
    then
        return math.abs(uDim2.Y.Offset - uDim2_2.Y.Offset) < 0.0001
    end

    return false
end

local function OverlayDisplay(tbl1)
    local ref = React.useRef(nil)
    local var1 = React.useRef(nil)
    local containerRef = React.useRef(nil)
    local var4, var5 = React.useState(Vector2.new(0, 0))
    local overlayEdit = if tbl1.overlayEdits then tbl1.overlayEdits[1] or nil else nil

    local uDim2, var6 = useMemo(function()
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

    local var7 = useMemo(function(): Vector2
        return getAbsoluteSize(uDim2, tbl1.itemSize)
    end, { uDim2, tbl1.itemSize })
    local var8, var9 = useMemo(function()
        return getVisibleBounds(var7, tbl1.itemSize)
    end, { var7, tbl1.itemSize })

    local var10 = useCallback(function(uDim2_2: UDim2)
        if not overlayEdit then
            return nil
        end

        if tbl1.clampToBoundsEnabled == true then
            uDim2_2 = clampOverlayPosition(uDim2_2, var7, var4, var8, var9)
        end

        return Dash.joinDeep(overlayEdit, { position = uDim2_2 })
    end, {
        overlayEdit,
        tbl1.clampToBoundsEnabled,
        var7,
        var4,
        var8,
        var9
    })

    local onDragEnd = useCallback(function()
        if not (containerRef.current and tbl1.onOverlayDragEnd) then
            return
        end

        local var11 = var10(containerRef.current.Position)
        if not var11 then
            return
        end

        tbl1.onOverlayDragEnd({ var11 })
    end, { tbl1.onOverlayDragEnd, var10 })

    local var12 = useCallback(function(arg1)
        if tbl1.clampToBoundsEnabled ~= true then
            return
        end

        local absoluteSize = arg1.AbsoluteSize
        var5(function(arg2)
            return if arg2 == absoluteSize then arg2 else absoluteSize
        end)
    end, { tbl1.clampToBoundsEnabled })

    React.useEffect(function()
        if tbl1.clampToBoundsEnabled ~= true
            or not tbl1.onOverlayDragEnd
            or not overlayEdit
            or var7.X <= 0
            or var7.Y <= 0
            or var4.X <= 0
            or var4.Y <= 0
        then
            return
        end

        local position = clampOverlayPosition(overlayEdit.position, var7, var4, var8, var9)

        if arePositionsEqual(position, overlayEdit.position) then
            return
        end

        tbl1.onOverlayDragEnd({ Dash.joinDeep(overlayEdit, { position = position }) })
    end, {
        tbl1.clampToBoundsEnabled,
        tbl1.onOverlayDragEnd,
        overlayEdit,
        var7,
        var4,
        var8,
        var9
    })

    local var13 = useCallback(function(overlayEdit2)
        if not overlayEdit2 then
            return nil
        end

        local bool1 = tbl1.clampToBoundsEnabled == true
        local visualScale = tbl1.visualScale

        local additionalScale = if visualScale == nil then var6 elseif typeof(visualScale) == "number" then var6 * visualScale else visualScale:map(function(num1: number)
            return var6 * num1
        end)

        return React.createElement(tbl1.overlayComponent, {
            additionalScale = additionalScale,
            boundingUI = if tbl1.unboundedDragEnabled == true then nil elseif bool1 then var1.current else ref.current,
            containerRef = containerRef,
            draggable = tbl1.draggable,
            editable = tbl1.editable,
            onActivated = tbl1.onOverlayActivated,
            onAbsoluteSizeChanged = if bool1 then var12 else nil,
            onDragBegin = tbl1.onOverlayDragBegin,
            onDragContinue = tbl1.onOverlayDragContinue,
            onDragEnd = onDragEnd,
            onRotationChanged = tbl1.onOverlayRotationChanged,
            onScaleChanged = tbl1.onOverlayScaleChanged,
            overlayEdit = overlayEdit2,
            referenceUI = if bool1 or tbl1.unboundedDragEnabled == true then ref.current else nil,
            selected = tbl1.selected
        })
    end, {
        tbl1.clampToBoundsEnabled,
        tbl1.draggable,
        tbl1.editable,
        tbl1.onOverlayActivated,
        tbl1.onOverlayDragBegin,
        tbl1.onOverlayDragContinue,
        tbl1.onOverlayRotationChanged,
        tbl1.onOverlayScaleChanged,
        tbl1.overlayComponent,
        tbl1.unboundedDragEnabled,
        tbl1.selected,
        tbl1.visualScale,
        var6,
        var12,
        onDragEnd
    })

    if not tbl1.overlayEdits or #tbl1.overlayEdits == 0 then
        return nil
    end

    return React.createElement(
        View,
        {
            ref = ref,
            Size = uDim2,
            tag = "position-center-center anchor-center-center",
            ZIndex = tbl1.zIndex or 1
        },
        {
            VisibleBounds = if tbl1.clampToBoundsEnabled == true then React.createElement("Frame", {
                AnchorPoint = Vector2.zero,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(var8.X, var8.Y),
                ref = var1,
                Size = UDim2.fromOffset(var9.X, var9.Y)
            }) else nil,
            Overlay = var13(overlayEdit)
        }
    )
end
return OverlayDisplay
