-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}
module.__index = module

function module.new(maxSize: number)
    local tbl1 = {
        levels = { table.create(maxSize) },
        weightedSketch = {
            weightTuples = {},
            totalWeight = 0,
            cached = false
        },
        maxSize = 0
    }

    if maxSize % 2 ~= 0 then
        maxSize -= 1
    end

    tbl1.maxSize = maxSize

    return (setmetatable(tbl1, module))
end

function module:insert(num1: number)
    self.weightedSketch.cached = false

    local levels = self.levels
    table.insert(levels[1], num1)

    for k, level in levels do
        if #level >= self.maxSize then
            compressWeightedKll(levels, k)
        end
    end
end

function compressWeightedKll(levels, num1: number)
    local level = levels[num1]
    table.sort(level)

    local var1 = table.create(#level // 2)

    for i = 1, #level, 2 do
        table.insert(var1, level[math.random(2) - 1 + i])
    end

    if num1 == #levels then
        table.insert(levels, var1)
    else
        table.move(var1, 1, #var1, #levels[num1 + 1] + 1, levels[num1 + 1])
    end

    table.clear(levels[num1])
end

function module:generateWeightedSketch()
    local weightTuples = {}
    local num1 = 1
    local num2 = 0

    for _, level in self.levels do
        for _, value in level do
            table.insert(weightTuples, { value = value, weight = num1 })

            num2 += num1
        end
        num1 *= 2
    end

    table.sort(weightTuples, function(arg1, arg2): boolean
        return arg1.value < arg2.value
    end)

    self.weightedSketch = { weightTuples = weightTuples, totalWeight = num2, cached = true }
end

function module:getPercentile(num1: number)
    if not self.weightedSketch.cached then
        self:generateWeightedSketch()
    end

    if #self.weightedSketch.weightTuples > 0 then
        local num2 = math.floor(num1 / 100 * self.weightedSketch.totalWeight)
        local num3 = 0
        for _, value in self.weightedSketch.weightTuples do
            num3 += value.weight
            if num2 <= num3 then
                return value.value
            end
        end
    end

    return 0
end

return module
