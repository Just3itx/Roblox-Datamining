-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:50:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local _CorePackages = game:GetService("CorePackages")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)
local _StatsAggregator = require(CoreGui.RobloxGui.Modules.Stats.StatsAggregator)
local DecoratedValueLabel = require(CoreGui.RobloxGui.Modules.Stats.DecoratedValueLabel)

local TextPanelTopMarginPix = StatsUtils.TextPanelTopMarginPix
local uDim2 = UDim2.new(0, StatsUtils.TextPanelLeftMarginPix, 0, TextPanelTopMarginPix)

local yOffset = TextPanelTopMarginPix + StatsUtils.TextPanelTitleHeightY
local uDim2_2 = UDim2.new(0, StatsUtils.TextPanelLeftMarginPix, 0, yOffset)

local yOffset2 = yOffset + StatsUtils.TextPanelLegendItemHeightY
local uDim2_3 = UDim2.new(0, StatsUtils.TextPanelLeftMarginPix, 0, yOffset2)

local yOffset3 = yOffset2 + StatsUtils.TextPanelLegendItemHeightY
local uDim2_4 = UDim2.new(0, StatsUtils.TextPanelLeftMarginPix, 0, yOffset3)

local uDim2_5 = UDim2.new(1, -StatsUtils.TextPanelLeftMarginPix * 2, 0, StatsUtils.TextPanelTitleHeightY)
local uDim2_6 = UDim2.new(1, -StatsUtils.TextPanelLeftMarginPix * 2, 0, StatsUtils.TextPanelLegendItemHeightY)

local module = {}
module.__index = module

function module.new(_statType)
    local result = {}
    setmetatable(result, module)

    result._statType = _statType

    result._frame = Instance.new("Frame")
    result._frame.BackgroundTransparency = 1
    result._frame.ZIndex = StatsUtils.TextZIndex

    result._titleLabel = Instance.new("TextLabel")

    StatsUtils.StyleTextWidget(result._titleLabel)

    result._titleLabel.FontSize = StatsUtils.PanelTitleFontSize
    result._titleLabel.Text = result:_getTitle()

    result._titleLabel.Parent = result._frame
    result._titleLabel.Size = uDim2_5
    result._titleLabel.Position = uDim2
    result._titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    result._titleLabel.TextYAlignment = Enum.TextYAlignment.Top

    result:_addCurrentValueWidget()

    result:_addTargetValueWidget()

    result:_addAverageValueWidget()

    return result
end

function module._getTarget(arg1)
    if arg1._performanceStats == nil then
        return 0
    end

    local var1 = arg1._performanceStats:FindFirstChild(arg1._statMaxName)
    if var1 == nil then
        return 0
    end

    return var1:GetValue()
end

function module:_addCurrentValueWidget()
    self._currentValueWidget = DecoratedValueLabel.new(self._statType, "Current")

    self._currentValueWidget:PlaceInParent(self._frame, uDim2_6, uDim2_2)

    local decorationFrame = self._currentValueWidget:GetDecorationFrame()
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Position = UDim2.new(0.5, -StatsUtils.OvalKeySize / 2, 0.5, -StatsUtils.OvalKeySize / 2)
    imageLabel.Size = UDim2.new(0, StatsUtils.OvalKeySize, 0, StatsUtils.OvalKeySize)

    imageLabel.Parent = decorationFrame
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = "rbxasset://textures/ui/PerformanceStats/OvalKey.png"
    imageLabel.BorderSizePixel = 0
    self._currentValueDecoration = imageLabel
end

function module:_addTargetValueWidget()
    self._targetValueWidget = DecoratedValueLabel.new(self._statType, "Target")

    self._targetValueWidget:PlaceInParent(self._frame, uDim2_6, uDim2_3)

    local decorationFrame = self._targetValueWidget:GetDecorationFrame()
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Position = UDim2.new(0.5, -StatsUtils.TargetKeyWidth / 2, 0.5, -StatsUtils.TargetKeyHeight / 2)
    imageLabel.Size = UDim2.new(0, StatsUtils.TargetKeyWidth, 0, StatsUtils.TargetKeyHeight)

    imageLabel.Parent = decorationFrame
    imageLabel.BackgroundTransparency = 1
    imageLabel.Image = "rbxasset://textures/ui/PerformanceStats/TargetKey.png"
end

function module:_addAverageValueWidget()
    self._averageValueWidget = DecoratedValueLabel.new(self._statType, "Average")

    self._averageValueWidget:PlaceInParent(self._frame, uDim2_6, uDim2_4)

    local decorationFrame = self._averageValueWidget:GetDecorationFrame()

    local frame = Instance.new("Frame")
    frame.Position = UDim2.new(0, 0, 0.5, -StatsUtils.GraphAverageLineTotalThickness / 2)
    frame.Size = UDim2.new(1, 0, 0, StatsUtils.GraphAverageLineInnerThickness)
    frame.Parent = decorationFrame

    StatsUtils.StyleAverageLine(frame)
end

function module:_getTitle()
    return StatsUtils.TypeToName[self._statType]
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

function module:SetVisible(visible)
    self._frame.Visible = visible
    self:_refreshVisibility()
end

function module:_shouldBeVisible()
    return if StatsUtils.PerformanceStatsShouldBeVisible() then self._frame.Visible else false
end

function module:_refreshVisibility()
    if self:_shouldBeVisible() then
        self:_startListening()
        self:_updateFromAggregator()
        return
    end
    self:_stopListening()
end

function module.OnPerformanceStatsShouldBeVisibleChanged(arg1)
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
            self:_updateFromAggregator()
        end)
    end
end

function module:_updateFromAggregator()
    local latestValue, target, average

    if self._aggregator == nil then
        latestValue = 0
        target = 0
        average = 0
    else
        latestValue = self._aggregator:GetLatestValue()
        average = self._aggregator:GetAverage()
        target = self._aggregator:GetTarget()
    end

    self._currentValueWidget:SetValue(latestValue)
    self._targetValueWidget:SetValue(target)
    self._averageValueWidget:SetValue(average)

    self._currentValueDecoration.ImageColor3 = StatsUtils.GetColorForValue(latestValue, target)
end

function module:SetZIndex(zIndex)
    self._frame.ZIndex = zIndex
    self._titleLabel.ZIndex = zIndex
    self._currentValueWidget:SetZIndex(zIndex)
    self._averageValueWidget:SetZIndex(zIndex)
end

return module
