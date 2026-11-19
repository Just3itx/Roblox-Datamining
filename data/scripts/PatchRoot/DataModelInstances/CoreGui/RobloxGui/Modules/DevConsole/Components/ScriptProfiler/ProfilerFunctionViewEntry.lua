-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Roact = require(CorePackages.Packages.Roact)

local ProfilerUtil = require(script.Parent.ProfilerUtil)

local _getDurations = ProfilerUtil.getDurations
local _getSourceName = ProfilerUtil.getSourceName
local _getLine = ProfilerUtil.getLine
local getNativeFlag = ProfilerUtil.getNativeFlag
local getPluginFlag = ProfilerUtil.getPluginFlag
local _standardizeChildren = ProfilerUtil.standardizeChildren

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)
local Tooltip = require(Components.Tooltip)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local EntryFrameHeight = Constants.GeneralFormatting.EntryFrameHeight
local _DepthIndent = Constants.ScriptProfilerFormatting.DepthIndent
local ValueCellWidth = Constants.ScriptProfilerFormatting.ValueCellWidth
local CellPadding = Constants.ScriptProfilerFormatting.CellPadding
local ValuePadding = Constants.ScriptProfilerFormatting.ValuePadding

local var1 = Roact.PureComponent:extend("ProfilerFunctionViewEntry")

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

function var1.init(arg1)
    arg1.state = {
        expanded = arg1.props.depth == 0,
        showTooltip = false,
        tooltipPos = UDim2.fromOffset(0, 0)
    }

    function arg1.onButtonPress()
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

    local var2 = props.size or UDim2.new(1, 0, 0, EntryFrameHeight)
    local layoutOrder = props.layoutOrder or 0

    local percentageRatio = props.percentageRatio
    local data = props.data

    local functionId = props.functionId
    local _function = data.Functions[functionId]

    local var3 = _function.TotalDuration / arg1.props.average - (arg1.props.gcOffset or 0)

    local nativeFlag = getNativeFlag(data, _function)
    local pluginFlag = getPluginFlag(data, _function)

    local tbl1 = { if percentageRatio then if percentageRatio == 0 then "N/A" else string.format("%.3f%%", var3 / percentageRatio) else string.format("%.3f", var3 * 1000) }

    local nodeName = props.nodeName
    local var4 = nodeName and #nodeName ~= 0 and nodeName or "<anonymous>"

    local sourceLocationString = ProfilerUtil.getSourceLocationString(data, _function, var4)

    if var4 == "<anonymous>" then
        var4 = sourceLocationString
        sourceLocationString = ""
    end

    if pluginFlag then
        var4 ..= " <plugin>"
    end

    if nativeFlag then
        var4 ..= " <native>"
    end

    local uDim = UDim.new(1 - ValueCellWidth * #tbl1, -0)

    return Roact.createElement(
        "Frame",
        {
            Size = var2,
            BackgroundTransparency = 1,
            LayoutOrder = layoutOrder,
            AutomaticSize = Enum.AutomaticSize.Y
        },
        {
            tooltip = if arg1.state.showTooltip then Roact.createElement(Tooltip, { text = sourceLocationString, pos = arg1.state.tooltipPos }) else nil,
            layout = Roact.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }),
            button = Roact.createElement(BannerButton, {
                size = UDim2.new(1, 0, 0, EntryFrameHeight),
                inset = 0,
                isExpanded = arg1.state.expanded,
                isExpandable = false,
                onButtonPress = arg1.onButtonPress,
                onMouseEnter = arg1.onMouseEnter,
                onMouseLeave = arg1.onMouseLeave,
                onMouseMove = arg1.onMouseMove,
                layoutOrder = -1
            }, {
                name = Roact.createElement(
                    CellLabel,
                    {
                        text = var4,
                        size = UDim2.new(uDim, UDim.new(1, 0)),
                        pos = UDim2.new(0, CellPadding + 0, 0, 0)
                    }
                ),
                values = Roact.createFragment(arg1:renderValues(tbl1))
            })
        }
    )
end
return var1
