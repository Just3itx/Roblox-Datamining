-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T17:21:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new()
    local self = (setmetatable({}, module))
    self.min = Vector3.new(math.huge, math.huge, math.huge)
    self.max = Vector3.new(-math.huge, -math.huge, -math.huge)
    return self
end

function module.fromMinMax(vec1: vector, vec2: vector)
    local module2 = module.new()

    local tbl1 = {
        X = vec1.X,
        Y = vec1.Y,
        Z = vec1.Z
    }
    local tbl2 = {
        X = vec2.X,
        Y = vec2.Y,
        Z = vec2.Z
    }
    for _, value in { "X", "Y", "Z" } do
        if tbl2[value] ~= -math.huge and tbl1[value] ~= math.huge and tbl1[value] > tbl2[value] then
            local var1 = tbl1[value]
            tbl1[value] = tbl2[value]
            tbl2[value] = var1
        end
    end

    module2.min = Vector3.new(tbl1.X, tbl1.Y, tbl1.Z)
    module2.max = Vector3.new(tbl2.X, tbl2.Y, tbl2.Z)
    return module2
end

function module:unionExtents(arg1)
    local module2 = module.new()
    module2.min = self.min:Min(arg1.min)
    module2.max = self.max:Max(arg1.max)
    return module2
end

function module:intersectExtents(arg1)
    local tbl1 = {
        X = math.huge,
        Y = math.huge,
        Z = math.huge
    }
    local tbl2 = {
        X = -math.huge,
        Y = -math.huge,
        Z = -math.huge
    }

    for _, value in { "X", "Y", "Z" } do
        if self.max[value] < self.min[value] or arg1.max[value] < arg1.min[value] then
            continue
        end

        local num1 = math.max(self.min[value], arg1.min[value])
        local num2 = math.min(self.max[value], arg1.max[value])
        if num1 <= num2 then
            tbl1[value] = num1
            tbl2[value] = num2
        end
    end
    local module2 = module.new()
    module2.min = Vector3.new(tbl1.X, tbl1.Y, tbl1.Z)
    module2.max = Vector3.new(tbl2.X, tbl2.Y, tbl2.Z)
    return module2
end

function module:expandToInclude(vec1: vector)
    local module2 = module.new()
    module2.min = self.min:Min(vec1)
    module2.max = self.max:Max(vec1)
    return module2
end

function module:isValid()
    for _, value in { "X", "Y", "Z" } do
        if self.max[value] < self.min[value] then
            return false
        end
    end
    return true
end

function module:size()
    if self:isValid() then
        return self.max - self.min
    end

    return nil
end

function module:center()
    if self:isValid() then
        return (self.max + self.min) / 2
    end

    return nil
end

return module
