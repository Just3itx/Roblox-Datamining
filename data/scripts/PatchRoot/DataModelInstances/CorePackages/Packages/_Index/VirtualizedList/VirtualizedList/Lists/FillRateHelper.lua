-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local console = LuauPolyfill.console
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object

local tbl1 = {}
tbl1.__index = tbl1
function tbl1.new()
    local self = (setmetatable({}, tbl1))
    self.any_blank_count = 0
    self.any_blank_ms = 0
    self.any_blank_speed_sum = 0
    self.mostly_blank_count = 0
    self.mostly_blank_ms = 0
    self.pixels_blank = 0
    self.pixels_sampled = 0
    self.pixels_scrolled = 0
    self.total_time_spent = 0
    self.sample_count = 0
    return self
end

local tbl2 = {}
local num1 = 10
local var1 = nil

local module = {}
module.__index = module

function module.new(_getFrameMetrics: (...any) -> (...any))
    local self = (setmetatable({}, module))
    self._anyBlankStartTime = nil
    self._enabled = false
    self._info = tbl1.new()
    self._mostlyBlankStartTime = nil
    self._samplesStartTime = nil
    self._getFrameMetrics = _getFrameMetrics
    if var1 then
        self._enabled = var1 > math.random()
    else
        self._enabled = math.random() < 0
    end
    self:_resetData()
    return self
end

function module.addListener(func1: (...any) -> (...any))
    if var1 == nil then
        console.warn("Call `FillRateHelper.setSampleRate` before `addListener`.")
    end
    table.insert(tbl2, func1)
    return {
        remove = function()
            tbl2 = Array.filter(tbl2, function(arg1): boolean
                return func1 ~= arg1
            end)
        end
    }
end

function module.setSampleRate(num2: number)
    var1 = num2
end

function module.setMinSampleCount(num2: number)
    num1 = num2
end

function module:activate()
    if self._enabled and self._samplesStartTime == nil then
        self._samplesStartTime = os.clock()
    end
end

function module:deactivateAndFlush()
    if not self._enabled then
        return
    end
    local _samplesStartTime = self._samplesStartTime
    if _samplesStartTime == nil then
        return
    end

    if self._info.sample_count < num1 then
        self:_resetData()
        return
    end

    local totalTimeSpent = os.clock() - _samplesStartTime
    local var3 = Object.assign({}, self._info, { total_time_spent = totalTimeSpent })

    Array.forEach(tbl2, function(arg1)
        return arg1(var3)
    end)
    self:_resetData()
end

function module:computeBlankness(tbl3, tbl4, tbl5)
    if not self._enabled or tbl3.getItemCount(tbl3.data) == 0 or self._samplesStartTime == nil then
        return 0
    end

    local dOffset = tbl5.dOffset
    local offset = tbl5.offset
    local velocity = tbl5.velocity
    local visibleLength = tbl5.visibleLength

    local _info = self._info
    _info.sample_count += 1
    local _info2 = self._info
    _info2.pixels_sampled += math.round(visibleLength)
    local _info3 = self._info
    _info3.pixels_scrolled += math.round(math.abs(dOffset or 0))
    local num2 = math.round(math.abs(velocity or 0) * 1000)

    local num3 = os.clock() * 1000
    if self._anyBlankStartTime ~= nil then
        local _info4 = self._info
        _info4.any_blank_ms += num3 - self._anyBlankStartTime
    end
    self._anyBlankStartTime = nil
    if self._mostlyBlankStartTime ~= nil then
        local _info4 = self._info
        _info4.mostly_blank_ms += num3 - self._mostlyBlankStartTime
    end
    self._mostlyBlankStartTime = nil

    local first = tbl4.first
    local var2 = self._getFrameMetrics(first)
    local num4 = 0

    while first <= tbl4.last and not (var2 and var2.inLayout) do
        var2 = self._getFrameMetrics(first)
        first += 1
    end

    if var2 and first > 1 then
        num4 = math.min(visibleLength, math.max(0, var2.offset - offset))
    end

    local last = tbl4.last
    local var3 = self._getFrameMetrics(last)
    local num5 = 0

    while tbl4.first <= last and not (var3 and var3.inLayout) do
        var3 = self._getFrameMetrics(last)
        last -= 1
    end

    if var3 and last < tbl3.getItemCount(tbl3.data) then
        local var4 = var3.offset + var3.length
        num5 = math.min(visibleLength, math.max(0, offset + visibleLength - var4))
    end
    local num6 = math.round(num4 + num5)
    local var4 = num6 / visibleLength
    if var4 > 0 then
        self._anyBlankStartTime = num3
        local _info4 = self._info
        _info4.any_blank_speed_sum += num2
        local _info5 = self._info
        _info5.any_blank_count += 1
        local _info6 = self._info
        _info6.pixels_blank += num6
        if var4 > 0.5 then
            self._mostlyBlankStartTime = num3
            local _info7 = self._info
            _info7.mostly_blank_count += 1
            return var4
        end
    elseif num2 < 0.01 or math.abs(dOffset or 0) < 1 then
        self:deactivateAndFlush()
    end
    return var4
end

function module:enabled()
    return self._enabled
end

function module:_resetData()
    self._anyBlankStartTime = nil
    self._info = tbl1.new()
    self._mostlyBlankStartTime = nil
    self._samplesStartTime = nil
end

return module
