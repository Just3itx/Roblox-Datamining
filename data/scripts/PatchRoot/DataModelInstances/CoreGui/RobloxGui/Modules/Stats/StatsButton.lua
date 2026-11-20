-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local StyleWidgets = require(CoreGui.RobloxGui.Modules.StyleWidgets)
local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local StatsMiniTextPanel = require(CoreGui.RobloxGui.Modules.Stats.StatsMiniTextPanel)
local StatsAnnotatedGraph = require(CoreGui.RobloxGui.Modules.Stats.StatsAnnotatedGraph)

local uDim2 = UDim2.new(0, 0, 0, 0)
local uDim2_2 = UDim2.new(0.5, 0, 1, -StyleWidgets.TabSelectionHeight)
local uDim2_3 = UDim2.new(0.5, 0, 0, 0)
local uDim2_4 = UDim2.new(0.5, 0, 1, -StyleWidgets.TabSelectionHeight)

local module = {}
module.__index = module

function module.new(_statType)
    local result = {}
    setmetatable(result, module)

    result._statType = _statType
    result._button = Instance.new("TextButton")
    result._button.Name = "PS_Button"
    result._button.Text = ""

    StatsUtils.StyleButton(result._button)

    result._textPanel = StatsMiniTextPanel.new(_statType)
    result._textPanel:PlaceInParent(result._button, uDim2_2, uDim2)

    result._graph = StatsAnnotatedGraph.new(_statType, false)
    result._graph:PlaceInParent(result._button, uDim2_4, uDim2_3)

    result._textPanel:SetZIndex(StatsUtils.TextZIndex)
    result._graph:SetZIndex(StatsUtils.GraphZIndex)

    result._tabSelection = StyleWidgets.MakeTabSelectionWidget(result._button)

    result._isSelected = false

    result:_updateTabSelectionState()

    return result
end

function module:OnPerformanceStatsShouldBeVisibleChanged()
    if self._graph then
        self._graph:OnPerformanceStatsShouldBeVisibleChanged()
    end

    if self._textPanel then
        self._textPanel:OnPerformanceStatsShouldBeVisibleChanged()
    end
end

function module:SetToggleCallbackFunction(callback)
    self._button.MouseButton1Click:connect(function()
        callback(self._statType)
    end)
end

function module:SetSizeAndPosition(size, position)
    self._button.Size = size
    self._button.Position = position
end

function module:SetIsSelected(_isSelected)
    self._isSelected = _isSelected
    self:_updateTabSelectionState()
end

function module:_updateTabSelectionState()
    self._tabSelection.Visible = self._isSelected
end

function module:SetParent(arg1)
    self._button.Parent = arg1
end

function module:SetStatsAggregator(arg1)
    self._textPanel:SetStatsAggregator(arg1)
    self._graph:SetStatsAggregator(arg1)
end

return module
