-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")

local module = { SNAP_TOLERANCE_DEGREES = 0.5 }
module.__index = module

function module.normalizeAngle(num1: number): number
    return num1 % 360
end

function module.shortestDelta(num1: number, num2: number): number
    return (num2 - num1 + 180) % 360 - 180
end

function module.new(tbl1)
    return (setmetatable({
        angle = if tbl1 and tbl1.angle then tbl1.angle else 0,
        velocity = 0,
        isDragging = false,
        mode = "idle",
        snap = not tbl1 or tbl1.snap == nil or tbl1.snap,
        degreesPerPixel = if tbl1 and tbl1.degreesPerPixel then tbl1.degreesPerPixel else 0.5,
        _target = 0,
        _tween = nil,
        _samples = {},
        _lastX = 0
    }, module))
end

function module:dragStart(_lastX: number, time: number)
    self.isDragging = true
    self.mode = "idle"
    self._tween = nil
    self.velocity = 0
    self._lastX = _lastX
    self._samples = {{
        time = time,
        angle = self.angle
    }}
end

function module:dragMove(_lastX: number, time: number)
    if not self.isDragging then
        return
    end
    self.angle += (_lastX - self._lastX) * self.degreesPerPixel
    self._lastX = _lastX
    table.insert(self._samples, { time = time, angle = self.angle })
    while #self._samples > 2 and time - self._samples[1].time > 0.1 do
        table.remove(self._samples, 1)
    end
end

function module:dragEnd(num1: number)
    if not self.isDragging then
        return
    end
    self.isDragging = false
    local num2 = 1
    for i = #self._samples, 2, -1 do
        if self._samples[i].time - self._samples[i - 1].time > 0.05 then
            num2 = i
            break
        end
    end

    local var1 = self._samples[num2]
    local var2 = self._samples[#self._samples]

    local var3 = if var1 and var2 and var2.time - var1.time > 0.008 and num1 - var2.time < 0.08 then (var2.angle - var1.angle) / (var2.time - var1.time) else 0

    self:release(math.clamp(var3, -1440, 1440))
end

function module:release(velocity: number)
    self.velocity = velocity
    if self.snap then
        local var1 = self.angle + velocity / 4
        local _target = math.round(var1 / 90) * 90
        if math.abs(var1 - _target) <= 30 then
            self.mode = "spring"
            self._target = _target
            return
        end
    end
    self.mode = if math.abs(velocity) > 1 then "inertia" else "idle"
end

function module:tweenBy(num1: number, num2: number)
    self.isDragging = false
    self.velocity = 0
    self.mode = "tween"
    self._tween = {
        from = self.angle,
        to = self.angle + num1,
        elapsed = 0,
        duration = math.max(num2, 0.001)
    }
end

function module:update(num1: number): boolean
    if self.isDragging or self.mode == "idle" then
        return false
    end
    num1 = math.min(num1, 0.1)
    local angle = self.angle
    if self.mode == "inertia" then
        local num2 = math.exp(num1 * -4)
        self.angle += self.velocity * (1 - num2) / 4
        self.velocity *= num2
        if math.abs(self.velocity) < 6 then
            self.velocity = 0
            self.mode = "idle"
        end
    elseif self.mode == "spring" then
        while num1 > 1e-6 do
            local num2 = math.min(num1, 1 / 240)
            local var1 = -90 * (self.angle - self._target) - 18.973665961010276 * self.velocity
            self.velocity += var1 * num2
            self.angle += self.velocity * num2
            num1 -= num2
        end

        if math.abs(self.angle - self._target) < 0.05 and math.abs(self.velocity) < 0.5 then
            self.angle = self._target
            self.velocity = 0
            self.mode = "idle"
        end
    elseif self.mode == "tween" then
        local _tween = self._tween
        _tween.elapsed += num1
        local alpha = math.clamp(_tween.elapsed / _tween.duration, 0, 1)
        local angle2 = self.angle
        self.angle = _tween.from + (_tween.to - _tween.from) * TweenService:GetValue(alpha, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut)
        self.velocity = if num1 > 0 then (self.angle - angle2) / num1 else 0
        if alpha >= 1 then
            self.angle = _tween.to
            self.velocity = 0
            self.mode = "idle"
            self._tween = nil
        end
    end
    return self.angle ~= angle
end

function module:isSettled(): boolean
    return not self.isDragging and self.mode == "idle"
end

return module
