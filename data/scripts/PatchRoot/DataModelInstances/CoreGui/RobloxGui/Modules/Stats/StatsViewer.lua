-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local StatsTextPanel = require(CoreGui.RobloxGui.Modules.Stats.StatsTextPanel)
local StatsAnnotatedGraph = require(CoreGui.RobloxGui.Modules.Stats.StatsAnnotatedGraph)

local uDim2 = UDim2.new(0, 0, 0, 0)
local uDim2_2 = UDim2.new(0.4, 0, 1, 0)
local uDim2_3 = UDim2.new(0.4, 0, 0, 0)
local uDim2_4 = UDim2.new(0.6, 0, 1, 0)

local module = {}
module.__index = module

function module.new()
    local result = {}
    setmetatable(result, module)

    result._frameImageLabel = Instance.new("ImageLabel")
    result._frameImageLabel.Name = "PS_Viewer"
    result._frameImageLabel.Image = "rbxasset://textures/ui/PerformanceStats/BackgroundRounded.png"
    result._frameImageLabel.ScaleType = Enum.ScaleType.Slice
    result._frameImageLabel.SliceCenter = Rect.new(10, 10, 22, 22)
    result._frameImageLabel.BackgroundTransparency = 1
    result._frameImageLabel.ImageColor3 = StatsUtils.NormalColor
    result._frameImageLabel.ImageTransparency = StatsUtils.Transparency

    result._textPanel = nil
    result._statType = nil
    result._graph = nil

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

function module:GetIsVisible()
    return self._frameImageLabel.Visible
end

function module:GetStatType()
    return self._statType
end

function module:SetSizeAndPosition(size, position)
    self._frameImageLabel.Size = size
    self._frameImageLabel.Position = position
end

function module:SetParent(arg1)
    self._frameImageLabel.Parent = arg1
end

function module:SetVisible(visible)
    self._frameImageLabel.Visible = visible

    if self._graph then
        self._graph:SetVisible(visible)
    end

    if self._textPanel then
        self._textPanel:SetVisible(visible)
    end
end

function module:SetStatType(_statType)
    self._statType = _statType
    self._frameImageLabel:ClearAllChildren()

    if self._textPanel then
        self._textPanel:SetVisible(false)
        self._textPanel = nil
    end

    self._textPanel = StatsTextPanel.new(_statType)
    self._textPanel:PlaceInParent(self._frameImageLabel, uDim2_2, uDim2)

    self._graph = StatsAnnotatedGraph.new(_statType, true)
    self._graph:PlaceInParent(self._frameImageLabel, uDim2_4, uDim2_3)

    self._textPanel:SetZIndex(StatsUtils.TextZIndex)
    self._graph:SetZIndex(StatsUtils.GraphZIndex)

    self._graph:SetVisible(self._frameImageLabel.Visible)
    self._textPanel:SetVisible(self._frameImageLabel.Visible)

    self:_applyStatsAggregator()
end

function module:_applyStatsAggregator()
    if self._aggregator == nil then
        return
    end

    if self._textPanel then
        self._textPanel:SetStatsAggregator(self._aggregator)
    end
    if self._graph then
        self._graph:SetStatsAggregator(self._aggregator)
    end
end

function module.SetStatsAggregator(arg1, _aggregator)
    arg1._aggregator = _aggregator
    arg1:_applyStatsAggregator()
end

return module
