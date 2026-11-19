-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local Components = script.Parent.Parent.Parent.Components
local CellLabel = require(Components.CellLabel)
local BannerButton = require(Components.BannerButton)
local Tooltip = require(Components.Tooltip)

local _LuauHeapTypes = require(script.Parent.LuauHeapTypes)

local Constants = require(script.Parent.Parent.Parent.Constants)
local LineWidth = Constants.GeneralFormatting.LineWidth
local LineColor = Constants.GeneralFormatting.LineColor

local GraphEntryFrameHeight = Constants.LuauHeapFormatting.GraphEntryFrameHeight
local DepthIndent = Constants.LuauHeapFormatting.DepthIndent
local ValueCellWidth = Constants.LuauHeapFormatting.ValueCellWidth
local CellPadding = Constants.LuauHeapFormatting.CellPadding
local ValuePadding = Constants.LuauHeapFormatting.ValuePadding

local var1 = Roact.PureComponent:extend("LuauHeapViewEntry")

local function BorderedCellLabel(tbl1)
    return Roact.createFragment({
        Label = Roact.createElement(CellLabel, { text = tbl1.text, size = tbl1.size, pos = tbl1.pos, richText = true }),
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
        expandedEllipsis = false,
        showTooltip = false,
        tooltipPos = UDim2.fromOffset(0, 0)
    }

    function arg1.onButtonPress()
        arg1:setState(function(arg2)
            return {
                expanded = not arg2.expanded
            }
        end)
    end

    function arg1.onExpandEllipsis()
        arg1:setState({ expandedEllipsis = true })
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

function var1.renderChildren(tbl1, tbl2, tbl3)
    if not tbl1.state.expanded then
        return {}
    end

    if #tbl2 == 0 and (tbl3 == nil or #tbl3 == 0) then
        return {}
    end

    local result = ({})
    local totalSize = tbl1.props.data.TotalSize

    local depth = tbl1.props.depth + 1

    local num1 = 0
    local num2 = 0

    local num3 = 0

    local function getCompareInfo(arg1) -- Luacid: unused: defined but never referenced
        if tbl3 then
            for _, value in ipairs(tbl3) do
                if arg1.Name == value.Name then
                    return value
                end
            end
        end
        return nil
    end

    local var3

    for _, value in ipairs(tbl2) do
        local var4

        if tbl3 then
            var4 = false

            for _, value2 in ipairs(tbl3) do
                if value.Name == value2.Name then
                    var3 = value2
                    var4 = true
                    break
                end
            end
        else
            var4 = false
        end

        if not var4 then
            var3 = nil
        end

        if value.TotalSize <= 128 and #tbl2 > 4 and not tbl1.state.expandedEllipsis then
            num1 += value.TotalSize

            if var3 then
                num2 += var3.TotalSize
            end
        else
            num3 += 1

            local createElement = Roact.createElement
            local var5 = var1
            local tbl4 = {
                layoutOrder = totalSize - value.TotalSize,
                depth = depth,
                data = value,
                compare = var3
            }
            result[num3] = createElement(var5, tbl4)
        end
    end

    if num1 > 0 then
        num3 += 1

        result[num3] = Roact.createElement(var1, {
            layoutOrder = totalSize,
            depth = depth,
            data = {
                Size = num1,
                TotalSize = num1,
                Name = "...",
                Children = {}
            },
            compare = tbl3 and {
                Size = num2,
                TotalSize = num2,
                Name = "...",
                Children = {}
            } or nil,
            customButtonPress = tbl1.onExpandEllipsis
        })
    end

    if tbl3 then
        for _, compare in ipairs(tbl3) do
            local bool1 = false

            for _, value2 in ipairs(tbl2) do
                if value2.Name == compare.Name then
                    bool1 = true
                    break
                end
            end

            if bool1 then
                continue
            end

            local tbl4 = {
                Size = 0,
                TotalSize = 0,
                Name = compare.Name,
                Source = compare.Source,
                Children = {}
            }
            num3 += 1

            result[num3] = Roact.createElement(var1, { layoutOrder = totalSize, depth = depth, data = tbl4, compare = compare })
        end
    end

    return result
end

function var1.renderValues(_, arg1)
    local result = ({})
    local uDim2 = UDim2.new(ValueCellWidth, -ValuePadding, 0, GraphEntryFrameHeight)
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

    local var2 = props.size or UDim2.new(1, 0, 0, GraphEntryFrameHeight)
    local depth = props.depth
    local layoutOrder = props.layoutOrder or 0
    local inset = depth * DepthIndent

    local data = props.data
    local compare = props.compare
    local var4

    if compare and compare.TotalSize ~= data.TotalSize then
        var4 = string.format(
            "%d <font color=\"#%s\">(%s%d)</font>",
            data.TotalSize,
            if compare.TotalSize > data.TotalSize then "0f0" else "f00",
            if compare.TotalSize > data.TotalSize then "" else "+",
            data.TotalSize - compare.TotalSize
        )
    else
        var4 = string.format("%.0f", data.TotalSize)
    end

    local var5

    if compare and compare.Size ~= data.Size then
        var5 = string.format(
            "%d <font color=\"#%s\">(%s%d)</font>",
            data.Size,
            if compare.Size > data.Size then "0f0" else "f00",
            if compare.Size > data.Size then "" else "+",
            data.Size - compare.Size
        )
    else
        var5 = string.format("%.0f", data.Size)
    end

    local tbl1 = { var4, var5 }

    local text = (not data.Name or #data.Name == 0) and (if depth == 0 then "<root>" else "<anonymous>") or data.Name
    local var3 = if data.Source and #data.Source ~= 0 then data.Source else text
    local uDim = UDim.new(1 - ValueCellWidth * #tbl1, -(CellPadding + inset))

    local isExpandable = #data.Children ~= 0 or compare ~= nil and #compare.Children ~= 0 or props.customButtonPress ~= nil
    local onButtonPress = if props.customButtonPress then props.customButtonPress else arg1.onButtonPress
    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = var2,
        BackgroundTransparency = 1,
        LayoutOrder = layoutOrder,
        AutomaticSize = Enum.AutomaticSize.Y
    }
    local tbl3 = {
        tooltip = if arg1.state.showTooltip then Roact.createElement(Tooltip, { text = var3, pos = arg1.state.tooltipPos }) else nil,
        layout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        button = Roact.createElement(BannerButton, {
            size = UDim2.new(1, 0, 0, GraphEntryFrameHeight),
            inset = inset,
            isExpanded = arg1.state.expanded,
            isExpandable = isExpandable,
            onButtonPress = onButtonPress,
            onMouseEnter = arg1.onMouseEnter,
            onMouseLeave = arg1.onMouseLeave,
            onMouseMove = arg1.onMouseMove,
            layoutOrder = -1
        }, {
            name = Roact.createElement(CellLabel, {
                text = text,
                size = UDim2.new(uDim, UDim.new(1, 0)),
                pos = UDim2.new(0, CellPadding + inset, 0, 0),
                textTruncate = Enum.TextTruncate.SplitWord,
                textWrapped = false
            }),
            values = Roact.createFragment(arg1:renderValues(tbl1))
        }),
        children = 0
    }
    local createFragment = Roact.createFragment
    local children = data.Children
    local children2 = if compare then compare.Children else nil
    tbl3.children = createFragment(arg1:renderChildren(children, children2))
    return createElement(str1, tbl2, tbl3)
end

return var1
