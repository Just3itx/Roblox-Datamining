-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local _Actions = script.Parent.Parent.Parent.Actions

local Components = script.Parent.Parent.Parent.Components
local DataConsumer = require(Components.DataConsumer)
local LineGraph = require(Components.LineGraph)
local Sparkline = require(Components.Sparkline)
local MainViewConnectivityPanel = require(script.Parent.MainViewConnectivityPanel)
local MainViewSubscriptionsPanel = require(script.Parent.MainViewSubscriptionsPanel)
local MainViewRemoteOperationsPanel = require(script.Parent.MainViewRemoteOperationsPanel)
local MainViewClientOperationQueuePanel = require(script.Parent.MainViewClientOperationQueuePanel)
local CollapsibleSection = require(script.Parent.CollapsibleSection)

local Constants = require(script.Parent.Parent.Parent.Constants)
local MainRowPadding = Constants.GeneralFormatting.MainRowPadding
local LineGraphHeight = Constants.GeneralFormatting.LineGraphHeight

local UtilAndTab = require(Components.UtilAndTab)

local tbl1 = {
    rttMs = true,
    incomingBitrateKbps = true,
    outgoingBitrateKbps = true,
    incomingJitterMs = true,
    outgoingJitterMs = true,
    jitterBufferDelayMs = true,
    incomingLossPercent = true
}

local tbl2 = { "Connection", "Incoming", "Outgoing" }

local convertTimeStamp = require(script.Parent.Parent.Parent.Util.convertTimeStamp)

local VoiceDebugFieldMeta = require(script.Parent.VoiceDebugFieldMeta)
local VoiceDebugFieldDisplayOrder = require(script.Parent.VoiceDebugFieldDisplayOrder)

local GetFFlagVoiceDebugConsoleV2 = require(script.Parent.GetFFlagVoiceDebugConsoleV2)

local FreezeToggle = require(script.Parent.FreezeToggle)
local VoiceSourceToggle = require(script.Parent.VoiceSourceToggle)

local tbl3 = {
    totalConcealmentEvents = true,
    lastPublisherAudioLevelDbov = true,
    lastSubscriberAudioLevelDbov = true
}

local var1 = table.clone(VoiceDebugFieldDisplayOrder)

for _, value in {
    "incomingBitrateKbps",
    "outgoingBitrateKbps",
    "outgoingCodec",
    "incomingLossPercent",
    "totalConcealmentEvents",
    "lastPublisherAudioLevelDbov",
    "lastSubscriberAudioLevelDbov"
} do
    table.insert(var1, value)
end

local function getX(arg1)
    return arg1.time
end

local function getY(arg1)
    return arg1.value
end

local function makeStringFormatY(str1: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    local unit = VoiceDebugFieldMeta[str1] and VoiceDebugFieldMeta[str1].unit
    return function(arg1): string
        if unit then
            return string.format("%.1f %s", arg1, unit)
        end
        return string.format("%.1f", arg1)
    end
end

local function getFieldSeverity(str1: string, arg1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return VoiceDebugFieldMeta.getFieldSeverity(str1, arg1)
end

local function severityColor(str1: string, color3: Color3) -- Luacid: Inlined by compiler; 9 call sites recovered
    if str1 == "error" then
        return Constants.Color.ErrorRed
    elseif str1 == "warn" then
        return Constants.Color.WarningYellow
    elseif str1 == "ok" then
        return Constants.Color.HoverGreen
    end

    return color3
end

local function formatNumber(str1: string, stat: number): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl1[str1] then
        return string.format("%.2f", stat)
    end
    return tostring(stat)
end

local function formatValue(str1: string, stat)
    if stat == nil then
        return "—"
    end
    local var2 = VoiceDebugFieldMeta[str1]
    local unit = var2 and var2.unit
    local str2 = formatNumber(str1, stat)

    if unit then
        return string.format("%s %s", str2, unit)
    end
    return str2
end

local function formatCardSubCaption(arg1, str1: string?): string -- Luacid: unused: defined but never referenced
    local str2 = arg1 and string.format("%.1f", arg1.max) or "—"
    if str1 then
        return string.format("%s · peak %s%s", str1, str2, str1)
    end
    return string.format("peak %s", str2)
end

local function formatCardValue(arg1, num1: number?): string -- Luacid: unused: defined but never referenced
    if type(arg1) ~= "number" then
        return "—"
    end
    return string.format("%." .. tostring(num1 or 0) .. "f", arg1)
end

local function HealthCard(arg1)
    local severity = arg1.severity
    local constantsColorText = Constants.Color.Text

    if severity == "error" then
        constantsColorText = severityColor("error", nil)
    elseif severity == "warn" then
        constantsColorText = severityColor("warn", nil)
    elseif severity == "ok" then
        constantsColorText = severityColor("ok", nil)
    end

    return Roact.createElement("Frame", {
        LayoutOrder = arg1.layoutOrder,
        Size = UDim2.new(0, 110, 0, 56),
        BackgroundColor3 = Constants.Color.TextBoxGray,
        BorderSizePixel = 0
    }, {
        Stroke = Roact.createElement("UIStroke", { Color = Constants.Color.BorderGray, Thickness = 1, Transparency = 0.5 }),
        Padding = Roact.createElement("UIPadding", {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 6),
            PaddingBottom = UDim.new(0, 6)
        }),
        Layout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
        Caption = Roact.createElement("TextLabel", {
            LayoutOrder = 1,
            Size = UDim2.new(1, 0, 0, 14),
            Text = arg1.caption,
            Font = Constants.Font.MainWindowHeader,
            TextSize = Constants.DefaultFontSize.MainWindowHeader,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1
        }),
        Value = Roact.createElement("TextLabel", {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 0, 20),
            Text = arg1.value,
            Font = Constants.Font.MainWindowBold,
            TextSize = 18,
            TextColor3 = constantsColorText,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1
        }),
        SubCaption = Roact.createElement("TextLabel", {
            LayoutOrder = 3,
            Size = UDim2.new(1, 0, 0, 12),
            Text = arg1.subCaption or "",
            Font = Constants.Font.MainWindow,
            TextSize = 11,
            TextColor3 = Constants.Color.BorderGray,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1
        })
    })
end

local var2 = Roact.PureComponent:extend("MainViewVoiceDebug")

function var2.init(arg1)
    function arg1.onUtilTabHeightChanged(utilTabHeight)
        arg1:setState({ utilTabHeight = utilTabHeight })
    end

    function arg1.onStatsUpdated(stats)
        if arg1.state.frozen then
            return
        end
        arg1:setState({
            stats = stats,
            series = arg1.props.VoiceDebugData:getSeries(),
            connectivity = arg1.props.VoiceDebugData:getConnectivity(),
            subscriptions = arg1.props.VoiceDebugData:getSubscriptions(),
            remoteOperations = arg1.props.VoiceDebugData:getRemoteOperations(),
            source = arg1.props.VoiceDebugData:getSource()
        })
    end

    function arg1.onSourceChanged(source)
        arg1.props.VoiceDebugData:setSource(source)
        arg1:setState({
            source = source,
            stats = arg1.props.VoiceDebugData:getCurrentData(),
            series = arg1.state.frozen and arg1.props.VoiceDebugData:getSeriesSnapshot() or arg1.props.VoiceDebugData:getSeries(),
            connectivity = arg1.props.VoiceDebugData:getConnectivity(),
            subscriptions = arg1.props.VoiceDebugData:getSubscriptions(),
            remoteOperations = arg1.props.VoiceDebugData:getRemoteOperations()
        })
    end

    function arg1.onFreezeToggled()
        if not arg1.state.frozen then
            arg1:setState({ frozen = true, series = arg1.props.VoiceDebugData:getSeriesSnapshot() })

            return
        end

        arg1:setState({
            frozen = false,
            stats = arg1.props.VoiceDebugData:getCurrentData(),
            series = arg1.props.VoiceDebugData:getSeries(),
            connectivity = arg1.props.VoiceDebugData:getConnectivity(),
            subscriptions = arg1.props.VoiceDebugData:getSubscriptions(),
            remoteOperations = arg1.props.VoiceDebugData:getRemoteOperations()
        })
    end

    arg1._statsUpdatedConnection = arg1.props.VoiceDebugData:Signal():Connect(arg1.onStatsUpdated)

    arg1.utilRef = Roact.createRef()

    arg1.state = {
        utilTabHeight = 0,
        stats = {},
        series = {},
        connectivity = {},
        subscriptions = {},
        remoteOperations = {},
        source = arg1.props.VoiceDebugData:getSource(),
        selectedGraphKeyByGroup = {},
        frozen = false
    }
end

function var2.didMount(arg1)
    arg1:setState({ utilTabHeight = arg1.utilRef.current.Size.Y.Offset })
end

function var2.didUpdate(arg1)
    local currentSize = arg1.utilRef.current.Size
    if currentSize.Y.Offset ~= arg1.state.utilTabHeight then
        arg1:setState({ utilTabHeight = currentSize.Y.Offset })
    end
end

function var2.willUnmount(arg1)
    if arg1._statsUpdatedConnection then
        arg1._statsUpdatedConnection:Disconnect()
        arg1._statsUpdatedConnection = nil
    end
end

function var2.onGraphRowClicked(tbl4, str1: string)
    local var3 = VoiceDebugFieldMeta[str1]
    local var4 = if var3 then var3.group or str1 else str1
    local selectedGraphKeyByGroup = table.clone(tbl4.state.selectedGraphKeyByGroup)
    if selectedGraphKeyByGroup[var4] == str1 then
        selectedGraphKeyByGroup[var4] = nil
    else
        selectedGraphKeyByGroup[var4] = str1
    end
    tbl4:setState({ selectedGraphKeyByGroup = selectedGraphKeyByGroup })
end

function var2.renderHealthStrip(arg1)
    local stats = arg1.state.stats
    local series = arg1.state.series

    local createElement = Roact.createElement
    local tbl4 = {
        LayoutOrder = 0,
        Size = UDim2.new(1, 0, 0, 56),
        BackgroundTransparency = 1
    }
    local tbl5 = {
        Layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, MainRowPadding)
        }),
        RoundTrip = 0,
        LossIn = 0,
        JitterIn = 0,
        Streams = 0
    }

    local createElement2 = Roact.createElement
    local func1 = HealthCard
    local tbl6 = {
        layoutOrder = 1,
        caption = "Round-trip",
        value = 0,
        severity = 0,
        subCaption = 0
    }

    local rttMs = stats.rttMs
    tbl6.value = if type(rttMs) ~= "number" then "—" else string.format("%." .. tostring(2) .. "f", rttMs)
    tbl6.severity = getFieldSeverity("rttMs", stats.rttMs)
    local rttMs2 = series.rttMs
    local str1 = rttMs2 and string.format("%.1f", rttMs2.max) or "—"

    tbl6.subCaption = string.format("%s · peak %s%s", "ms", str1, "ms")
    tbl5.RoundTrip = createElement2(func1, tbl6)

    local createElement3 = Roact.createElement
    local func2 = HealthCard
    local tbl7 = { layoutOrder = 2, caption = "Loss in", value = 0, severity = 0, subCaption = 0 }

    local incomingLossPercent = stats.incomingLossPercent
    tbl7.value = if type(incomingLossPercent) ~= "number" then "—" else string.format("%." .. tostring(1) .. "f", incomingLossPercent)
    tbl7.severity = getFieldSeverity("incomingLossPercent", stats.incomingLossPercent)
    local incomingLossPercent2 = series.incomingLossPercent
    local str2 = incomingLossPercent2 and string.format("%.1f", incomingLossPercent2.max) or "—"

    tbl7.subCaption = string.format("%s · peak %s%s", "%", str2, "%")
    tbl5.LossIn = createElement3(func2, tbl7)

    local createElement4 = Roact.createElement
    local func3 = HealthCard
    local tbl8 = { layoutOrder = 3, caption = "Jitter in", value = 0, severity = 0, subCaption = 0 }

    local incomingJitterMs = stats.incomingJitterMs
    tbl8.value = if type(incomingJitterMs) ~= "number" then "—" else string.format("%." .. tostring(2) .. "f", incomingJitterMs)
    tbl8.severity = getFieldSeverity("incomingJitterMs", stats.incomingJitterMs)
    local incomingJitterMs2 = series.incomingJitterMs
    local str3 = incomingJitterMs2 and string.format("%.1f", incomingJitterMs2.max) or "—"

    tbl8.subCaption = string.format("%s · peak %s%s", "ms", str3, "ms")
    tbl5.JitterIn = createElement4(func3, tbl8)

    tbl5.Streams = Roact.createElement(HealthCard, {
        layoutOrder = 4,
        caption = "Streams",
        value = string.format("%s / %s", tostring(stats.incomingStreams or "—"), tostring(stats.outgoingStreams or "—")),
        severity = nil,
        subCaption = "in / out"
    })
    return createElement("Frame", tbl4, tbl5)
end

local function buildStatRow(tbl4, text: string, stat, layoutOrder: number)
    local var3 = VoiceDebugFieldMeta[text]
    local var4 = if var3 then var3.label or text else text

    if not GetFFlagVoiceDebugConsoleV2() then
        local str1 = string.format("%s: %s", var4, formatValue(text, stat))
        return Roact.createElement("TextLabel", {
            LayoutOrder = layoutOrder,
            Size = UDim2.new(1, 0, 0, 20),
            Text = str1,
            TextColor3 = Constants.Color.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1
        })
    end

    local unit = var3 and var3.unit or ""
    local var5 = tbl4.state.series[text]
    local bool1 = not (var3 == nil or var3.plottable ~= true) and var5 ~= nil
    local fieldSeverity = getFieldSeverity(text, stat)

    local constantsColorText = Constants.Color.Text

    if fieldSeverity == "error" then
        constantsColorText = severityColor("error", nil)
    elseif fieldSeverity == "warn" then
        constantsColorText = severityColor("warn", nil)
    elseif fieldSeverity == "ok" then
        constantsColorText = severityColor("ok", nil)
    end

    local bool2 = fieldSeverity == "warn" or fieldSeverity == "error"

    local tbl5 = { Accent = 0, Label = 0, Value = 0, Unit = 0, Delta = 0 }
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl6 = {
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 3, 1, 0),
        BackgroundColor3 = 0,
        BackgroundTransparency = 0,
        BorderSizePixel = 0
    }
    local warningYellow = Constants.Color.WarningYellow

    if fieldSeverity == "error" then
        warningYellow = severityColor("error", nil)
    elseif fieldSeverity == "warn" then
        warningYellow = severityColor("warn", nil)
    elseif fieldSeverity == "ok" then
        warningYellow = severityColor("ok", nil)
    end

    tbl6.BackgroundColor3 = warningYellow
    tbl6.BackgroundTransparency = if bool2 then 0 else 1
    tbl5.Accent = createElement(str1, tbl6)

    tbl5.Label = Roact.createElement("TextLabel", {
        Position = UDim2.new(0, 11, 0, 0),
        Size = UDim2.new(1, -251, 1, 0),
        Text = var4,
        Font = Constants.Font.MainWindow,
        TextSize = Constants.DefaultFontSize.MainWindow,
        TextColor3 = Constants.Color.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1
    })
    tbl5.Value = Roact.createElement("TextLabel", {
        Position = UDim2.new(1, -180, 0, 0),
        Size = UDim2.new(0, 56, 1, 0),
        Text = if stat == nil then "—" else formatNumber(text, stat) or "—",
        Font = Constants.Font.MainWindowBold,
        TextSize = Constants.DefaultFontSize.MainWindow,
        TextColor3 = constantsColorText,
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1
    })

    tbl5.Unit = Roact.createElement("TextLabel", {
        Position = UDim2.new(1, -116, 0, 0),
        Size = UDim2.new(0, 36, 1, 0),
        Text = unit,
        Font = Constants.Font.MainWindow,
        TextSize = Constants.DefaultFontSize.MainWindow,
        TextColor3 = Constants.Color.BorderGray,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    })

    tbl5.Delta = Roact.createElement("TextLabel", {
        Position = UDim2.new(1, -72, 0, 0),
        Size = UDim2.new(0, 72, 1, 0),
        Text = bool1 and string.format("peak %.1f", var5.max) or "—",
        Font = Constants.Font.MainWindow,
        TextSize = Constants.DefaultFontSize.MainWindow,
        TextColor3 = Constants.Color.BorderGray,
        TextXAlignment = Enum.TextXAlignment.Right,
        BackgroundTransparency = 1
    })

    if bool1 then
        local createElement2 = Roact.createElement
        local tbl7 = {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(1, -240, 0.5, 0),
            Size = UDim2.new(0, 52, 0, 13),
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1
        }

        tbl7[Roact.Event.Activated] = function()
            tbl4:onGraphRowClicked(text)
        end

        tbl5.SparklineButton = createElement2("TextButton", tbl7, {
            Sparkline = Roact.createElement(Sparkline, {
                dataSet = var5.dataSet,
                getY = getY,
                minY = var5.min,
                maxY = var5.max,
                color = bool2 and Constants.Color.WarningYellow or Constants.Color.HighlightBlue,
                size = UDim2.new(1, 0, 1, 0)
            })
        })
    end

    return Roact.createElement(
        "Frame",
        {
            LayoutOrder = layoutOrder,
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundTransparency = 1
        },
        tbl5
    )
end

local function buildGraphElement(arg1, arg2, str1: string, layoutOrder: number)
    return Roact.createElement(LineGraph, {
        pos = UDim2.new(0, 0, 0, MainRowPadding),
        size = UDim2.new(1, -32, 0, LineGraphHeight),
        layoutOrder = layoutOrder,
        graphData = arg1.dataSet,
        minY = arg1.min,
        maxY = arg1.max,
        getX = getX,
        getY = getY,
        axisLabelX = "Time",
        axisLabelY = arg2.label,
        stringFormatX = convertTimeStamp,
        stringFormatY = makeStringFormatY(str1)
    })
end

function var2.renderStatLabels(tbl4, tbl5)
    local tbl6 = ({})
    local num1 = 0
    local num2 = 0

    local function addRow(text: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        num1 += 1
        num2 += 20
        tbl6[text] = buildStatRow(tbl4, text, tbl4.state.stats[text], num1)
    end

    local function insertGraph(str1: string, arg1) -- Luacid: unused: defined but never referenced
        local var3 = tbl4.state.series[str1]
        if not var3 then
            return
        end
        num1 += 1
        num2 += LineGraphHeight + MainRowPadding
        tbl6["__graph_" .. str1] = buildGraphElement(var3, arg1, str1, num1)
    end

    if GetFFlagVoiceDebugConsoleV2() then
        local tbl7 = ({})
        for _, value in tbl2 do
            tbl7[value] = {}
        end
        local tbl8 = {}
        for _, value in tbl5 do
            local var3 = VoiceDebugFieldMeta[value]
            local group = var3 and var3.group
            if group and tbl7[group] then
                table.insert(tbl7[group], value)
            else
                table.insert(tbl8, value)
            end
        end

        for _, value in tbl2 do
            local var3 = tbl7[value]
            if not (#var3 > 0) then
                continue
            end

            num1 += 1
            num2 += 18
            local var4 = "__group_header_" .. value
            local createElement = Roact.createElement
            local tbl9 = {
                LayoutOrder = num1,
                Size = UDim2.new(1, 0, 0, 18),
                Text = value,
                Font = Constants.Font.MainWindowHeader,
                TextSize = Constants.DefaultFontSize.MainWindowHeader,
                TextColor3 = Constants.Color.BorderGray,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            }
            tbl6[var4] = createElement("TextLabel", tbl9)

            for _, value2 in var3 do
                addRow(value2)
            end

            local var5 = tbl4.state.selectedGraphKeyByGroup[value]
            local var6 = var5 and VoiceDebugFieldMeta[var5]
            if not (var6 and var6.plottable) then
                continue
            end

            local var7 = tbl4.state.series[var5]
            if var7 then
                num1 += 1
                local var8 = LineGraphHeight + MainRowPadding
                num2 += var8
                tbl6["__graph_" .. var5] = buildGraphElement(var7, var6, var5, num1)
            end
        end

        for _, value in tbl8 do
            addRow(value)
            local var3 = VoiceDebugFieldMeta[value]
            if not var3 or not var3.plottable or tbl4.state.selectedGraphKeyByGroup[value] ~= value then
                continue
            end

            local var4 = tbl4.state.series[value]
            if var4 then
                num1 += 1
                local var5 = LineGraphHeight + MainRowPadding
                num2 += var5
                tbl6["__graph_" .. value] = buildGraphElement(var4, var3, value, num1)
            end
        end
    else
        for _, value in tbl5 do
            addRow(value)
        end
    end

    local fFlagVoiceDebugConsoleV2 = GetFFlagVoiceDebugConsoleV2()
    for k in tbl4.state.stats do
        if not tbl6[k] and (fFlagVoiceDebugConsoleV2 or not tbl3[k]) then
            addRow(k)
        end
    end

    return tbl6, num2
end

function var2.renderGraphs(tbl4, tbl5)
    local tbl6 = ({})
    local num1 = 0

    if GetFFlagVoiceDebugConsoleV2() then
        return tbl6, num1
    end

    for _, value in tbl5 do
        local var3 = VoiceDebugFieldMeta[value]
        local var4 = tbl4.state.series[value]
        if not (var3 and var3.plottable and var4) then
            continue
        end

        num1 += 1
        local createElement = Roact.createElement
        local var5 = LineGraph
        local tbl7 = {
            pos = UDim2.new(),
            size = UDim2.new(1, -32, 0, LineGraphHeight),
            layoutOrder = num1,
            graphData = var4.dataSet,
            minY = var4.min,
            maxY = var4.max,
            getX = getX,
            getY = getY,
            axisLabelX = "Time",
            axisLabelY = var3.label,
            stringFormatX = convertTimeStamp,
            stringFormatY = makeStringFormatY(value)
        }
        tbl6[value] = createElement(var5, tbl7)
    end

    return tbl6, num1
end

function var2.render(arg1)
    local size = arg1.props.size
    local formFactor = arg1.props.formFactor
    local tabList = arg1.props.tabList

    local var3 = GetFFlagVoiceDebugConsoleV2() and var1 or VoiceDebugFieldDisplayOrder

    local var4, yOffset = arg1:renderStatLabels(var3)
    local var5, var6 = arg1:renderGraphs(var3)

    local yOffset2 = var6 * LineGraphHeight + math.max(0, var6 - 1) * MainRowPadding
    local utilTabHeight = arg1.state.utilTabHeight

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl4 = { Size = size, BackgroundTransparency = 1, LayoutOrder = 3 }

    local tbl5 = {
        UIListLayout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Top,
            Padding = UDim.new(0, MainRowPadding)
        }),
        FramePadding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 16) }),
        UtilAndTab = 0,
        Content = 0
    }

    local createElement2 = Roact.createElement
    local var7 = UtilAndTab
    local tbl6 = {
        windowWidth = size.X.Offset,
        formFactor = formFactor,
        tabList = tabList,
        layoutOrder = 1,
        refForParent = arg1.utilRef,
        onHeightChanged = arg1.onUtilTabHeightChanged,
        extraContent = 0
    }
    local element

    if GetFFlagVoiceDebugConsoleV2() then
        element = Roact.createElement("Frame", {
            AutomaticSize = Enum.AutomaticSize.X,
            Size = UDim2.new(0, 0, 1, 0),
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, if formFactor == Constants.FormFactor.Small then -24 else -20, 0.5, 0)
        }, {
            Layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 8)
            }),
            VoiceSourceToggle = if GetFFlagVoiceDebugConsoleV2() then Roact.createElement(
                VoiceSourceToggle,
                {
                    source = arg1.state.source,
                    onSourceChanged = arg1.onSourceChanged,
                    layoutOrder = 1
                }
            )
                or nil else nil,
            FreezeToggle = Roact.createElement(FreezeToggle, { frozen = arg1.state.frozen, onToggle = arg1.onFreezeToggled, layoutOrder = 2 })
        })
            or nil
    else
        element = nil
    end

    tbl6.extraContent = element
    tbl5.UtilAndTab = createElement2(var7, tbl6)

    tbl5.Content = Roact.createElement(
        "ScrollingFrame",
        {
            LayoutOrder = 2,
            Size = UDim2.new(1, 0, 1, -utilTabHeight),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 5
        },
        GetFFlagVoiceDebugConsoleV2()
            and {
                UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) }),
                ContentPadding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, 24) }),
                MetricsSection = Roact.createElement(CollapsibleSection, {
                    title = "Metrics",
                    layoutOrder = 1
                }, {
                    HealthStrip = arg1:renderHealthStrip(),
                    StatsContainer = Roact.createElement(
                        "Frame",
                        {
                            LayoutOrder = 2,
                            Size = UDim2.new(1, 0, 0, yOffset),
                            BackgroundTransparency = 1
                        },
                        {
                            UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                            Labels = Roact.createFragment(var4)
                        }
                    )
                }),
                ConnectivityContainer = Roact.createElement(MainViewConnectivityPanel, { connectivity = arg1.state.connectivity, layoutOrder = 2 }),
                SubscriptionsContainer = Roact.createElement(MainViewSubscriptionsPanel, { subscriptions = arg1.state.subscriptions, layoutOrder = 3 }),
                RemoteOperationsContainer = Roact.createElement(MainViewRemoteOperationsPanel, { remoteOperations = arg1.state.remoteOperations, layoutOrder = 4 }),
                ClientOperationQueueContainer = Roact.createElement(
                    MainViewClientOperationQueuePanel,
                    {
                        remoteOperations = arg1.state.remoteOperations,
                        layoutOrder = 5
                    }
                ),
                BottomSpacer = Roact.createElement("Frame", { Size = UDim2.new(1, 0, 0, 16), LayoutOrder = 6, BackgroundTransparency = 1 })
            }
            or {
                UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) }),
                ContentPadding = Roact.createElement("UIPadding", { PaddingRight = UDim.new(0, 24) }),
                StatsContainer = Roact.createElement(
                    "Frame",
                    {
                        LayoutOrder = 1,
                        Size = UDim2.new(1, 0, 0, yOffset),
                        BackgroundTransparency = 1
                    },
                    {
                        UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
                        Labels = Roact.createFragment(var4)
                    }
                ),
                GraphsContainer = Roact.createElement(
                    "Frame",
                    {
                        LayoutOrder = 2,
                        Size = UDim2.new(1, 0, 0, yOffset2),
                        BackgroundTransparency = 1
                    },
                    {
                        UIListLayout = Roact.createElement("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, MainRowPadding) }),
                        Graphs = Roact.createFragment(var5)
                    }
                ),
                ConnectivityContainer = Roact.createElement(MainViewConnectivityPanel, { connectivity = arg1.state.connectivity, layoutOrder = 3 })
            }
    )
    return createElement(str1, tbl4, tbl5)
end

return DataConsumer(var2, "VoiceDebugData")
