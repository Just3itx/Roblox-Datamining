-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:31:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {}
tbl1.__index = tbl1

function tbl1:ReadPixel(num1: number, num2: number)
    if self.size.X <= num1 or self.size.Y <= num2 or num1 < 0 or num2 < 0 then
        return Color3.fromRGB(0, 0, 0)
    end

    local offset = (num1 + num2 * self.size.X) * 4
    return Color3.fromRGB(
        buffer.readu8(self.buffer, offset),
        buffer.readu8(self.buffer, offset + 1),
        buffer.readu8(self.buffer, offset + 2)
    )
end

function tbl1.new(arg1)
    local self = (setmetatable({}, tbl1))
    self.buffer = arg1:ReadPixelsBuffer(Vector2.new(0, 0), arg1.Size)
    self.size = arg1.Size
    return self
end

local module = {}
module.__index = module

function module.new(vector2: Vector2, calculateWeightFromColor3: (...any) -> (...any))
    local self = (setmetatable({}, module))
    self.size = vector2
    self.calculateWeightFromColor3 = calculateWeightFromColor3
    self.buffer = buffer.create(vector2.X * vector2.Y * 4)
    return self
end

function module:ReadValue(num1: number, num2: number): number
    if num1 < 0 or num2 < 0 then
        return 0
    end
    num1 = math.min(num1, self.size.X - 1)
    local var1 = num1 + math.min(num2, self.size.Y - 1) * self.size.X
    return buffer.readu32(self.buffer, var1 * 4)
end

function module:WriteValue(num1: number, num2: number, num3: number)
    assert(num1 < self.size.X and num2 < self.size.Y and num1 >= 0 and num2 >= 0)

    local var1 = num1 + num2 * self.size.X
    buffer.writeu32(self.buffer, var1 * 4, num3)
end

function module:BuildSummedAreaTable(arg1)
    local var1 = tbl1.new(arg1)

    assert(var1.size == self.size)
    for i = 0, self.size.Y - 1 do
        for j = 0, self.size.X - 1 do
            local weightFromColor3 = self.calculateWeightFromColor3(var1:ReadPixel(j, i))
            local var2 = self:ReadValue(j - 1, i)
            local var3 = self:ReadValue(j, i - 1)
            local var4 = self:ReadValue(j - 1, i - 1)
            self:WriteValue(j, i, weightFromColor3 + var2 + var3 - var4)
        end
    end
end

function module:GetAreaDensity(vector2: Vector2, vector2_2: Vector2)
    local var1 = vector2 - Vector2.one
    local var2 = vector2 + vector2_2 - Vector2.one
    local vector2_3 = Vector2.new(var2.X, var1.Y)
    local vector2_4 = Vector2.new(var1.X, var2.Y)

    return self:ReadValue(var2.X, var2.Y) - self:ReadValue(vector2_3.X, vector2_3.Y) - self:ReadValue(vector2_4.X, vector2_4.Y) + self:ReadValue(var1.X, var1.Y)
end

function module.GetAreaDensityContinuous(tbl2, vector2: Vector2, vector2_2: Vector2)
    local num1 = 0

    local var1 = vector2 + vector2_2

    local vector2_3 = vector2:Ceil()
    local var2 = var1:Floor()
    local var3 = var2 - vector2_3
    if var3.X > 0 and var3.Y > 0 then
        num1 += tbl2:GetAreaDensity(vector2_3, var3)
    end

    local var4 = vector2_3 - vector2
    local var5 = var1 - var2

    if var3.Y > 0 then
        local vector2_4 = Vector2.new(1, var3.Y)
        if math.floor(vector2.X) < math.floor(var1.X) then
            local var6 = vector2_3 + Vector2.new(-1, 0)
            local x = var4.X
            local var7 = num1 + tbl2:GetAreaDensity(var6, vector2_4) * x
            local var8 = vector2_3 + Vector2.new(var3.X, 0)
            local x2 = var5.X
            num1 = var7 + tbl2:GetAreaDensity(var8, vector2_4) * x2
        else
            local var6 = var1.X - vector2.X
            num1 += tbl2:GetAreaDensity(vector2_3 + Vector2.new(-1, 0), vector2_4) * var6
        end
    end

    if var3.X > 0 then
        local vector2_4 = Vector2.new(var3.X, 1)
        if math.floor(vector2.Y) < math.floor(var1.Y) then
            local var6 = vector2_3 + Vector2.new(0, -1)
            local y = var4.Y
            local var7 = num1 + tbl2:GetAreaDensity(var6, vector2_4) * y
            local var8 = vector2_3 + Vector2.new(0, var3.Y)
            local y2 = var5.Y
            num1 = var7 + tbl2:GetAreaDensity(var8, vector2_4) * y2
        else
            local var6 = var1.Y - vector2.Y
            num1 += tbl2:GetAreaDensity(vector2_3 + Vector2.new(0, -1), vector2_4) * var6
        end
    end

    local var6 = math.min(vector2_3.X, var1.X) - vector2.X
    local var7 = math.min(vector2_3.Y, var1.Y) - vector2.Y
    local var8 = num1 + tbl2:GetAreaDensity(vector2:Floor(), Vector2.new(1, 1)) * var6 * var7

    if math.floor(vector2.X) < math.floor(var1.X) then
        local x = var5.X
        var8 += tbl2:GetAreaDensity(Vector2.new(var1.X, vector2.Y):Floor(), Vector2.new(1, 1)) * x * var7

        if math.floor(vector2.Y) < math.floor(var1.Y) then
            var8 += tbl2:GetAreaDensity(var1:Floor(), Vector2.new(1, 1)) * var5.X * var5.Y
        end
    end

    if math.floor(vector2.Y) < math.floor(var1.Y) then
        local y = var5.Y
        var8 += tbl2:GetAreaDensity(Vector2.new(vector2.X, var1.Y):Floor(), Vector2.new(1, 1)) * var6 * y
    end

    return var8
end

return module
