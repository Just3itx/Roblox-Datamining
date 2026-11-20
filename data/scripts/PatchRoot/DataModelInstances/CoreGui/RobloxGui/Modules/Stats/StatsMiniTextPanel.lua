-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local uDim2 = UDim2.new(0, 10, 0.15, 0)
local uDim2_2 = UDim2.new(1, -20, 0.4, 0)
local uDim2_3 = UDim2.new(0, 10, 0.55, 0)
local uDim2_4 = UDim2.new(1, -20, 0.3, 0)

local CoreGui = game:GetService("CoreGui")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local _StatsAggregator = require(CoreGui.RobloxGui.Modules.Stats.StatsAggregator)

local module = {}
module.__index = module

function module.new(_statType)
    local result = {}
    setmetatable(result, module)

    result._statType = _statType

    result._frame = Instance.new("Frame")
    result._frame.Name = "StatsMiniTextPanelClass"

    result._frame.BackgroundTransparency = 1
    result._frame.ZIndex = StatsUtils.TextZIndex

    result._titleLabel = Instance.new("TextLabel")
    result._titleLabel.Name = "TitleLabel"
    result._valueLabel = Instance.new("TextLabel")
    result._valueLabel.Name = "ValueLabel"

    StatsUtils.StyleTextWidget(result._titleLabel)
    StatsUtils.StyleTextWidget(result._valueLabel)

    result._titleLabel.FontSize = StatsUtils.MiniPanelTitleFontSize
    result._titleLabel.Text = result:_getTitle()
    result._titleLabel.Parent = result._frame
    result._titleLabel.Size = uDim2_2
    result._titleLabel.Position = uDim2
    result._titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    result._valueLabel.FontSize = StatsUtils.MiniPanelValueFontSize
    result._valueLabel.Text = "0"
    result._valueLabel.Parent = result._frame
    result._valueLabel.Size = uDim2_4
    result._valueLabel.Position = uDim2_3
    result._valueLabel.TextXAlignment = Enum.TextXAlignment.Left

    return result
end

function module:SetZIndex(zIndex)
    self._frame.ZIndex = zIndex
    self._titleLabel.ZIndex = zIndex
    self.ZIndex = zIndex
end

function module:_getTitle()
    return StatsUtils.TypeToShortName[self._statType]
end

function module:PlaceInParent(arg1, size, position)
    self._frame.Position = position
    self._frame.Size = size
    self._frame.Parent = arg1
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

function module.SetVisible(arg1, visible)
    arg1.frame.Visible = visible
    arg1:_refreshVisibility()
end

function module:_shouldBeVisible()
    return if StatsUtils.PerformanceStatsShouldBeVisible() then self._frame.Visible else false
end

function module._refreshVisibility(arg1)
    if arg1:_shouldBeVisible() then
        arg1:_startListening()
        arg1:_updateFromAggregator()
        return
    end
    arg1:_stopListening()
end

function module._stopListening(arg1)
    if arg1._aggregator ~= nil and arg1._listenerId ~= nil then
        arg1._aggregator:RemoveListener(arg1._listenerId)
        arg1._listenerId = nil
    end
end

function module._startListening(arg1)
    if arg1._aggregator ~= nil and arg1._listenerId == nil then
        arg1._listenerId = arg1._aggregator:AddListener(function()
            arg1:_updateFromAggregator()
        end)
    end
end

function module.OnPerformanceStatsShouldBeVisibleChanged(arg1)
    arg1:_refreshVisibility()
end

function module:_updateFromAggregator()
    local var1 = if self._aggregator == nil then 0 else self._aggregator:GetLatestValue()

    self._valueLabel.Text = StatsUtils.FormatTypedValue(var1, self._statType)
end

return module
