-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsMetricChartParent = script:FindFirstAncestor("AnalyticsMetricChart").Parent

local Foundation = require(AnalyticsMetricChartParent.Foundation)
local Graphing = require(AnalyticsMetricChartParent.Graphing)
local React = require(AnalyticsMetricChartParent.React)
local Style = require(AnalyticsMetricChartParent.Style)

local chartLayout = require(script.Parent.chartLayout)

local Canvas = Graphing.Canvas
local Curve = Graphing.Curve
local GridLine = Graphing.GridLine
local InputDetector = Graphing.InputDetector
local Point = Graphing.Point

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View

local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant

local PLOT_HEIGHT = chartLayout.PLOT_HEIGHT

local var1 = PLOT_HEIGHT - 28
local yOffset = var1 + -1

local function renderTooltip(position, tooltip, colors, testId: string, name, onAbsoluteSizeChanged: (...any) -> (...any))
    local createElement = React.createElement
    local var2 = View
    local tbl1 = {
        Size = UDim2.fromOffset(0, 30),
        Position = position,
        ZIndex = 30,
        backgroundStyle = colors.tooltipBackground,
        onAbsoluteSizeChanged = onAbsoluteSizeChanged,
        tag = "row align-y-center gap-large anchor-top-center auto-x padding-x-xsmall radius-small",
        testId = `{testId}.Tooltip`
    }
    local tbl2 = {
        Date = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = tooltip.date,
            tag = "auto-xy text-caption-medium content-inverse-default",
            testId = `{testId}.TooltipDate`
        }),
        ValueGroup = React.createElement(View, {
            LayoutOrder = 2,
            tag = "row align-y-center gap-xsmall auto-xy"
        }, {
            Icon = if name == nil then nil else React.createElement(Icon, {
                LayoutOrder = 1,
                name = name,
                size = IconSize.XSmall,
                style = colors.tooltipContent,
                testId = `{testId}.TooltipIcon`
            }),
            Value = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tooltip.valueText,
                tag = "auto-xy text-caption-medium content-inverse-emphasis",
                testId = `{testId}.TooltipValue`
            })
        })
    }
    return createElement(var2, tbl1, tbl2)
end

local function renderTitleBlock(tbl1, testId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.createElement(FoundationText, {
        LayoutOrder = 1,
        Text = tbl1.title,
        tag = "size-full-0 auto-y text-title-medium text-align-x-left text-truncate-end content-default",
        testId = `{testId}.Title`
    })
end

local function renderSummary(tbl1, testId: string) -- Luacid: Inlined by compiler; 1 call site recovered
    return React.createElement(FoundationText, {
        LayoutOrder = 2,
        Text = tbl1.summary,
        tag = "size-full-0 auto-y text-body-medium text-wrap text-align-x-left content-default",
        testId = `{testId}.Summary`
    })
end

local function renderValueRow(tbl1, testId: string)
    local colors = tbl1.colors
    local createElement = React.createElement
    local var2 = View
    local tbl2 = { LayoutOrder = 1, tag = "row align-y-center gap-small size-full-0 auto-y" }

    local tbl3 = {
        Stat = React.createElement(View, {
            LayoutOrder = 1,
            tag = "row align-y-center gap-xsmall auto-xy"
        }, {
            Icon = if tbl1.icon == nil then nil else React.createElement(Icon, {
                LayoutOrder = 1,
                name = tbl1.icon,
                size = IconSize.Medium,
                style = colors.emphasis,
                testId = `{testId}.Icon`
            }),
            Value = React.createElement(FoundationText, {
                LayoutOrder = 2,
                Text = tbl1.valueText,
                tag = "auto-xy text-heading-large content-emphasis",
                testId = `{testId}.Value`
            })
        }),
        Delta = 0
    }
    local var3

    if tbl1.deltaText == nil then
        var3 = nil
    else
        local createElement2 = React.createElement
        local var4 = View
        local tbl4 = {
            LayoutOrder = 2,
            tag = {
                ["row align-y-center gap-xxsmall auto-xy padding-y-xxsmall padding-left-xsmall padding-right-small radius-small"] = true,
                ["bg-shift-200"] = not tbl1.isDeltaPositive
            },
            backgroundStyle = if tbl1.isDeltaPositive then colors.positiveBackground else nil,
            testId = `{testId}.Delta`
        }
        local tbl5 = {
            Arrow = React.createElement(Icon, {
                LayoutOrder = 1,
                name = if tbl1.isDeltaPositive then IconName.ArrowWideShortUp else IconName.ArrowWideShortDown,
                size = IconSize.XSmall,
                variant = IconVariant.Filled,
                style = if tbl1.isDeltaPositive then colors.positive else colors.muted
            }),
            Value = React.createElement(
                FoundationText,
                {
                    LayoutOrder = 2,
                    Text = tbl1.deltaText,
                    tag = "auto-xy text-caption-medium content-default"
                }
            )
        }
        var3 = createElement2(var4, tbl4, tbl5)
    end

    tbl3.Delta = var3
    return createElement(var2, tbl2, tbl3)
end

local function measureGutter(yTicks, labelFontSize: number, labelFont): number
    local maxX = 0
    for _, yTick in yTicks do
        maxX = math.max(
            maxX,
            Style.GetTextSize(yTick.label, labelFontSize, labelFont, Vector2.new(1000, 100), { addTemporaryPadding = false }).X
        )
    end

    return math.max(60, math.ceil(maxX) + 2 + 12)
end

local function renderYAxisLabels(tbl1)
    local axisLabel = tbl1.colors.axisLabel
    local var2 = PLOT_HEIGHT - 12 - 28
    local num1 = math.max(tbl1.maxY - tbl1.minY, 1e-6)

    local result = ({})
    for _, yTick in tbl1.yTicks do
        local yOffset2 = 12 + (tbl1.maxY - yTick.position) / num1 * var2
        local str1 = `YLabel_{yTick.position}`
        result[str1] = React.createElement(FoundationText, {
            Position = UDim2.new(0, 2, 0, yOffset2),
            Text = yTick.label,
            textStyle = axisLabel,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            tag = "anchor-center-left auto-xy text-body-small",
            ZIndex = 4
        })
    end

    return result
end

local function selectXAxisTicks(xAxisLabels, num1: number, labelFontSize: number, labelFont)
    local xAxisLabelsLen = #xAxisLabels
    if xAxisLabelsLen <= 2 or num1 <= 0 then
        return {}
    end

    local maxX = 0
    for _, xAxisLabel in xAxisLabels do
        maxX = math.max(
            maxX,
            Style.GetTextSize(xAxisLabel, labelFontSize, labelFont, Vector2.new(1000, 100), { addTemporaryPadding = false }).X
        )
    end

    if num1 < maxX then
        return {}
    end
    local num2 = maxX + 24
    local num3 = num1 / (xAxisLabelsLen - 1)

    local num4 = xAxisLabelsLen - 2

    for i = math.min(3, num4), 1, -1 do
        local tbl1 = {}
        local tbl2 = ({})
        for j = 1, i do
            local num5 = math.clamp(math.round(xAxisLabelsLen * j / (i + 1)), 1, xAxisLabelsLen - 2)
            if not tbl2[num5] then
                tbl2[num5] = true
                table.insert(tbl1, num5)
            end
        end

        local bool1 = #tbl1 == i
        for j = 2, #tbl1 do
            if (tbl1[j] - tbl1[j - 1]) * num3 < num2 then
                bool1 = false
                break
            end
        end

        if not bool1 then
            continue
        end

        local result = {}
        for _, position in tbl1 do
            table.insert(result, { position = position, label = xAxisLabels[position + 1] })
        end
        return result
    end

    return {}
end

local function renderXAxisLabels(tbl1, offset: number, num1: number, labelFontSize: number, labelFont)
    local axisLabel = tbl1.colors.axisLabel
    local num2 = math.max(tbl1.maxX - tbl1.minX, 1e-6)

    local result = ({})
    for _, value in selectXAxisTicks(tbl1.xAxisLabels, num1, labelFontSize, labelFont) do
        local xOffset = offset + (value.position - tbl1.minX) / num2 * num1
        local str1 = `XLabel_{value.position}`
        result[str1] = React.createElement(FoundationText, {
            Position = UDim2.new(0, xOffset, 0, var1 + 4),
            Text = value.label,
            textStyle = axisLabel,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Top,
            tag = "anchor-top-center auto-xy text-body-small",
            ZIndex = 4
        })
    end

    return result
end

local function MetricChartView(tbl1)
    local testId = tbl1.testId or "MetricChartView"
    local colors = tbl1.colors
    local labelFont = tbl1.labelFont
    local labelFontSize = tbl1.labelFontSize

    local var2, var3 = React.useState(0)

    local var4, var5 = React.useBinding(0)

    local tbl2 = {
        ValueRow = if tbl1.hideHeader then nil else renderValueRow(tbl1, testId)
    }

    if tbl1.hasData then
        local offset = measureGutter(tbl1.yTicks, labelFontSize, labelFont)

        local points = ({})
        for k, point in tbl1.points do
            points[k] = { Position = point }
        end

        local tbl4 = {
            Curve = React.createElement(Curve, {
                Points = points,
                Color3 = colors.line.Color3,
                Thickness = 3,
                ZIndex = 3,
                Tag = `data-testid={testId}.Curve`
            }),
            Input = React.createElement(InputDetector, {
                OnHoverStart = tbl1.onHoverStart,
                OnHoverMoved = tbl1.onHoverMoved,
                OnHoverEnded = tbl1.onHoverEnded,
                OnPress = tbl1.onPress,
                OnDragStart = tbl1.onDragStart,
                OnDragMoved = tbl1.onDragMoved,
                OnDragEnded = tbl1.onDragEnded,
                TreatMouseAsAnchor = true,
                ZIndex = 20
            })
        }

        for _, yTick in tbl1.yTicks do
            local str1 = `Grid_{yTick.position}`
            tbl4[str1] = React.createElement(GridLine, {
                Orientation = "Horizontal",
                Position = yTick.position,
                Color3 = colors.grid.Color3,
                Transparency = colors.grid.Transparency,
                Thickness = 1,
                ZIndex = 1
            })
        end

        local tbl5 = renderYAxisLabels(tbl1)

        local var6 = var2 - offset - 8
        for value, value2 in renderXAxisLabels(tbl1, offset, var6, labelFontSize, labelFont) do
            tbl5[value] = value2
        end

        local childrenUnclipped = {}

        local var7 = nil
        local inspectedIndex = tbl1.inspectedIndex
        if inspectedIndex ~= nil and inspectedIndex >= 1 and inspectedIndex <= #tbl1.points then
            local point = tbl1.points[inspectedIndex]

            childrenUnclipped.InspectionLine = React.createElement(GridLine, {
                Orientation = "Vertical",
                Position = point.X,
                Color3 = colors.emphasis.Color3,
                Transparency = 0,
                Thickness = 2,
                ZIndex = 5
            })

            childrenUnclipped.InspectionPoint = React.createElement(Point, {
                Position = point,
                Color3 = colors.line.Color3,
                OutlineColor3 = colors.surface.Color3,
                OutlineThickness = 2,
                Size = 7,
                ZIndex = 6,
                Tag = `data-testid={testId}.InspectionPoint`
            })
            if tbl1.tooltip ~= nil then
                local var8 = (point.X - tbl1.minX) / math.max(tbl1.maxX - tbl1.minX, 1e-6)

                local var9 = var2 - 8
                local var10 = var4:map(function(num1: number): UDim2
                    local num2 = offset
                    local var10 = num2 + var8 * (var9 - num2)
                    local num3 = num1 / 2
                    local num4 = num2 + num3
                    local var11 = var9 - num3
                    local xOffset = if num4 <= var11 then math.clamp(var10, num4, var11) else (num2 + var9) / 2
                    return UDim2.new(0, xOffset, 0, yOffset)
                end)
                var7 = renderTooltip(var10, tbl1.tooltip, colors, testId, tbl1.icon, function(arg1)
                    var5(arg1.AbsoluteSize.X)
                end)
            end
        end

        tbl5[`Canvas_{tbl1.plotKey}`] = React.createElement(Canvas, {
            GraphRect = Rect.new(tbl1.minX, tbl1.minY, tbl1.maxX, tbl1.maxY),
            ViewportPaddingLeft = UDim.new(0, offset),
            ViewportPaddingRight = UDim.new(0, 8),
            ViewportPaddingTop = UDim.new(0, 12),
            ViewportPaddingBottom = UDim.new(0, 28),
            CanvasBackgroundTransparency = 1,
            ViewportBackgroundTransparency = 1,
            childrenUnclipped = childrenUnclipped
        }, tbl4)

        tbl5.Tooltip = var7

        tbl2.Chart = React.createElement(View, {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, PLOT_HEIGHT),
            tag = "clip",
            testId = `{testId}.Chart`,
            onAbsoluteSizeChanged = function(arg1)
                var3(arg1.AbsoluteSize.X)
            end
        }, tbl5)
    end

    local createElement = React.createElement
    local var6 = View
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-xsmall size-full-0 auto-y",
        testId = testId
    }
    local tbl4 = {
        Header = if tbl1.hideHeader then nil else React.createElement(
            View,
            { LayoutOrder = 1, tag = "col gap-xxsmall size-full-0 auto-y" },
            {
                Title = renderTitleBlock(tbl1, testId),
                Summary = if tbl1.summary == nil then nil else renderSummary(tbl1, testId)
            }
        ),
        Slot = React.createElement(View, { LayoutOrder = 2, tag = "col gap-large size-full-0 auto-y" }, tbl2)
    }
    return createElement(var6, tbl3, tbl4)
end

return MetricChartView
