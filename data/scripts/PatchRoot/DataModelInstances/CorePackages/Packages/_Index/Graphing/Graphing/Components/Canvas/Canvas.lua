-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Graphing = script:FindFirstAncestor("Graphing")
local GraphingParent = Graphing.Parent
local Dash = require(GraphingParent.Dash)
local React = require(GraphingParent.React)

local CanvasContext = require(Graphing.CanvasContext)
local CanvasUtil = require(Graphing.Util.CanvasUtil)
local StyleUtil = require(Graphing.Util.StyleUtil)
local _Types = require(Graphing.Types)

local rect = Rect.new(0, 0, 1, 1)

function Canvas(tbl1, arg1)
    local ref = React.useRef(nil)
    local var2 = if tbl1.Position then tbl1.Position else UDim2.fromOffset(0, 0)
    local var3 = if tbl1.Size then tbl1.Size else UDim2.fromScale(1, 1)
    local var4 = if tbl1.ViewportPaddingLeft then tbl1.ViewportPaddingLeft else UDim.new(0, 25)
    local var5 = if tbl1.ViewportPaddingRight then tbl1.ViewportPaddingRight else UDim.new(0, 25)
    local var6 = if tbl1.ViewportPaddingTop then tbl1.ViewportPaddingTop else UDim.new(0, 25)
    local var7 = if tbl1.ViewportPaddingBottom then tbl1.ViewportPaddingBottom else UDim.new(0, 25)
    local var8 = UDim2.new(var4, var6)
    local var9 = UDim2.new(var5, var7)

    local var10 = React.useRef(nil)
    if var10.current == nil then
        local var11 = tbl1.GraphRect or rect
        local var12 = if tbl1.ViewportRect then tbl1.ViewportRect else var11
        local context, update = CanvasUtil.createStableContext(ref, var11, var12, tbl1.XAxisScaling, tbl1.YAxisScaling, tbl1.CullingEpsilon)

        var10.current = { context = context, update = update }
    end
    local current = var10.current
    local context = current.context
    local update = current.update

    local var11 = React.useRef({
        graphRect = tbl1.GraphRect or rect,
        viewportRect = tbl1.ViewportRect or tbl1.GraphRect or rect,
        xAxisScaling = tbl1.XAxisScaling,
        yAxisScaling = tbl1.YAxisScaling,
        cullingEpsilon = tbl1.CullingEpsilon
    })

    React.useImperativeHandle(arg1, function()
        return {
            setViewportRect = function(rect2: Rect)
                local current2 = var11.current
                current2.viewportRect = rect2
                update(current2.graphRect, rect2, current2.xAxisScaling, current2.yAxisScaling, current2.cullingEpsilon)
            end,
            setGraphRect = function(rect2: Rect)
                local current2 = var11.current
                current2.graphRect = rect2
                update(rect2, current2.viewportRect, current2.xAxisScaling, current2.yAxisScaling, current2.cullingEpsilon)
            end,
            update = function(rect2: Rect, rect3: Rect, xAxisScaling, yAxisScaling, cullingEpsilon: number?)
                local current2 = var11.current
                current2.graphRect = rect2
                current2.viewportRect = rect3
                current2.xAxisScaling = xAxisScaling
                current2.yAxisScaling = yAxisScaling
                current2.cullingEpsilon = cullingEpsilon
                update(rect2, rect3, xAxisScaling, yAxisScaling, cullingEpsilon)
            end
        }
    end, {})

    React.useLayoutEffect(function()
        if not tbl1.GraphRect then
            return
        end

        local graphRect = tbl1.GraphRect
        local viewportRect = if tbl1.ViewportRect then tbl1.ViewportRect else graphRect
        var11.current.graphRect = graphRect
        var11.current.viewportRect = viewportRect
        var11.current.xAxisScaling = tbl1.XAxisScaling
        var11.current.yAxisScaling = tbl1.YAxisScaling
        var11.current.cullingEpsilon = tbl1.CullingEpsilon
        update(graphRect, viewportRect, tbl1.XAxisScaling, tbl1.YAxisScaling, tbl1.CullingEpsilon)
    end, {
        tbl1.GraphRect,
        tbl1.ViewportRect,
        tbl1.XAxisScaling,
        tbl1.YAxisScaling,
        tbl1.CullingEpsilon
    })

    return React.createElement(CanvasContext.Provider, { value = context }, {
        MainPanel = React.createElement(
            "Frame",
            {
                Position = var2,
                Size = var3,
                LayoutOrder = tbl1.LayoutOrder,
                ZIndex = tbl1.ZIndex,
                BackgroundColor3 = tbl1.CanvasBackgroundColor3 or StyleUtil.CANVAS_BACKGROUND_COLOR3,
                BackgroundTransparency = tbl1.CanvasBackgroundTransparency or StyleUtil.CANVAS_BACKGROUND_TRANSPARENCY,
                BorderSizePixel = 0
            },
            Dash.join({
                Viewport = React.createElement("CanvasGroup", {
                    Position = var8,
                    Size = UDim2.fromScale(1, 1) - (var8 + var9),
                    ref = ref,
                    BackgroundColor3 = tbl1.ViewportBackgroundColor3 or StyleUtil.VIEWPORT_BACKGROUND_COLOR3,
                    BackgroundTransparency = tbl1.ViewportBackgroundTransparency or StyleUtil.VIEWPORT_BACKGROUND_TRANSPARENCY,
                    BorderSizePixel = 0,
                    ZIndex = 1
                }, tbl1.children),
                ViewportUnclipped = React.createElement("Frame", {
                    Position = var8,
                    Size = UDim2.fromScale(1, 1) - (var8 + var9),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ZIndex = 2
                }, tbl1.childrenUnclipped)
            })
        )
    })
end

return React.forwardRef(Canvas)
