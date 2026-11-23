-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local CapturesCommon = require(scriptParentParentParent.CapturesCommon)
local React = require(scriptParentParentParent.React)
local ReactOtter = require(scriptParentParentParent.ReactOtter)

local useAnimatedBinding = ReactOtter.useAnimatedBinding
local useCallback = React.useCallback
local useDeviceInsets = require(scriptParentParentParent.Responsive).useDeviceInsets
local useEffect = React.useEffect
local useGuiInset = CapturesCommon.Hooks.useGuiInset
local useRef = React.useRef
local useState = React.useState

local CaptureControlsConfiguration = require(scriptParentParent.Utils.CaptureControlsConfiguration)

local SnapDirection = require(scriptParentParent.Enums.SnapDirection)
local engineFeature = game:GetEngineFeature("UIDragDetectorFixEventPositionEnabled")

local tbl1 = { x = 0.5, y = 0.5 }
local tbl2 = { xOffset = -100, yOffset = -100 }
local vector2 = Vector2.new(1, 0.5)
local Right = SnapDirection.Right

local tbl3 = {
    duration = 0.4,
    easingStyle = {
        0.19,
        1,
        0.22,
        1
    }
}
local function validateRefs(tbl4)
    for _, value in tbl4 do
        if value.current == nil then
            return false
        end

        if value.current.AbsoluteSize.X <= 0 or value.current.AbsoluteSize.Y <= 0 then
            return false
        end
    end

    return true
end

local function clampItemPosition(vector2_2: Vector2, vector2_3: Vector2, vector2_4: Vector2, vector2_5: Vector2, vector2_6: Vector2): Vector2
    local var1 = vector2_2 - vector2_4
    local num1 = 50
    local vector26Y = vector2_6.Y
    local x = if vector2_5.X - 50 > vector2_3.X then math.clamp(var1.X, num1, vector2_5.X - vector2_3.X - 50) else 50

    if vector2_5.Y - vector26Y > vector2_3.Y then
        vector26Y = math.clamp(var1.Y, vector26Y, vector2_5.Y - vector2_3.Y)
    end

    return Vector2.new(x, vector26Y)
end

local function getSnapPosition(vector2_2: Vector2, vector2_3: Vector2, vector2_4: Vector2, vector2_5: Vector2, vector2_6: Vector2, vector2_7: Vector2): Vector2
    local var1 = Vector2.new(vector2_5.X * vector2_6.X, vector2_5.Y * vector2_6.Y) - Vector2.new(vector2_2.X * vector2_3.X, vector2_2.Y * vector2_3.Y) + vector2_4

    return (clampItemPosition(var1, vector2_2, vector2_4, vector2_5, vector2_7))
end

local function getSnapAnchorPoint(vector2_2: Vector2, vector2_3: Vector2, vector2_4: Vector2, vector2_5: Vector2)
    local var1 = vector2_2 - vector2_3

    local tbl4 = {
        Vector2.new(0, math.max(var1.Y, vector2_5.Y)),
        Vector2.new(vector2_4.X, var1.Y),
        Vector2.new(math.max(var1.X, vector2_5.X), 0),
        Vector2.new(var1.X, vector2_4.Y)
    }

    table.sort(tbl4, function(arg1, arg2): boolean
        return (arg1 - var1).Magnitude < (arg2 - var1).Magnitude
    end)

    local var2 = tbl4[1]
    local magnitude = (var2 - var1).Magnitude
    return var2 / vector2_4, magnitude
end

local function getSnapDirectionFromAnchorPoint(vector2_2: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if vector2_2.X == 0 then
        return SnapDirection.Left
    elseif vector2_2.X == 1 then
        return SnapDirection.Right
    end

    if vector2_2.Y == 0 then
        return SnapDirection.Top
    end

    return SnapDirection.Bottom
end

local function getShouldRotate(bool1: boolean, vector2_2: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local bool2 = vector2_2.X == 0 or vector2_2.X == 1
    local bool3 = vector2_2.Y == 0 or vector2_2.Y == 1
    local bool4 = false

    if bool2 and bool3 then
        return false
    end

    if bool3 and not bool1 then
        return true
    end

    if bool2 and bool1 then
        bool4 = true
    end

    return bool4
end

local function useCaptureControlsController(bool1: boolean, vector2_2: Vector2)
    local var1 = useRef(vector2_2)
    local dragContainerRef = useRef(nil)
    local dragDetectorRef = useRef(nil)
    local dragItemRef = useRef(nil)
    local var5 = useRef(false)
    local screenshotButtonRef = useRef(nil)
    local var7 = useRef(CaptureControlsConfiguration.getStoredSnapAnchorPoint())

    local var8, var9 = useState(vector2)
    local var10, var11 = useState(false)
    local isItemHorizontal, var13 = useState(false)
    local snapDirection, var15 = useState(Right)

    local var16 = useGuiInset()
    local var17 = useDeviceInsets()

    local var18 = useCallback(function()
        var5.current = false
    end, {})

    local dragItemAnchorPointBinding, var20 = useAnimatedBinding(tbl1)

    local dragItemPositionBinding, var22 = useAnimatedBinding(tbl2, var18)

    useEffect(function()
        if not (bool1 and validateRefs({ dragItemRef, dragContainerRef })) then
            return
        end

        assert(dragItemRef.current ~= nil, "dragItemRef is nil")
        assert(dragContainerRef.current ~= nil, "dragContainerRef is nil")

        var1.current = vector2_2

        local current = var7.current

        var9(current)
        var15((getSnapDirectionFromAnchorPoint(current)))

        local absoluteSize = dragItemRef.current.AbsoluteSize
        local anchorPoint = dragItemRef.current.AnchorPoint

        if getShouldRotate(isItemHorizontal, current) then
            absoluteSize = Vector2.new(absoluteSize.Y, absoluteSize.X)
            anchorPoint = Vector2.new(anchorPoint.Y, anchorPoint.X)
            var20({ x = ReactOtter.ease(anchorPoint.X, tbl3), y = ReactOtter.ease(anchorPoint.Y, tbl3) })

            var13(not isItemHorizontal)
        end

        local vector2_3 = getSnapPosition(
            absoluteSize,
            anchorPoint,
            dragContainerRef.current.AbsolutePosition,
            dragContainerRef.current.AbsoluteSize,
            current,
            vector2_2
        )

        local vector2_4 = Vector2.new(absoluteSize.X * anchorPoint.X, absoluteSize.Y * anchorPoint.Y)

        var22(
            {
                xOffset = ReactOtter.instant(vector2_3.X + vector2_4.X),
                yOffset = ReactOtter.instant(vector2_3.Y + vector2_4.Y)
            }
        )
    end, {
        bool1,
        vector2_2,
        var20,
        var22
    })

    local var23 = useCallback(function()
        if not bool1 or var5.current or not validateRefs({ dragItemRef, dragContainerRef }) then
            return
        end

        assert(dragItemRef.current ~= nil, "dragItemRef is nil")
        assert(dragContainerRef.current ~= nil, "dragContainerRef is nil")

        local absoluteSize = dragItemRef.current.AbsoluteSize
        local anchorPoint = dragItemRef.current.AnchorPoint

        local vector2_3 = getSnapPosition(
            absoluteSize,
            anchorPoint,
            dragContainerRef.current.AbsolutePosition,
            dragContainerRef.current.AbsoluteSize,
            var8,
            vector2_2
        )

        local vector2_4 = Vector2.new(absoluteSize.X * anchorPoint.X, absoluteSize.Y * anchorPoint.Y)

        var22(
            {
                xOffset = ReactOtter.instant(vector2_3.X + vector2_4.X),
                yOffset = ReactOtter.instant(vector2_3.Y + vector2_4.Y)
            }
        )
    end, {
        bool1,
        vector2_2,
        var8,
        var10,
        var22
    })

    local var24 = useCallback
    local function func1(vector2_3: Vector2)
        if not bool1 or var10 or not validateRefs({ dragContainerRef, dragItemRef }) then
            return
        end

        assert(dragItemRef.current ~= nil, "dragItemRef is nil")
        assert(dragContainerRef.current ~= nil, "dragContainerRef is nil")

        local var25 = vector2_3 - Vector2.new(var16.left + var17.left, var16.top + var17.top)
        var11(true)

        local absoluteSize = dragItemRef.current.AbsoluteSize
        local absolutePosition = dragItemRef.current.AbsolutePosition
        local _anchorPoint = dragItemRef.current.AnchorPoint

        local vector2_4 = clampItemPosition(
            absolutePosition,
            absoluteSize,
            dragContainerRef.current.AbsolutePosition,
            dragContainerRef.current.AbsoluteSize,
            vector2_2
        )

        local new = Vector2.new
        local var26 = if isItemHorizontal then ((if engineFeature then vector2_3 else var25).X - absolutePosition.X) / absoluteSize.X else 0.5
        local var27

        if isItemHorizontal then
            var27 = 0.5
        else
            if engineFeature then
                var25 = vector2_3
            end

            var27 = (var25.Y - absolutePosition.Y) / absoluteSize.Y
        end

        local var28 = new(var26, var27)

        var20({ x = ReactOtter.instant(var28.X), y = ReactOtter.instant(var28.Y) })

        local vector2_5 = Vector2.new(absoluteSize.X * var28.X, absoluteSize.Y * var28.Y)

        var22(
            {
                xOffset = ReactOtter.instant(vector2_4.X + vector2_5.X),
                yOffset = ReactOtter.instant(vector2_4.Y + vector2_5.Y)
            }
        )
    end

    local func2 = clampItemPosition
    local var25 = if engineFeature then nil else var17
    local var26 = if engineFeature then nil else var16
    local var27 = var24(func1, { bool1, vector2_2, func2, var25, var26, var10, isItemHorizontal, var22, var20 })

    local var28 = useCallback
    local function func3(vector2_3: Vector2, bool2: boolean)
        if not validateRefs({ dragItemRef, dragContainerRef }) then
            return
        end

        assert(dragItemRef.current ~= nil, "dragItemRef is nil")
        assert(dragContainerRef.current ~= nil, "dragContainerRef is nil")

        local var29 = vector2_3 - Vector2.new(var16.left + var17.left, var16.top + var17.top)

        local absolutePosition = dragContainerRef.current.AbsolutePosition
        local absoluteSize = dragContainerRef.current.AbsoluteSize

        local current, var31 = getSnapAnchorPoint(if engineFeature then vector2_3 else var29, absolutePosition, absoluteSize, vector2_2)

        local bool3 = var31 < 70 or not bool2

        local absoluteSize2 = dragItemRef.current.AbsoluteSize
        local anchorPoint = dragItemRef.current.AnchorPoint

        local shouldRotate = getShouldRotate(isItemHorizontal, current)

        if bool3 and shouldRotate then
            absoluteSize2 = Vector2.new(absoluteSize2.Y, absoluteSize2.X)
            anchorPoint = Vector2.new(anchorPoint.Y, anchorPoint.X)
            var20({ x = ReactOtter.instant(anchorPoint.X), y = ReactOtter.instant(anchorPoint.Y) })

            var13(not isItemHorizontal)
        end

        local vector2_4 = Vector2.new(absoluteSize2.X * anchorPoint.X, absoluteSize2.Y * anchorPoint.Y)
        local snapPosition

        if bool3 then
            snapPosition = getSnapPosition(absoluteSize2, anchorPoint, absolutePosition, absoluteSize, current, vector2_2)
        else
            local func4 = clampItemPosition
            if engineFeature then
                var29 = vector2_3
            end

            snapPosition = func4(var29 - vector2_4, absoluteSize2, absolutePosition, absoluteSize, vector2_2)
        end

        if bool2 then
            var22({
                xOffset = ReactOtter.instant(snapPosition.X + vector2_4.X),
                yOffset = ReactOtter.instant(snapPosition.Y + vector2_4.Y)
            })
            return
        end

        var5.current = true
        var22({
            xOffset = ReactOtter.ease(snapPosition.X + vector2_4.X, tbl3),
            yOffset = ReactOtter.ease(snapPosition.Y + vector2_4.Y, tbl3)
        })

        var9(current)
        var15((getSnapDirectionFromAnchorPoint(current)))

        CaptureControlsConfiguration.setStoredSnapAnchorPoint(current)
        var7.current = current
    end

    local var29 = if engineFeature then nil else var17
    local var30 = if engineFeature then nil else var16
    local var31 = var28(func3, { vector2_2, var29, var30, isItemHorizontal, var22, var20 })

    local var32 = useCallback(function(vector2_3: Vector2)
        if not (bool1 and var10) then
            return
        end

        var31(vector2_3, true)
    end, { bool1, var31, var10 })

    local var33 = useCallback(function(vector2_3: Vector2)
        if not (bool1 and var10) then
            return
        end

        var31(vector2_3, false)
        var11(false)
    end, { bool1, var31, var10 })

    useEffect(function()
        if not bool1 then
            return
        end

        if var1.current ~= vector2_2 then
            var1.current = vector2_2
            var23()
        end
    end, { bool1, vector2_2, var23 })

    useEffect(function()
        if not bool1 then
            return
        end

        local tbl4 = {}
        if dragDetectorRef.current ~= nil then
            local dragStart = dragDetectorRef.current.DragStart
            table.insert(tbl4, dragStart:Connect(var27))
            local dragContinue = dragDetectorRef.current.DragContinue
            table.insert(tbl4, dragContinue:Connect(var32))
            local dragEnd = dragDetectorRef.current.DragEnd
            table.insert(tbl4, dragEnd:Connect(var33))
        end

        if dragContainerRef.current ~= nil then
            local absoluteSizeChanged = dragContainerRef.current:GetPropertyChangedSignal("AbsoluteSize")
            table.insert(tbl4, absoluteSizeChanged:Connect(var23))
        end

        if dragItemRef.current ~= nil then
            local absoluteSizeChanged = dragItemRef.current:GetPropertyChangedSignal("AbsoluteSize")
            table.insert(tbl4, absoluteSizeChanged:Connect(var23))
        end

        return function()
            for _, value in tbl4 do
                value:Disconnect()
            end
        end
    end, {
        bool1,
        var27,
        var32,
        var33,
        var23
    })
    return {
        dragContainerRef = dragContainerRef,
        dragDetectorRef = dragDetectorRef,
        dragItemAnchorPointBinding = dragItemAnchorPointBinding,
        dragItemPositionBinding = dragItemPositionBinding,
        dragItemRef = dragItemRef,
        isItemHorizontal = isItemHorizontal,
        screenshotButtonRef = screenshotButtonRef,
        snapDirection = snapDirection
    }
end

return useCaptureControlsController
