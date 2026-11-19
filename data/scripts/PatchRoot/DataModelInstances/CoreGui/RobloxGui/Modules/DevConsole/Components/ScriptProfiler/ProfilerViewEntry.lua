-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)

local _ProfilerDataFormatV2 = require(script.Parent.ProfilerDataFormatV2)
local ProfilerUtil = require(script.Parent.ProfilerUtil)

local getDurations = ProfilerUtil.getDurations
local getNativeFlag = ProfilerUtil.getNativeFlag
local getPluginFlag = ProfilerUtil.getPluginFlag
local standardizeChildren = ProfilerUtil.standardizeChildren

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)
local Tooltip = require(Components.Tooltip)

local Actions = script.Parent.Parent.Parent.Actions
local SetScriptProfilerRoot = require(Actions.SetScriptProfilerRoot)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local EntryFrameHeight = Constants.GeneralFormatting.EntryFrameHeight
local DepthIndent = Constants.ScriptProfilerFormatting.DepthIndent
local ValueCellWidth = Constants.ScriptProfilerFormatting.ValueCellWidth
local CellPadding = Constants.ScriptProfilerFormatting.CellPadding
local ValuePadding = Constants.ScriptProfilerFormatting.ValuePadding

local var1 = Roact.PureComponent:extend("ProfilerViewEntry")

local var2 = RoactRodux.UNSTABLE_connect2(nil, function(callback) -- name: mapDispatchToProps
    return {
        dispatchSetScriptProfilerRoot = function(arg1, arg2, str1: string?)
            callback(SetScriptProfilerRoot(arg1, arg2, str1))
        end
    }
end)(var1)

local function BorderedCellLabel(tbl1)
    return Roact.createFragment({
        Label = Roact.createElement(CellLabel, { text = tbl1.text, size = tbl1.size, pos = tbl1.pos }),
        LeftBorder = Roact.createElement("Frame", {
            Size = UDim2.new(UDim.new(0, LineWidth), tbl1.size.Y),
            Position = UDim2.fromOffset(-ValuePadding, 0) + tbl1.pos,
            AnchorPoint = Vector2.new(0, 0),
            BackgroundColor3 = LineColor,
            BorderSizePixel = 0
        })
    })
end

local function getNodeName(props) -- Luacid: Inlined by compiler; 1 call site recovered
    local depth = props.depth
    local data = props.data
    local functionId = props.functionId

    local _function = data.Functions[functionId]

    local nodeName = props.nodeName

    if nodeName and #nodeName ~= 0 then
        return nodeName
    end

    return if depth == 0 and functionId == 0 then "<root>" else "<anonymous>"
end

function var1.init(arg1)
    arg1.state = {
        expanded = arg1.props.depth == 0 or arg1.props.expandedNodes[arg1.props.nodeId],
        showTooltip = false,
        tooltipPos = UDim2.fromOffset(0, 0)
    }

    function arg1.onButtonPress()
        arg1.props.expandedNodes[arg1.props.nodeId] = not arg1.state.expanded

        arg1:setState(function(_)
            return {
                expanded = not arg1.state.expanded
            }
        end)
    end

    function arg1.onMouseEnter(_, xOffset: number, yOffset: number)
        arg1:setState({ showTooltip = true, tooltipPos = UDim2.fromOffset(xOffset, yOffset) })
    end

    function arg1.onMouseMove(_, xOffset: number, yOffset: number)
        arg1:setState({ showTooltip = true, tooltipPos = UDim2.fromOffset(xOffset, yOffset) })
    end

    function arg1.onMouseLeave()
        arg1:setState({ showTooltip = false })
    end

    function arg1.onMouse2Click()
        arg1.props.dispatchSetScriptProfilerRoot(arg1.props.nodeId, arg1.props.functionId, (getNodeName(arg1.props)))
    end
end

function var1.renderChildren(arg1, arg2)
    local result = ({})
    if arg1.state.expanded then
        local percentageRatio = arg1.props.percentageRatio
        local durations = getDurations(arg1.props.data, arg1.props.nodeId)
        local depth = arg1.props.depth + 1
        local average = arg1.props.average
        local searchTerm = arg1.props.searchTerm
        local searchFilter = arg1.props.searchFilter
        local showPlugins = arg1.props.showPlugins
        local showGc = arg1.props.showGC
        local gcNodeOffsets = arg1.props.gcNodeOffsets
        local expandedNodes = arg1.props.expandedNodes

        local data = arg1.props.data
        local gcFuncId = data.GCFuncId

        if arg2 then
            for functionId, nodeId in pairs(arg2) do
                if #searchFilter > 0 and not searchFilter[nodeId] or not showGc and functionId == gcFuncId then
                    continue
                end

                local _ = data.Nodes[nodeId]
                local _function = data.Functions[functionId]

                if not showPlugins and getPluginFlag(data, _function) then
                    continue
                end

                local durations2 = getDurations(data, nodeId)
                local createElement = Roact.createElement
                local var4 = var2
                local tbl1 = {
                    layoutOrder = (durations - durations2) * 1000000,
                    depth = depth,
                    data = data,
                    nodeId = nodeId,
                    functionId = functionId,
                    nodeName = _function.Name,
                    average = average,
                    percentageRatio = percentageRatio,
                    searchTerm = searchTerm,
                    searchFilter = searchFilter,
                    showPlugins = showPlugins,
                    showGC = showGc,
                    gcNodeOffsets = gcNodeOffsets,
                    expandedNodes = expandedNodes
                }
                result[functionId] = createElement(var4, tbl1)
            end

            return result
        end

        if arg1.props.nodeId == 0 then
            assert(arg2 == nil)

            for value, value2 in data.Categories do
                if #searchFilter > 0 and not searchFilter[value2.NodeId] then
                    continue
                end

                local _ = data.Nodes[value2.NodeId]
                local durations2 = getDurations(data, value2.NodeId)

                local pluginOffset = arg1.props.pluginOffsets[value]
                local pluginGcOffset = arg1.props.pluginGCOffsets[value]

                if not showPlugins then
                    durations2 -= pluginOffset

                    if showGc then
                        durations2 -= pluginGcOffset
                    end
                end

                local createElement = Roact.createElement
                local var4 = var2
                local tbl1 = {
                    layoutOrder = (durations - durations2) * 1000000,
                    depth = depth,
                    data = data,
                    nodeId = value2.NodeId,
                    functionId = nil,
                    nodeName = value2.Name,
                    average = average,
                    percentageRatio = percentageRatio,
                    searchTerm = searchTerm,
                    searchFilter = searchFilter,
                    showPlugins = showPlugins,
                    pluginOffset = pluginOffset,
                    pluginGCOffset = pluginGcOffset,
                    showGC = showGc,
                    gcNodeOffsets = gcNodeOffsets,
                    expandedNodes = expandedNodes
                }
                result[value] = createElement(var4, tbl1)
            end
        end
    end

    return result
end

function var1.renderValues(_, arg1)
    local result = ({})
    local uDim2 = UDim2.new(ValueCellWidth, -ValuePadding, 0, EntryFrameHeight)
    local uDim2_2 = UDim2.new(1 - ValueCellWidth * #arg1, ValuePadding, 0, 0)
    for i, value in ipairs(arg1) do
        local str1 = tostring(i)
        result[str1] = Roact.createElement(
            BorderedCellLabel,
            {
                text = tostring(value),
                size = uDim2,
                pos = uDim2_2 + UDim2.fromScale(ValueCellWidth * (i - 1), 0)
            }
        )
    end

    return result
end

function var1.render(arg1)
    local props = arg1.props

    local var3 = props.size or UDim2.new(1, 0, 0, EntryFrameHeight)
    local depth = props.depth
    local layoutOrder = props.layoutOrder or 0
    local inset = depth * DepthIndent
    local percentageRatio = props.percentageRatio
    local data = props.data
    local showPlugins = props.showPlugins
    local showGc = props.showGC

    local nodeId = props.nodeId
    local functionId = props.functionId
    local _function = data.Functions[functionId]
    local var5 = data.Nodes[nodeId]

    local var6, var7 = getDurations(data, nodeId)

    local var8 = var6 / arg1.props.average
    local var9 = var7 / arg1.props.average

    local var10 = standardizeChildren(data, var5)

    if not showPlugins then
        if nodeId == 0 then
            var8 -= arg1.props.pluginOffsets.Total or 0

            if showGc then
                var8 -= arg1.props.pluginGCOffsets.Total or 0
            end
        else
            var8 -= arg1.props.pluginOffset or 0

            if showGc then
                var8 -= arg1.props.pluginGCOffset or 0
            end
        end
    end

    if not showGc then
        local gcNodeOffsets = props.gcNodeOffsets

        if nodeId == 0 then
            var8 -= gcNodeOffsets.Total or 0
        else
            var8 -= gcNodeOffsets[nodeId] or 0
        end
    end

    local var11, var12

    if percentageRatio then
        if percentageRatio == 0 then
            var11 = "N/A"
            var12 = "N/A"
        else
            var11 = string.format("%.3f%%", var8 / percentageRatio)
            var12 = string.format("%.3f%%", var9 / percentageRatio)
        end
    else
        var11 = string.format("%.3f", var8 * 1000)
        var12 = string.format("%.3f", var9 * 1000)
    end

    local tbl1 = { var11, var12 }
    local depth2 = props.depth
    local data2 = props.data
    local functionId2 = props.functionId

    local _function2 = data2.Functions[functionId2]

    local str1 = if depth2 == 0 and functionId2 == 0 then "<root>" else "<anonymous>"
    local nodeName = props.nodeName
    if nodeName and #nodeName ~= 0 then
        str1 = nodeName
    end

    local text = ProfilerUtil.getSourceLocationString(data, _function, str1)

    local nativeFlag = getNativeFlag(data, _function)
    if getPluginFlag(data, _function) then
        str1 ..= " <plugin>"
    end

    if nativeFlag then
        str1 ..= " <native>"
    end

    local uDim = UDim.new(1 - ValueCellWidth * #tbl1, -inset)

    return Roact.createElement(
        "Frame",
        {
            Size = var3,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            AutomaticSize = Enum.AutomaticSize.Y
        },
        {
            tooltip = if arg1.state.showTooltip then Roact.createElement(Tooltip, { text = text, pos = arg1.state.tooltipPos }) else nil,
            layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            button = Roact.createElement(BannerButton, {
                size = UDim2.new(1, 0, 0, EntryFrameHeight),
                inset = inset,
                isExpanded = arg1.state.expanded,
                isExpandable = if var10 and next(var10) ~= nil then true else depth == 0,
                onButtonPress = arg1.onButtonPress,
                onMouseEnter = arg1.onMouseEnter,
                onMouseLeave = arg1.onMouseLeave,
                onMouseMove = arg1.onMouseMove,
                onMouse2Click = arg1.onMouse2Click,
                layoutOrder = -1
            }, {
                name = Roact.createElement(
                    CellLabel,
                    {
                        text = str1,
                        size = UDim2.new(uDim, UDim.new(1, 0)),
                        pos = UDim2.new(0, CellPadding + inset, 0, 0)
                    }
                ),
                values = Roact.createFragment(arg1:renderValues(tbl1))
            }),
            children = Roact.createFragment(arg1:renderChildren(var10))
        }
    )
end
return var2
