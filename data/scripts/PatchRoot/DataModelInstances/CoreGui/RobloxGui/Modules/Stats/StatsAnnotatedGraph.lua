-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local BarGraph = require(CoreGui.RobloxGui.Modules.Stats.BarGraph)

local module = {}
module.__index = module

function module.new(_statType, _isMaximized)
    local result = {}
    setmetatable(result, module)

    result._statType = _statType
    result._statMaxName = StatsUtils.StatMaxNames[_statType]
    result._isMaximized = _isMaximized

    result._values = {}

    result._average = 0

    result._target = 0

    result._axisMax = 0

    result._frame = Instance.new("Frame")
    result._frame.Name = "PS_AnnotatedGraph"
    result._frame.BackgroundTransparency = 1
    result._frame.ZIndex = StatsUtils.GraphZIndex

    result._topLabel = Instance.new("TextLabel")
    result._topLabel.Name = "PS_TopAxisLabel"
    result._topLabel.Parent = result._frame
    result._topLabel.TextXAlignment = Enum.TextXAlignment.Left
    result._topLabel.TextYAlignment = Enum.TextYAlignment.Top
    result._topLabel.FontSize = StatsUtils.PanelGraphFontSize

    result._bottomLabel = Instance.new("TextLabel")
    result._bottomLabel.Name = "PS_BottomAxisLabel"
    result._bottomLabel.Parent = result._frame
    result._bottomLabel.TextXAlignment = Enum.TextXAlignment.Left
    result._bottomLabel.TextYAlignment = Enum.TextYAlignment.Bottom
    result._bottomLabel.FontSize = StatsUtils.PanelGraphFontSize

    result._graph = BarGraph.new(_isMaximized)

    StatsUtils.StyleTextWidget(result._topLabel)
    StatsUtils.StyleTextWidget(result._bottomLabel)

    result:_layoutElements()

    return result
end

function module:SetZIndex(zIndex)
    self._frame.ZIndex = zIndex
    self._topLabel.ZIndex = zIndex
    self._bottomLabel.ZIndex = zIndex
    self._graph:SetZIndex(zIndex)
end

function module:_layoutElements()
    local xOffset

    if self._isMaximized then
        self._topLabel.Visible = true
        self._bottomLabel.Visible = true
        xOffset = 30
    else
        self._topLabel.Visible = false
        self._bottomLabel.Visible = false
        xOffset = 0
    end

    local uDim2 = UDim2.new(0, 10, 0, 10)
    local uDim2_2 = UDim2.new(1, -(20 + xOffset), 1, -20)

    local uDim2_3 = UDim2.new(1, -(10 + xOffset), 0, 10)
    local uDim2_4 = UDim2.new(0, xOffset, 0.333, -20)
    local uDim2_5 = UDim2.new(1, -(10 + xOffset), 0.666, 10)
    local uDim2_6 = UDim2.new(0, xOffset, 0.333, -20)

    self._topLabel.Size = uDim2_4
    self._topLabel.Position = uDim2_3
    self._bottomLabel.Size = uDim2_6
    self._bottomLabel.Position = uDim2_5

    self._graph:PlaceInParent(self._frame, uDim2_2, uDim2)
end

function module:PlaceInParent(arg1, size, position)
    self._frame.Position = position
    self._frame.Size = size
    self._frame.Parent = arg1
end

function module:_getTarget()
    if self._performanceStats == nil then
        return 0
    end

    local var1 = self._performanceStats:FindFirstChild(self._statMaxName)
    if var1 == nil then
        return 0
    end

    return var1:GetValue()
end

function module:_render()
    self._graph:SetAxisMax(self._axisMax)
    self._graph:SetValues(self._values)

    self._graph:SetAverage(self._average)
    self._graph:SetTarget(self._target)
    self._graph:Render()

    self._topLabel.Text = string.format("%.2f", self._axisMax)
    self._bottomLabel.Text = string.format("%.2f", 0)
end

function module:_calculateAxisMax()
    local var1 = self._target * 2
    local var2 = self:_recursiveGetOrderOfMagnitude(1, var1)
    self._axisMax = math.floor(0.5 + var1 / var2) * var2
end

function module.SetStatsAggregator(arg1, _aggregator)
    if arg1._aggregator then
        arg1._aggregator:RemoveListener(arg1._listenerId)
        arg1._listenerId = nil
        arg1._aggregator = nil
    end

    arg1._aggregator = _aggregator

    arg1:_refreshVisibility()
end

function module:_stopListening()
    if self._aggregator ~= nil and self._listenerId ~= nil then
        self._aggregator:RemoveListener(self._listenerId)
        self._listenerId = nil
    end
end

function module:_startListening()
    if self._aggregator ~= nil and self._listenerId == nil then
        self._listenerId = self._aggregator:AddListener(function()
            self:_updateValuesAndRender()
        end)
    end
end

function module:_shouldBeVisible()
    return if StatsUtils.PerformanceStatsShouldBeVisible() then self._frame.Visible else false
end

function module:SetVisible(visible)
    self._frame.Visible = visible
    self:_refreshVisibility()
end

function module:_refreshVisibility()
    if self:_shouldBeVisible() then
        self:_startListening()
        self:_updateValuesAndRender()
        return
    end
    self:_stopListening()
end

function module.OnPerformanceStatsShouldBeVisibleChanged(arg1)
    arg1:_refreshVisibility()
end

function module:_recursiveGetOrderOfMagnitude(arg1, arg2)
    if arg2 < arg1 then
        return self:_recursiveGetOrderOfMagnitude(arg1 / 10, arg2)
    elseif arg2 <= arg1 * 10 then
        return arg1
    end

    return self:_recursiveGetOrderOfMagnitude(arg1 * 10, arg2)
end

function module:_updateValuesAndRender()
    self._values = {}
    self._average = 0
    self._target = 0
    if self._aggregator ~= nil then
        self._values = self._aggregator:GetValues()
        self._average = self._aggregator:GetAverage()
        self._target = self._aggregator:GetTarget()
    end

    self:_calculateAxisMax()
    self:_render()
end

return module
