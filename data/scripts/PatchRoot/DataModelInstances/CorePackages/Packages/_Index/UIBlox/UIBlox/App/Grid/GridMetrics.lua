-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local t = require(scriptParentParentParentParent.t)

local function getItemMetrics(arg1, arg2, arg3) -- Luacid: Inlined by compiler; 1 call site recovered
    local num1 = math.floor((arg1 + arg2) / (arg3.minimumItemWidth + arg2))
    local itemsPerRow = math.max(arg3.minimumItemsPerRow, num1)
    return {
        itemsPerRow = itemsPerRow,
        itemWidth = math.floor((arg1 - (itemsPerRow - 1) * arg2) / itemsPerRow)
    }
end

local module = {}

local var1 = t.strictInterface({ minimumItemsPerRow = t.intersection(t.integer, t.numberMin(1)), minimumItemWidth = t.numberMin(0) })

local var2 = t.tuple(t.numberMin(0), t.number)

function module.makeCustomMetricsGetter(arg1)
    assert(var1(arg1))

    return function(arg2, arg3)
        assert(var2(arg2, arg3))
        return getItemMetrics(arg2, arg3, arg1)
    end
end

module.getLargeMetrics = module.makeCustomMetricsGetter({ minimumItemsPerRow = 1, minimumItemWidth = 332 })
module.getMediumMetrics = module.makeCustomMetricsGetter({ minimumItemsPerRow = 2, minimumItemWidth = 160 })

function module.getSmallMetrics(arg1, arg2)
    local itemsPerRow = module.getMediumMetrics(arg1, arg2).itemsPerRow + 1
    return {
        itemsPerRow = itemsPerRow,
        itemWidth = math.floor((arg1 - (itemsPerRow - 1) * arg2) / itemsPerRow)
    }
end

function module.getMetricsForFixedColumns(arg1, arg2, itemsPerRow)
    return {
        itemsPerRow = itemsPerRow,
        itemWidth = math.floor((arg1 - (itemsPerRow - 1) * arg2) / itemsPerRow)
    }
end

return module
