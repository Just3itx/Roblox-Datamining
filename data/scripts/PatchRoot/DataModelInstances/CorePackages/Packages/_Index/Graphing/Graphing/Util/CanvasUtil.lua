-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local Signals = require(GraphingParent.Signals)
local MathUtil = require(Graphing.Util.MathUtil)
local Types = require(Graphing.Types)

local module = {}

local viewportRectGetter = Signals.createSignal(Rect.new(0, 0, 1, 1))

local tbl1 = { current = nil }

module.DEFAULT_XSCALING = {
    Type = Types.SCALING_LINEAR,
    Direction = Types.DIRECTION_FORWARD
}

module.DEFAULT_YSCALING = {
    Type = Types.SCALING_LINEAR,
    Direction = Types.DIRECTION_REVERSED
}

function module.createFunctions(rect: Rect, rect2: Rect, arg1, arg2, arg3, num1: number?)
    local getXAxisScaling = arg2 or module.DEFAULT_XSCALING
    local getYAxisScaling = arg3 or module.DEFAULT_YSCALING
    assert(getXAxisScaling, "xAxisScaling was nil")
    assert(getYAxisScaling, "yAxisScaling was nil")

    local num2 = num1 or 0.0001
    assert(num2, "defaultEpsilon was nil")

    local function scaled(num3: number, ray)
        if ray.Type == Types.SCALING_LINEAR then
            return num3
        end

        if ray.Type == Types.SCALING_POWER then
            local power = ray.Power
            return MathUtil.signedPow(num3, power)
        end

        if ray.Type == Types.SCALING_LOGARITHMIC then
            local base = ray.Base
            return MathUtil.log(base, num3)
        end

        assert(false, `Scaling type {ray} not supported`)
        return num3
    end

    local function unscaled(num3: number, ray) -- Luacid: Inlined by compiler; 2 call sites recovered
        if ray.Type == Types.SCALING_LINEAR then
            return num3
        end

        if ray.Type == Types.SCALING_POWER then
            local power = ray.Power
            return MathUtil.signedPow(num3, 1 / power)
        end

        if ray.Type == Types.SCALING_LOGARITHMIC then
            return math.pow(ray.Base, num3)
        end

        assert(false, `Scaling type {ray} not supported`)
        return num3
    end

    local rect3 = Rect.new(
        scaled(rect.Min.X, getXAxisScaling),
        scaled(rect.Min.Y, getYAxisScaling),
        scaled(rect.Max.X, getXAxisScaling),
        scaled(rect.Max.Y, getYAxisScaling)
    )
    local rect4 = Rect.new(
        scaled(rect2.Min.X, getXAxisScaling),
        scaled(rect2.Min.Y, getYAxisScaling),
        scaled(rect2.Max.X, getXAxisScaling),
        scaled(rect2.Max.Y, getYAxisScaling)
    )

    local function plotToGraphX(num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3 = MathUtil.inverseLerp(rect3.Min.X, rect3.Max.X, scaled(num3, getXAxisScaling))
        if getXAxisScaling.Direction == Types.DIRECTION_REVERSED then
            var3 = 1 - var3
        end

        return var3
    end

    local function plotToGraphY(num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3 = MathUtil.inverseLerp(rect3.Min.Y, rect3.Max.Y, scaled(num3, getYAxisScaling))
        if getYAxisScaling.Direction ~= Types.DIRECTION_FORWARD then
            var3 = 1 - var3
        end

        return var3
    end

    local function graphToPlotY(num3: number)
        if getYAxisScaling.Direction ~= Types.DIRECTION_FORWARD then
            num3 = 1 - num3
        end
        return unscaled(MathUtil.lerp(rect3.Min.Y, rect3.Max.Y, num3), getYAxisScaling)
    end

    local function plotToViewX(num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3 = MathUtil.inverseLerp(rect4.Min.X, rect4.Max.X, scaled(num3, getXAxisScaling))
        if getXAxisScaling.Direction == Types.DIRECTION_REVERSED then
            var3 = 1 - var3
        end

        return var3
    end

    local function plotToViewY(num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3 = MathUtil.inverseLerp(rect4.Min.Y, rect4.Max.Y, scaled(num3, getYAxisScaling))
        if getYAxisScaling.Direction ~= Types.DIRECTION_FORWARD then
            var3 = 1 - var3
        end

        return var3
    end

    local function plotToView(vector2: Vector2): Vector2
        return Vector2.new(plotToViewX(vector2.X), (plotToViewY(vector2.Y)))
    end

    local function viewToPlotY(num3: number)
        if getYAxisScaling.Direction ~= Types.DIRECTION_FORWARD then
            num3 = 1 - num3
        end
        return unscaled(MathUtil.lerp(rect4.Min.Y, rect4.Max.Y, num3), getYAxisScaling)
    end

    local function viewToPlot(vector2: Vector2)
        local new = Vector2.new
        local vector2X = vector2.X

        if getXAxisScaling.Direction == Types.DIRECTION_REVERSED then
            vector2X = 1 - vector2X
        end
        return new(unscaled(MathUtil.lerp(rect4.Min.X, rect4.Max.X, vector2X), getXAxisScaling), viewToPlotY(vector2.Y))
    end

    local function absToView(vector2: Vector2)
        local current = arg1.current
        if not current then
            return rect2.Min
        end

        local absolutePosition = current.AbsolutePosition
        local absoluteSize = current.AbsoluteSize
        local x = MathUtil.inverseLerp(absolutePosition.X, absolutePosition.X + absoluteSize.X, vector2.X)
        local y = MathUtil.inverseLerp(absolutePosition.Y, absolutePosition.Y + absoluteSize.Y, vector2.Y)

        return Vector2.new(x, y)
    end

    local function viewToAbs(vector2: Vector2)
        local current = arg1.current
        if not current then
            return rect2.Min
        end

        local absolutePosition = current.AbsolutePosition
        local absoluteSize = current.AbsoluteSize
        local x = MathUtil.lerp(absolutePosition.X, absolutePosition.X + absoluteSize.X, vector2.X)
        local y = MathUtil.lerp(absolutePosition.X, absolutePosition.X + absoluteSize.X, vector2.Y)

        return Vector2.new(x, y)
    end

    local function mouseToView(vec1: vector)
        return absToView(Vector2.new(vec1.X, vec1.Y))
    end

    local function isPointInViewportX(num3: number, num4: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local num5 = num4 or num2
        return rect2.Min.X - num5 <= num3 and num3 <= rect2.Max.X + num5
    end

    local function isPointInViewportY(num3: number, num4: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
        local num5 = num4 or num2
        return rect2.Min.Y - num5 <= num3 and num3 <= rect2.Max.Y + num5
    end

    return {
        getViewport = function()
            return arg1.current
        end,
        getGraphRect = function()
            return rect
        end,
        getViewportRect = function()
            return rect2
        end,
        getXAxisScaling = function()
            return getXAxisScaling
        end,
        getYAxisScaling = function()
            return getYAxisScaling
        end,
        plotToGraph = function(vector2: Vector2): Vector2
            return Vector2.new(plotToGraphX(vector2.X), (plotToGraphY(vector2.Y)))
        end,
        plotToGraphX = plotToGraphX,
        plotToGraphY = plotToGraphY,
        graphToPlot = function(vector2: Vector2)
            local new = Vector2.new
            local vector2X = vector2.X

            if getXAxisScaling.Direction == Types.DIRECTION_REVERSED then
                vector2X = 1 - vector2X
            end
            return new(unscaled(MathUtil.lerp(rect3.Min.X, rect3.Max.X, vector2X), getXAxisScaling), graphToPlotY(vector2.Y))
        end,
        graphToPlotX = function(num3: number)
            if getXAxisScaling.Direction == Types.DIRECTION_REVERSED then
                num3 = 1 - num3
            end
            return unscaled(MathUtil.lerp(rect3.Min.X, rect3.Max.X, num3), getXAxisScaling)
        end,
        graphToPlotY = graphToPlotY,
        plotToView = plotToView,
        plotToViewX = plotToViewX,
        plotToViewY = plotToViewY,
        viewToPlot = viewToPlot,
        viewToPlotX = function(num3: number)
            if getXAxisScaling.Direction == Types.DIRECTION_REVERSED then
                num3 = 1 - num3
            end
            return unscaled(MathUtil.lerp(rect4.Min.X, rect4.Max.X, num3), getXAxisScaling)
        end,
        viewToPlotY = viewToPlotY,
        absToView = absToView,
        viewToAbs = viewToAbs,
        absToPlot = function(vector2: Vector2)
            return viewToPlot(absToView(vector2))
        end,
        plotToAbs = function(vector2: Vector2)
            return viewToAbs(plotToView(vector2))
        end,
        mouseToView = mouseToView,
        mouseToPlot = function(vec1: vector)
            return viewToPlot(mouseToView(vec1))
        end,
        isPointInViewport = function(vector2: Vector2, num3: number?): boolean
            return isPointInViewportX(vector2.X, num3) and isPointInViewportY(vector2.Y, num3)
        end,
        isPointInViewportX = isPointInViewportX,
        isPointInViewportY = isPointInViewportY,
        isRectInViewport = function(rect5: Rect, num3: number?): boolean
            local num4 = num3 or num2

            if rect5.Min.X <= rect2.Max.X + num4 and rect5.Max.X >= rect2.Min.X - num4 and rect5.Min.Y <= rect2.Max.Y + num4 then
                return rect5.Max.Y >= rect2.Min.Y - num4
            end

            return false
        end,
        viewportRectGetter = viewportRectGetter
    }
end

function module.createStableContext(arg1, rect: Rect?, rect2: Rect?, arg2, arg3, num1: number?)
    local var1 = rect or Rect.new(0, 0, 1, 1)
    local var2 = rect2 or var1
    local var3, var4 = Signals.createSignal(var2)

    local functions = module.createFunctions(var1, var2, arg1, arg2, arg3, num1)

    functions.viewportRectGetter = var3

    local function update(rect3: Rect, rect4: Rect, arg4, arg5, num2: number?)
        for value, value2 in (module.createFunctions(rect3, rect4, arg1, arg4, arg5, num2)) do
            if value ~= "viewportRectGetter" then
                functions[value] = value2
            end
        end
        var4(rect4)
    end

    return functions, update
end

function module.createDefaultFunctions()
    return module.createFunctions(Rect.new(0, 0, 1, 1), Rect.new(0, 0, 1, 1), tbl1)
end

return module
