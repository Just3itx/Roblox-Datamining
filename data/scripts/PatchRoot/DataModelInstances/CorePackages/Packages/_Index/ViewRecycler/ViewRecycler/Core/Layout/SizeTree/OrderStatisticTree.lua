-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local _ISizeTree = require(script.Parent.ISizeTree)
local WeightedOrderStatisticTree = require(script.Parent.WeightedOrderStatisticTree)

local module = {}

local function prefixSumUpTo(arg1, num1: number, num2: number)
    if arg1 == nil or num1 <= 0 then
        return 0
    end

    local var1 = WeightedOrderStatisticTree.nodeItemCount(arg1.left) + 1
    if num1 < var1 then
        return prefixSumUpTo(arg1.left, num1, num2)
    elseif var1 < num1 then
        return WeightedOrderStatisticTree.nodeEffectiveSum(arg1.left, num2) + ((if FFlagViewRecyclerReact084 then arg1.measuredSize or arg1.estimatedSize else arg1.measuredSize) or num2) + prefixSumUpTo(arg1.right, num1 - var1, num2)
    end
    return WeightedOrderStatisticTree.nodeEffectiveSum(arg1.left, num2) + ((if FFlagViewRecyclerReact084 then arg1.measuredSize or arg1.estimatedSize else arg1.measuredSize) or num2)
end

local function rankAtPrefixSum(arg1, num1: number, num2: number)
    if arg1 == nil then
        return 0
    end

    local var1 = WeightedOrderStatisticTree.nodeEffectiveSum(arg1.left, num2)
    if num1 < var1 then
        return rankAtPrefixSum(arg1.left, num1, num2)
    end

    local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
    local var3 = if FFlagViewRecyclerReact084 then arg1.measuredSize or arg1.estimatedSize or num2 else arg1.measuredSize or num2

    if num1 < var1 + var3 then
        return var2 + 1
    end

    local var4 = rankAtPrefixSum(arg1.right, num1 - var1 - var3, num2)
    return if var4 == 0 then 0 else var2 + 1 + var4
end

local function entryAtPrefixSum(arg1, num1: number, num2: number)
    if arg1 == nil then
        return 0, 0, 0
    end

    local var1 = WeightedOrderStatisticTree.nodeEffectiveSum(arg1.left, num2)
    if num1 < var1 then
        return entryAtPrefixSum(arg1.left, num1, num2)
    end

    local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
    local var3 = if FFlagViewRecyclerReact084 then arg1.measuredSize or arg1.estimatedSize or num2 else arg1.measuredSize or num2

    if num1 < var1 + var3 then
        return var2 + 1, var1, var3
    end

    local var4, var5, var6 = entryAtPrefixSum(arg1.right, num1 - var1 - var3, num2)
    if var4 == 0 then
        return 0, 0, 0
    end
    return var2 + 1 + var4, var1 + var3 + var5, var6
end

function module.new(num1: number?)
    local var1 = nil
    local getEstimatedItemLength = num1 or 0

    local function length() -- Luacid: Inlined by compiler; 8 call sites recovered
        return WeightedOrderStatisticTree.nodeItemCount(var1)
    end

    local function prefixSum(num3: number)
        if num3 <= 1 then
            return 0
        end

        return (prefixSumUpTo(var1, num3 - 1, getEstimatedItemLength))
    end

    local function indexAtPrefixSum(num3: number)
        local var2 = length()

        if var2 == 0 or num3 <= 0 then
            return 1
        elseif WeightedOrderStatisticTree.nodeEffectiveSum(var1, getEstimatedItemLength) <= num3 then
            return var2 + 1
        end
        return rankAtPrefixSum(var1, num3, getEstimatedItemLength)
    end

    local function getEntryAtPrefixSum(num3: number)
        local var2 = length()

        if var2 == 0 then
            return 1, 0, 0
        elseif num3 <= 0 then
            if FFlagViewRecyclerReact084 then
                return 1, 0, WeightedOrderStatisticTree.unitSizeAt(var1, 1, getEstimatedItemLength)
            end
            return 1, 0, WeightedOrderStatisticTree.measuredAt(var1, 1) or getEstimatedItemLength
        else
            local var3 = WeightedOrderStatisticTree.nodeEffectiveSum(var1, getEstimatedItemLength)
            if var3 <= num3 then
                return var2 + 1, var3, 0
            end
            return entryAtPrefixSum(var1, num3, getEstimatedItemLength)
        end
    end
    local function getSize(num3: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if num3 < 1 or length() < num3 then
            return 0
        elseif FFlagViewRecyclerReact084 then
            return WeightedOrderStatisticTree.unitSizeAt(var1, num3, getEstimatedItemLength)
        end
        return WeightedOrderStatisticTree.measuredAt(var1, num3) or getEstimatedItemLength
    end

    local function fillRange(num3: number, num4: number, tbl1)
        WeightedOrderStatisticTree.fillRangeFromNode(var1, 0, 0, num3, num4, getEstimatedItemLength, tbl1)
        for i = #tbl1, num4 - num3 + 2, -1 do
            tbl1[i] = nil
        end
    end

    local function update(num3: number, num4: number?)
        WeightedOrderStatisticTree.updateUnitAt(var1, num3, num4)
    end

    local insert = FFlagViewRecyclerReact084 and function(num3: number, num4: number?, num5: number?) -- name: insert
        var1 = WeightedOrderStatisticTree.insertUnitAt(var1, num3, num4, num5)
    end or function(num3: number, num4: number?) -- name: insert
        var1 = WeightedOrderStatisticTree.insertUnitAt(var1, num3, num4)
    end

    local function remove(num3: number)
        var1 = WeightedOrderStatisticTree.removeUnitAt(var1, num3)
    end

    local function buildFromArray(tbl1)
        local var2 = table.create(#tbl1)
        for value, measuredSize in tbl1 do
            var2[value] = { itemCount = 1, measuredSize = measuredSize }
        end
        var1 = WeightedOrderStatisticTree.buildBalanced(var2, 1, #var2)
    end

    local setItemEstimate = nil
    local buildFromMeasurements

    if FFlagViewRecyclerReact084 then
        setItemEstimate = function(num3: number, num4: number?): boolean
            if num3 < 1 or length() < num3 or WeightedOrderStatisticTree.estimatedAt(var1, num3) == num4 then
                return false
            end
            local var2 = WeightedOrderStatisticTree.measuredAt(var1, num3)
            local size = getSize(num3)
            var1 = WeightedOrderStatisticTree.removeUnitAt(var1, num3)
            var1 = WeightedOrderStatisticTree.insertUnitAt(var1, num3, var2, num4)
            return getSize(num3) ~= size
        end

        buildFromMeasurements = function(num3: number, func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
            local var2 = table.create(num3)
            for i = 1, num3 do
                local tbl1 = {
                    itemCount = 1,
                    measuredSize = func1(i),
                    estimatedSize = if func2 == nil then nil else func2(i)
                }
                var2[i] = tbl1
            end

            var1 = WeightedOrderStatisticTree.buildBalanced(var2, 1, num3)
        end
    else
        buildFromMeasurements = function(num3: number, func1: (...any) -> (...any))
            local var2 = table.create(num3)
            for i = 1, num3 do
                local tbl1 = {
                    itemCount = 1,
                    measuredSize = func1(i)
                }
                var2[i] = tbl1
            end
            var1 = WeightedOrderStatisticTree.buildBalanced(var2, 1, num3)
        end
    end

    local module2 = {
        prefixSum = prefixSum,
        indexAtPrefixSum = indexAtPrefixSum,
        entryAtPrefixSum = getEntryAtPrefixSum,
        getSize = getSize,
        fillRange = fillRange,
        update = update,
        insert = insert,
        remove = remove,
        setItemEstimate = 0,
        buildFromArray = 0,
        buildFromMeasurements = 0,
        toArray = 0,
        setEstimatedItemLength = 0,
        getEstimatedItemLength = 0,
        getMeasuredItemCount = 0,
        prefersIncremental = 0,
        length = 0,
        totalSum = 0
    }

    if not FFlagViewRecyclerReact084 then
        setItemEstimate = nil
    end

    module2.setItemEstimate = setItemEstimate
    module2.buildFromArray = buildFromArray
    module2.buildFromMeasurements = buildFromMeasurements
    function module2.toArray()
        local var2 = table.create(length())
        WeightedOrderStatisticTree.appendToArray(var1, var2, getEstimatedItemLength)
        return var2
    end
    function module2.setEstimatedItemLength(num3: number): boolean
        local bool1 = not (getEstimatedItemLength == num3)
            and (if FFlagViewRecyclerReact084 then WeightedOrderStatisticTree.nodeFixedCount else WeightedOrderStatisticTree.nodeMeasuredCount)(
                var1
            ) < length()
        getEstimatedItemLength = num3
        return bool1
    end
    function module2.getEstimatedItemLength()
        return getEstimatedItemLength
    end
    function module2.getMeasuredItemCount()
        return WeightedOrderStatisticTree.nodeMeasuredCount(var1)
    end
    function module2.prefersIncremental(num3: number): boolean
        local var2 = length()

        return not (var2 == 0) and num3 < var2 / math.log(var2, 2)
    end
    module2.length = length
    function module2.totalSum()
        return WeightedOrderStatisticTree.nodeEffectiveSum(var1, getEstimatedItemLength)
    end

    return module2
end

return module
