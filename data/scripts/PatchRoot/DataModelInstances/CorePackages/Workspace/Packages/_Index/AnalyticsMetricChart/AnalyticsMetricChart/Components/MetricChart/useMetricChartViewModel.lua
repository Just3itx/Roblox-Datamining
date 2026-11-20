-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsMetricChart = script:FindFirstAncestor("AnalyticsMetricChart")
local AnalyticsMetricChartParent = AnalyticsMetricChart.Parent

local Foundation = require(AnalyticsMetricChartParent.Foundation)
local React = require(AnalyticsMetricChartParent.React)

local _MetricChartTypes = require(script.Parent.MetricChartTypes)
local _MetricChartView = require(script.Parent.MetricChartView)
local deriveChartAxes = require(AnalyticsMetricChart.Utils.deriveChartAxes)

local function useMetricChartViewModel(arg1)
    local var1 = Foundation.Hooks.useTokens()
    local var2 = Foundation.Hooks.useTextSizeOffset()

    local bodySmall = var1.Typography.BodySmall
    local font = bodySmall.Font

    local labelFontSize = bodySmall.FontSize + (var2 or 0)

    local inspectedIndex, var5 = React.useState(nil)
    local var6, var7 = React.useState(false)
    local var8 = if arg1.series == nil then nil else arg1.series[1]
    local points = if var8 == nil then nil else var8.points

    local var9 = React.useMemo(function()
        return deriveChartAxes(points)
    end, { points })
    local pointsLen = #var9.points

    local var10 = React.useCallback(function(vector2: Vector2)
        if pointsLen == 0 then
            return
        end
        var5(math.clamp(math.round(vector2.X) + 1, 1, pointsLen))
    end, { pointsLen })

    local onHoverEnded = React.useCallback(function()
        if not var6 then
            var5(nil)
        end
    end, { var6 })

    local onDragStart = React.useCallback(function(vector2: Vector2)
        var7(true)
        var10(vector2)
    end, { var10 })

    local onDragEnded = React.useCallback(function()
        var7(false)
        var5(nil)
    end, {})

    local tbl1 = { arg1.plotId }
    if points ~= nil then
        for _, point in points do
            table.insert(tbl1, `{point.time}:{point.value}`)
        end
    end
    local plotKey = table.concat(tbl1, "|")

    local yTicks = ({})
    for k, yTick in var9.yTicks do
        local tbl3 = {
            position = yTick,
            label = arg1.yAxisFormatter({ value = yTick })
        }
        yTicks[k] = tbl3
    end

    local xAxisLabels = ({})
    if points ~= nil then
        for k, point in points do
            local xAxisFormatter = arg1.xAxisFormatter
            local tbl4 = {
                value = point.time
            }
            xAxisLabels[k] = xAxisFormatter(tbl4)
        end
    end

    local tbl4

    if inspectedIndex == nil or points == nil or not (inspectedIndex >= 1 and inspectedIndex <= #points) then
        tbl4 = nil
    else
        local point = points[inspectedIndex]
        tbl4 = {
            date = arg1.tooltipFormatters.formatXForPoint(point.time),
            valueText = 0
        }
        local formatSeriesValueForPoint = arg1.tooltipFormatters.formatSeriesValueForPoint
        local tbl5 = {
            y = point.value,
            seriesId = if var8 == nil then nil else var8.id
        }
        tbl4.valueText = formatSeriesValueForPoint(tbl5)
    end

    local success = var1.Color.System.Success

    return {
        layoutOrder = arg1.layoutOrder,
        plotKey = plotKey,
        title = arg1.title,
        summary = arg1.summary,
        valueText = arg1.valueText,
        icon = arg1.icon,
        deltaText = arg1.deltaText,
        isDeltaPositive = arg1.isDeltaPositive,
        hasData = arg1.hasData,
        hideHeader = arg1.hideHeader == true,
        points = var9.points,
        minX = var9.minX,
        maxX = var9.maxX,
        minY = var9.minY,
        maxY = var9.maxY,
        yTicks = yTicks,
        xAxisLabels = xAxisLabels,
        labelFont = font,
        labelFontSize = labelFontSize,
        inspectedIndex = inspectedIndex,
        tooltip = tbl4,
        onHoverStart = var10,
        onHoverMoved = var10,
        onHoverEnded = onHoverEnded,
        onPress = var10,
        onDragStart = onDragStart,
        onDragMoved = var10,
        onDragEnded = onDragEnded,
        colors = {
            line = var1.Color.System.Emphasis,
            grid = var1.Color.Stroke.Default,
            axisLabel = var1.Color.Content.Default,
            muted = var1.Color.Content.Muted,
            emphasis = var1.Color.Content.Emphasis,
            surface = var1.Color.Surface.Surface_100,
            positive = success,
            positiveBackground = {
                Color3 = success.Color3,
                Transparency = var1.Color.Shift.Shift_300.Transparency
            },
            tooltipBackground = var1.Color.System.Contrast,
            tooltipContent = var1.Inverse.Content.Emphasis
        },
        testId = arg1.testId
    }
end

return useMetricChartViewModel
