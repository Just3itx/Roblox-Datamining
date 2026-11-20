-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local React = require(GraphingParent.React)
local Signals = require(GraphingParent.Signals)

local CanvasContext = require(Graphing.CanvasContext)
local StyleUtil = require(Graphing.Util.StyleUtil)
local _Types = require(Graphing.Types)
local useViewportVisibility = require(Graphing.Util.useViewportBinding).useViewportVisibility

local maxControlPoints = nil
local function getMaxPointsPerPath() -- Luacid: Inlined by compiler; 1 call site recovered
    if not maxControlPoints then
        local path2D = Instance.new("Path2D")
        maxControlPoints = path2D:GetMaxControlPoints()
        path2D:Destroy()
    end
    assert(maxControlPoints, "MAX_POINTS_PER_PATH was nil")
    return maxControlPoints
end

local function curvePointsToControlPoints(arg1, tbl1)
    local result = {}
    for _, value in tbl1 do
        local var1 = arg1.plotToView(value.Position)
        local var2 = if value.LeftTangent then value.LeftTangent else Vector2.new(0, 0)
        local var3 = if value.RightTangent then value.RightTangent else Vector2.new(0, 0)
        local var4 = arg1.plotToView(value.Position + var2) - var1
        local var5 = arg1.plotToView(value.Position + var3) - var1

        table.insert(
            result,
            Path2DControlPoint.new(
                UDim2.fromScale(var1.X, var1.Y),
                UDim2.fromScale(var4.X, var4.Y),
                UDim2.fromScale(var5.X, var5.Y)
            )
        )
    end
    return result
end

local function applyControlPoints(arg1, tbl1, maxPointsPerPath: number)
    local num1 = 1
    for _, child in arg1:GetChildren() do
        local tbl2 = {}
        local num2 = #tbl1

        for i = num1, num1 + maxPointsPerPath - 1 do
            if num2 < i then
                break
            end

            table.insert(tbl2, tbl1[i])
        end

        child:SetControlPoints(tbl2)
        num1 += maxPointsPerPath - 1
    end
end

function Curve(tbl1)
    local var1 = React.useContext(CanvasContext)
    local maxPointsPerPath = getMaxPointsPerPath()
    local var2 = React.useRef(nil)
    if var2.current == nil then
        local get, set = Signals.createSignal(nil)
        var2.current = { get = get, set = set }
    end
    local current = var2.current

    local var3 = tbl1.PointCount or tbl1.Points and #tbl1.Points or 0

    React.useLayoutEffect(function()
        local computed

        if tbl1.ObservePoints then
            local observePoints = tbl1.ObservePoints
            computed = Signals.createComputed(function(arg1)
                var1.viewportRectGetter(arg1)
                return (curvePointsToControlPoints(var1, observePoints(arg1)))
            end)
        else
            local var4 = tbl1.Points or {}
            computed = Signals.createComputed(function(arg1)
                var1.viewportRectGetter(arg1)
                return (curvePointsToControlPoints(var1, var4))
            end)
        end

        return Signals.createEffect(function(arg1)
            local var4 = computed(arg1)
            local thickness = if tbl1.ObserveThickness then tbl1.ObserveThickness(arg1) else nil
            local var6 = current.get(arg1)
            if not var6 then
                return
            end

            applyControlPoints(var6, var4, maxPointsPerPath)
            if not thickness then
                return
            end

            for _, child in var6:GetChildren() do
                child.Thickness = thickness
            end
        end)
    end, {
        var1,
        tbl1.ObservePoints,
        tbl1.Points,
        tbl1.ObserveThickness
    })
    if not useViewportVisibility(function(arg1)
        local points = tbl1.Points
        if not points or #points == 0 then
            return true
        end

        local huge = math.huge
        local huge2 = math.huge
        local huge3 = -math.huge
        local huge4 = -math.huge
        for _, point in points do
            local tbl2 = { point.Position }
            if point.LeftTangent then
                table.insert(tbl2, point.Position + point.LeftTangent)
            end
            if point.RightTangent then
                table.insert(tbl2, point.Position + point.RightTangent)
            end
            for _, value in tbl2 do
                if value.X < huge then
                    huge = value.X
                end
                if value.Y < huge2 then
                    huge2 = value.Y
                end
                if huge3 < value.X then
                    huge3 = value.X
                end
                if huge4 < value.Y then
                    huge4 = value.Y
                end
            end
        end

        return arg1.isRectInViewport(Rect.new(huge, huge2, huge3, huge4))
    end, { tbl1.Points }) then
        return nil
    end

    local tag = tbl1.Tag or ""
    local clipContents = not (tbl1.ClipContents == nil) and tbl1.ClipContents
    local tbl2 = ({})
    local num1 = 1
    for _ = 2, var3, maxPointsPerPath - 1 do
        local str1 = tostring(num1)
        tbl2[str1] = React.createElement("Path2D", {
            Color3 = tbl1.Color3 or StyleUtil.CURVE_COLOR3,
            Thickness = tbl1.Thickness or StyleUtil.CURVE_THICKNESS,
            ZIndex = tbl1.ZIndex,
            [React.Tag] = tag
        })
        num1 += 1
    end

    return React.createElement(if clipContents then "CanvasGroup" else "Frame", {
        ref = current.set,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ZIndex = tbl1.ZIndex
    }, tbl2)
end

return Curve
