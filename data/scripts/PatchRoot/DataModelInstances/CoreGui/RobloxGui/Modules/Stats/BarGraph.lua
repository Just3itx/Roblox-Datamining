-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")

local StatsUtils = require(CoreGui.RobloxGui.Modules.Stats.StatsUtils)

local module = {}
module.__index = module

function module.new(_showExtras)
    local result = {}
    setmetatable(result, module)

    result._barFrame = Instance.new("Frame")
    result._barFrame.Name = "PS_BarFrame"
    result._barFrame.BackgroundTransparency = 1

    result._lineFrame = Instance.new("Frame")
    result._lineFrame.Name = "PS_LineFrame"
    result._lineFrame.BackgroundTransparency = 1

    result._showExtras = _showExtras

    result._values = {}
    result._bars = {}

    result._average = 0

    result._target = 0

    if result._showExtras then
        result:_addGraphTarget()
        result:_addGraphAverage()
    end

    return result
end

function module:SetZIndex(zIndex)
    self._barFrame.ZIndex = zIndex
    self._lineFrame.ZIndex = zIndex + 1
    if self._showExtras then
        self._targetLine.ZIndex = self._lineFrame.ZIndex
        self._averageLine.ZIndex = self._lineFrame.ZIndex
    end
end

function module:PlaceInParent(arg1, size, position)
    self._barFrame.Position = position
    self._barFrame.Size = size
    self._barFrame.Parent = arg1
    self._lineFrame.Position = position
    self._lineFrame.Size = size
    self._lineFrame.Parent = arg1
end

function module.SetAxisMax(arg1, _axisMax)
    arg1._axisMax = _axisMax
end

function module:SetValues(_values)
    self._values = _values
end

function module:SetAverage(_average)
    self._average = _average
end

function module:SetTarget(_target)
    self._target = _target
    self:_moveGraphTarget()
end

function module:_updateBarCount(arg1)
    local _bars = {}
    local _barsLen = #self._bars

    for i = 1, _barsLen do
        if i <= _barsLen then
            table.insert(_bars, self._bars[i])
        else
            self._bars[i].Destroy()
        end
    end

    for i = _barsLen + 1, arg1 do
        table.insert(_bars, self:_makeNthBar(i))
    end

    self._bars = _bars
end

function module:Render()
    local _valuesLen = #self._values

    self:_updateBarCount(_valuesLen)

    for i, value in ipairs(self._values) do
        self:_updateBar(i, value, _valuesLen)
    end

    if self._showExtras then
        self:_moveGraphAverage()
    end
end

function module:_addGraphTarget()
    local targetLine = Instance.new("ImageLabel")
    targetLine.Name = "TargetLine"
    targetLine.Size = UDim2.new(1, 0, 0, StatsUtils.GraphTargetLineInnerThickness)

    targetLine.Image = "rbxasset://textures/ui/PerformanceStats/TargetLine.png"
    targetLine.BackgroundTransparency = 1
    targetLine.Parent = self._lineFrame
    targetLine.ZIndex = self._lineFrame.ZIndex
    targetLine.BorderSizePixel = 0

    targetLine.Changed:connect(function()
        self:_updateTargetLineImageSize()
    end)

    self._targetLine = targetLine
    self:_updateTargetLineImageSize()
end

function module:_updateTargetLineImageSize()
    self._targetLine.ImageRectSize = self._targetLine.AbsoluteSize
end

function module:_addGraphAverage()
    local averageLine = Instance.new("Frame")
    averageLine.Name = "AverageLine"
    averageLine.Size = UDim2.new(1, 0, 0, StatsUtils.GraphAverageLineInnerThickness)

    averageLine.Parent = self._lineFrame
    averageLine.ZIndex = self._lineFrame.ZIndex

    StatsUtils.StyleAverageLine(averageLine)

    self._averageLine = averageLine
end

function module:_moveGraphTarget()
    if self._targetLine == nil then
        return
    end
    self._targetLine.Position = UDim2.new(0, 0, (self._axisMax - self._target) / self._axisMax, -StatsUtils.GraphTargetLineInnerThickness / 2)
end

function module:_moveGraphAverage()
    if self._averageLine == nil then
        return
    end

    local num1 = math.min(self._average, self._axisMax)

    self._averageLine.Position = UDim2.new(0, 0, (self._axisMax - num1) / self._axisMax, -StatsUtils.GraphAverageLineTotalThickness / 2)
end

function module:_makeNthBar(arg1): Frame
    local var1 = arg1 - 1
    local frame = Instance.new("Frame")
    frame.Name = string.format("Bar_%d", var1)
    frame.Parent = self._barFrame
    frame.ZIndex = self._barFrame.ZIndex
    frame.BorderSizePixel = 0
    return frame
end

function module:_updateBar(arg1, arg2, arg3)
    local _bar = self._bars[arg1]
    local var1 = arg1 - 1

    local num1 = math.max(0, math.min(arg2, self._axisMax))

    _bar.Position = UDim2.new(var1 / arg3, 0, (self._axisMax - num1) / self._axisMax, 0)
    _bar.Size = UDim2.new(1 / arg3, 0, num1 / self._axisMax, 0)

    _bar.BackgroundColor3 = StatsUtils.GetColorForValue(arg2, self._target)
end

return module
