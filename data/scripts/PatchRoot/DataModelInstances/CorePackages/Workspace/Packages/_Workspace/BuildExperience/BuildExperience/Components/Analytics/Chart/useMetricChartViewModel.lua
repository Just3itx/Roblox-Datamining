-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local AnalyticsMetricChart = require(BuildExperienceParent.AnalyticsMetricChart)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)

local useMetricChartContent = require(script.Parent.useMetricChartContent)

local deriveChartAxes = AnalyticsMetricChart.deriveChartAxes

local function useMetricChartViewModel(arg1)
    local var1 = useMetricChartContent(arg1)
    local var2 = Foundation.Hooks.useTokens()
    local var3 = Foundation.Hooks.useTextSizeOffset()

    local bodySmall = var2.Typography.BodySmall
    local font = bodySmall.Font

    local labelFontSize = bodySmall.FontSize + (var3 or 0)

    local inspectedIndex, var6 = React.useState(nil)
    local var7, var8 = React.useState(false)
    local var9 = if var1.series == nil then nil else var1.series[1]
    local points = if var9 == nil then nil else var9.points

    local var10 = React.useMemo(function()
        return deriveChartAxes(points)
    end, { points })
    local pointsLen = #var10.points

    local var11 = React.useCallback(function(vector2: Vector2)
        if pointsLen == 0 then
            return
        end
        var6(math.clamp(math.round(vector2.X) + 1, 1, pointsLen))
    end, { pointsLen })

    local onHoverEnded = React.useCallback(function()
        if not var7 then
            var6(nil)
        end
    end, { var7 })

    local onDragStart = React.useCallback(function(vector2: Vector2)
        var8(true)
        var11(vector2)
    end, { var11 })

    local onDragEnded = React.useCallback(function()
        var8(false)
        var6(nil)
    end, {})

    local tbl1 = { var1.plotId }
    if points ~= nil then
        for _, point in points do
            table.insert(tbl1, `{point.time}:{point.value}`)
        end
    end
    local plotKey = table.concat(tbl1, "|")

    local yTicks = ({})
    for k, yTick in var10.yTicks do
        local tbl3 = {
            position = yTick,
            label = var1.yAxisFormatter({ value = yTick })
        }
        yTicks[k] = tbl3
    end

    local xAxisLabels = ({})
    if points ~= nil then
        for k, point in points do
            local xAxisFormatter = var1.xAxisFormatter
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
            date = var1.tooltipFormatters.formatXForPoint(point.time),
            valueText = 0
        }
        local formatSeriesValueForPoint = var1.tooltipFormatters.formatSeriesValueForPoint
        local tbl5 = {
            y = point.value,
            seriesId = if var9 == nil then nil else var9.id
        }
        tbl4.valueText = formatSeriesValueForPoint(tbl5)
    end

    local success = var2.Color.System.Success

    return {
        layoutOrder = var1.layoutOrder,
        plotKey = plotKey,
        title = var1.title,
        summary = var1.summary,
        valueText = var1.valueText,
        icon = var1.icon,
        deltaText = var1.deltaText,
        isDeltaPositive = var1.isDeltaPositive,
        hasData = var1.hasData,
        points = var10.points,
        minX = var10.minX,
        maxX = var10.maxX,
        minY = var10.minY,
        maxY = var10.maxY,
        yTicks = yTicks,
        xAxisLabels = xAxisLabels,
        labelFont = font,
        labelFontSize = labelFontSize,
        inspectedIndex = inspectedIndex,
        tooltip = tbl4,
        onHoverStart = var11,
        onHoverMoved = var11,
        onHoverEnded = onHoverEnded,
        onPress = var11,
        onDragStart = onDragStart,
        onDragMoved = var11,
        onDragEnded = onDragEnded,
        colors = {
            line = var2.Color.System.Emphasis,
            grid = var2.Color.Stroke.Default,
            axisLabel = var2.Color.Content.Default,
            muted = var2.Color.Content.Muted,
            emphasis = var2.Color.Content.Emphasis,
            surface = var2.Color.Surface.Surface_100,
            positive = success,
            positiveBackground = {
                Color3 = success.Color3,
                Transparency = var2.Color.Shift.Shift_300.Transparency
            },
            tooltipBackground = var2.Color.System.Contrast,
            tooltipContent = var2.Inverse.Content.Emphasis
        },
        testId = var1.testId
    }
end

return useMetricChartViewModel
