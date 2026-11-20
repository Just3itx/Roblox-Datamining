-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FFlagViewRecyclerReact084 = require(script:FindFirstAncestor("ViewRecycler").Flags).FFlagViewRecyclerReact084
local _ISizeTree = require(script.Parent.ISizeTree)
local WeightedOrderStatisticTree = require(script.Parent.WeightedOrderStatisticTree)

local module = {}

local var1 = nil
var1 = FFlagViewRecyclerReact084 and function(arg1, arg2): boolean -- name: isSameRun
    return arg1.measuredSize == nil and arg2.measuredSize == nil and arg1.estimatedSize == arg2.estimatedSize
end or var1

local function concatenateMergingUnmeasured(arg1, arg2)
    if arg1 == nil then
        return arg2
    end

    if arg2 == nil then
        return arg1
    end

    local var2, var3 = WeightedOrderStatisticTree.popMaximum(arg1)
    local var4, var5 = WeightedOrderStatisticTree.popMinimum(arg2)

    if not (if FFlagViewRecyclerReact084 then var1(var3, var5) else var3.measuredSize == nil and var5.measuredSize == nil) then
        return WeightedOrderStatisticTree.concatenate(
            WeightedOrderStatisticTree.join(var2, var3, nil),
            WeightedOrderStatisticTree.join(nil, var5, var4)
        )
    end

    return WeightedOrderStatisticTree.join(
        var2,
        if FFlagViewRecyclerReact084 then WeightedOrderStatisticTree.newNode(var3.itemCount + var5.itemCount, nil, var3.estimatedSize) else WeightedOrderStatisticTree.newNode(var3.itemCount + var5.itemCount, nil),
        var4
    )
end

local concatenatePieces, growUnmeasuredRun

if FFlagViewRecyclerReact084 then
    concatenatePieces = function(arg1, num1: number, arg2, num2: number, arg3, num3: number?)
        if num1 > 0 then
            arg1 = concatenateMergingUnmeasured(arg1, WeightedOrderStatisticTree.newNode(num1, nil, num3))
        end
        local var2 = concatenateMergingUnmeasured(arg1, arg2)
        if num2 > 0 then
            var2 = concatenateMergingUnmeasured(var2, WeightedOrderStatisticTree.newNode(num2, nil, num3))
        end
        return (concatenateMergingUnmeasured(var2, arg3))
    end

    growUnmeasuredRun = function(arg1, num1: number, estimatedSize: number?)
        if arg1 == nil then
            return nil, false
        end

        local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
        if num1 <= var2 then
            local left, var4 = growUnmeasuredRun(arg1.left, num1, estimatedSize)
            arg1.left = left
            if var4 then
                WeightedOrderStatisticTree.refresh(arg1)
            end
            return arg1, var4
        elseif var2 + arg1.itemCount < num1 then
            local right, var4 = growUnmeasuredRun(arg1.right, num1 - var2 - arg1.itemCount, estimatedSize)
            arg1.right = right
            if var4 then
                WeightedOrderStatisticTree.refresh(arg1)
            end
            return arg1, var4
        else
            if arg1.measuredSize ~= nil or arg1.estimatedSize ~= estimatedSize then
                return arg1, false
            end

            arg1.itemCount += 1
            WeightedOrderStatisticTree.refresh(arg1)
            return arg1, true
        end
    end
else
    concatenatePieces = function(arg1, num1: number, arg2, num2: number, arg3)
        if num1 > 0 then
            arg1 = concatenateMergingUnmeasured(arg1, WeightedOrderStatisticTree.newNode(num1, nil))
        end
        local var2 = concatenateMergingUnmeasured(arg1, arg2)
        if num2 > 0 then
            var2 = concatenateMergingUnmeasured(var2, WeightedOrderStatisticTree.newNode(num2, nil))
        end
        return (concatenateMergingUnmeasured(var2, arg3))
    end

    growUnmeasuredRun = function(arg1, num1: number)
        if arg1 == nil then
            return nil, false
        end

        local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
        if num1 <= var2 then
            local left, var4 = growUnmeasuredRun(arg1.left, num1)
            arg1.left = left
            if var4 then
                WeightedOrderStatisticTree.refresh(arg1)
            end
            return arg1, var4
        elseif var2 + arg1.itemCount < num1 then
            local right, var4 = growUnmeasuredRun(arg1.right, num1 - var2 - arg1.itemCount)
            arg1.right = right
            if var4 then
                WeightedOrderStatisticTree.refresh(arg1)
            end
            return arg1, var4
        else
            if arg1.measuredSize ~= nil then
                return arg1, false
            end

            arg1.itemCount += 1
            WeightedOrderStatisticTree.refresh(arg1)
            return arg1, true
        end
    end
end

local function shrinkUnmeasuredRun(arg1, num1: number)
    if arg1 == nil then
        return nil, false
    end

    local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
    if num1 <= var2 then
        local left, var4 = shrinkUnmeasuredRun(arg1.left, num1)
        arg1.left = left
        if var4 then
            WeightedOrderStatisticTree.refresh(arg1)
        end
        return arg1, var4
    elseif var2 + arg1.itemCount < num1 then
        local right, var4 = shrinkUnmeasuredRun(arg1.right, num1 - var2 - arg1.itemCount)
        arg1.right = right
        if var4 then
            WeightedOrderStatisticTree.refresh(arg1)
        end
        return arg1, var4
    else
        if arg1.measuredSize ~= nil or not (arg1.itemCount > 1) then
            return arg1, false
        end

        arg1.itemCount -= 1
        WeightedOrderStatisticTree.refresh(arg1)
        return arg1, true
    end
end

local function mergeAdjacentUnmeasured(arg1)
    if arg1.measuredSize == nil then
        if arg1.left ~= nil then
            local left, var3 = WeightedOrderStatisticTree.popMaximum(arg1.left)
            if if FFlagViewRecyclerReact084 then var1(arg1, var3) else var3.measuredSize == nil then
                arg1.itemCount += var3.itemCount
                arg1.left = left
            else
                arg1.left = WeightedOrderStatisticTree.join(left, var3, nil)
            end
        end
        if arg1.right ~= nil then
            local right, var3 = WeightedOrderStatisticTree.popMinimum(arg1.right)
            if if FFlagViewRecyclerReact084 then var1(arg1, var3) else var3.measuredSize == nil then
                arg1.itemCount += var3.itemCount
                arg1.right = right
            else
                arg1.right = WeightedOrderStatisticTree.join(nil, var3, right)
            end
        end
    end
    return WeightedOrderStatisticTree.balance(arg1)
end

local function measureAt(arg1, num1: number, measuredSize: number)
    if arg1 == nil then
        return nil
    end

    local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
    if num1 <= var2 then
        arg1.left = measureAt(arg1.left, num1, measuredSize)
        return mergeAdjacentUnmeasured(arg1)
    elseif var2 + arg1.itemCount < num1 then
        arg1.right = measureAt(arg1.right, num1 - var2 - arg1.itemCount, measuredSize)
        return mergeAdjacentUnmeasured(arg1)
    elseif arg1.itemCount == 1 then
        arg1.measuredSize = measuredSize
        return mergeAdjacentUnmeasured(arg1)
    else
        local var3 = num1 - var2

        if FFlagViewRecyclerReact084 then
            return concatenatePieces(
                arg1.left,
                var3 - 1,
                WeightedOrderStatisticTree.newNode(1, measuredSize, arg1.estimatedSize),
                arg1.itemCount - var3,
                arg1.right,
                arg1.estimatedSize
            )
        end
        return concatenatePieces(
            arg1.left,
            var3 - 1,
            WeightedOrderStatisticTree.newNode(1, measuredSize),
            arg1.itemCount - var3,
            arg1.right
        )
    end
end

local function unmeasureAt(arg1, num1: number)
    if arg1 == nil then
        return nil
    end

    local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
    if num1 <= var2 then
        arg1.left = unmeasureAt(arg1.left, num1)
    elseif var2 + arg1.itemCount < num1 then
        arg1.right = unmeasureAt(arg1.right, num1 - var2 - arg1.itemCount)
    else
        assert(arg1.itemCount == 1, "CollapsedEstimatedTree: unmeasure requires a unit node")
        arg1.measuredSize = nil
    end
    return mergeAdjacentUnmeasured(arg1)
end

local insertMeasuredAt

if FFlagViewRecyclerReact084 then
    insertMeasuredAt = function(arg1, num1: number, num2: number, num3: number?)
        if arg1 == nil then
            return WeightedOrderStatisticTree.newNode(1, num2, num3)
        end

        local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
        if num1 <= var2 then
            arg1.left = insertMeasuredAt(arg1.left, num1, num2, num3)
            return mergeAdjacentUnmeasured(arg1)
        end

        if var2 + arg1.itemCount < num1 then
            arg1.right = insertMeasuredAt(arg1.right, num1 - var2 - arg1.itemCount, num2, num3)
            return mergeAdjacentUnmeasured(arg1)
        end

        if arg1.measuredSize == nil then
            local var3 = num1 - var2
            return concatenatePieces(
                arg1.left,
                var3 - 1,
                WeightedOrderStatisticTree.newNode(1, num2, num3),
                arg1.itemCount - var3 + 1,
                arg1.right,
                arg1.estimatedSize
            )
        end

        local left = arg1.left
        local right = arg1.right
        arg1.left = nil
        arg1.right = nil
        WeightedOrderStatisticTree.refresh(arg1)
        return concatenatePieces(
            left,
            0,
            WeightedOrderStatisticTree.newNode(1, num2, num3),
            0,
            WeightedOrderStatisticTree.concatenate(arg1, right)
        )
    end
else
    insertMeasuredAt = function(arg1, num1: number, num2: number)
        if arg1 == nil then
            return WeightedOrderStatisticTree.newNode(1, num2)
        end

        local var2 = WeightedOrderStatisticTree.nodeItemCount(arg1.left)
        if num1 <= var2 then
            arg1.left = insertMeasuredAt(arg1.left, num1, num2)
            return mergeAdjacentUnmeasured(arg1)
        end

        if var2 + arg1.itemCount < num1 then
            arg1.right = insertMeasuredAt(arg1.right, num1 - var2 - arg1.itemCount, num2)
            return mergeAdjacentUnmeasured(arg1)
        end

        if arg1.measuredSize == nil then
            local var3 = num1 - var2
            return concatenatePieces(
                arg1.left,
                var3 - 1,
                WeightedOrderStatisticTree.newNode(1, num2),
                arg1.itemCount - var3 + 1,
                arg1.right
            )
        end

        local left = arg1.left
        local right = arg1.right
        arg1.left = nil
        arg1.right = nil
        WeightedOrderStatisticTree.refresh(arg1)
        return concatenatePieces(
            left,
            0,
            WeightedOrderStatisticTree.newNode(1, num2),
            0,
            WeightedOrderStatisticTree.concatenate(arg1, right)
        )
    end
end

function module.new(num1: number?)
    local var2 = nil
    local getEstimatedItemLength = num1 or 0

    local function length() -- Luacid: Inlined by compiler; 12 call sites recovered
        return WeightedOrderStatisticTree.nodeItemCount(var2)
    end

    local function prefixSum(num3: number)
        if num3 <= 1 then
            return 0
        end

        return (WeightedOrderStatisticTree.prefixSumUpTo(var2, num3 - 1, getEstimatedItemLength))
    end

    local function indexAtPrefixSum(num3: number)
        local var3 = length()

        if var3 == 0 or num3 <= 0 then
            return 1
        elseif WeightedOrderStatisticTree.nodeEffectiveSum(var2, getEstimatedItemLength) <= num3 then
            return var3 + 1
        end
        return (WeightedOrderStatisticTree.entryAtPrefixSum(var2, num3, getEstimatedItemLength))
    end

    local function getEntryAtPrefixSum(num3: number)
        local var3 = length()

        if var3 == 0 then
            return 1, 0, 0
        elseif num3 <= 0 then
            if FFlagViewRecyclerReact084 then
                return 1, 0, WeightedOrderStatisticTree.unitSizeAt(var2, 1, getEstimatedItemLength)
            end
            return 1, 0, WeightedOrderStatisticTree.measuredAt(var2, 1) or getEstimatedItemLength
        else
            local var4 = WeightedOrderStatisticTree.nodeEffectiveSum(var2, getEstimatedItemLength)
            if var4 <= num3 then
                return var3 + 1, var4, 0
            end
            return WeightedOrderStatisticTree.entryAtPrefixSum(var2, num3, getEstimatedItemLength)
        end
    end
    local function getSize(num3: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        if num3 < 1 or length() < num3 then
            return 0
        elseif FFlagViewRecyclerReact084 then
            return WeightedOrderStatisticTree.unitSizeAt(var2, num3, getEstimatedItemLength)
        end
        return WeightedOrderStatisticTree.measuredAt(var2, num3) or getEstimatedItemLength
    end

    local function fillRange(num3: number, num4: number, tbl1)
        WeightedOrderStatisticTree.fillRangeFromNode(var2, 0, 0, num3, num4, getEstimatedItemLength, tbl1)
        for i = #tbl1, num4 - num3 + 2, -1 do
            tbl1[i] = nil
        end
    end

    local function update(num3: number, num4: number?)
        if num3 < 1 or length() < num3 then
            return
        end
        local var3 = WeightedOrderStatisticTree.measuredAt(var2, num3)
        if var3 ~= nil and num4 ~= nil then
            var2 = WeightedOrderStatisticTree.updateAt(var2, num3, num4)
        elseif var3 == nil and num4 ~= nil then
            var2 = measureAt(var2, num3, num4)
        elseif var3 ~= nil and num4 == nil then
            var2 = unmeasureAt(var2, num3)
        end
    end

    local insert = FFlagViewRecyclerReact084 and function(num3: number, num4: number?, num5: number?) -- name: insert
        local var3 = length()

        if var3 == 0 then
            var2 = WeightedOrderStatisticTree.newNode(1, num4, num5)
            return
        end
        if num4 ~= nil then
            var2 = insertMeasuredAt(var2, num3, num4, num5)
            return
        end

        if num3 <= var3 then
            local var4, var5 = growUnmeasuredRun(var2, num3, num5)
            var2 = var4
            if var5 then
                return
            end
        end
        if num3 > 1 then
            local var4, var5 = growUnmeasuredRun(var2, num3 - 1, num5)
            var2 = var4
            if var5 then
                return
            end
        end
        local var4, var5 = WeightedOrderStatisticTree.splitByItems(var2, num3 - 1)
        var2 = concatenateMergingUnmeasured(concatenateMergingUnmeasured(var4, WeightedOrderStatisticTree.newNode(1, nil, num5)), var5)
    end or function(num3: number, num4: number?) -- name: insert
        local var3 = length()

        if var3 == 0 then
            var2 = WeightedOrderStatisticTree.newNode(1, num4)
            return
        end
        if num4 ~= nil then
            var2 = insertMeasuredAt(var2, num3, num4)
            return
        end

        if num3 <= var3 then
            local var4, var5 = growUnmeasuredRun(var2, num3)
            var2 = var4
            if var5 then
                return
            end
        end
        if num3 > 1 then
            local var4, var5 = growUnmeasuredRun(var2, num3 - 1)
            var2 = var4
            if var5 then
                return
            end
        end
        local var4, var5 = WeightedOrderStatisticTree.splitByItems(var2, num3 - 1)
        var2 = concatenateMergingUnmeasured(concatenateMergingUnmeasured(var4, WeightedOrderStatisticTree.newNode(1, nil)), var5)
    end

    local function remove(num3: number)
        if num3 < 1 or length() < num3 then
            return
        end

        local var3, var4 = shrinkUnmeasuredRun(var2, num3)
        var2 = var3
        if var4 then
            return
        end
        local var5, var6 = WeightedOrderStatisticTree.splitByItems(var2, num3 - 1)
        local _, var7 = WeightedOrderStatisticTree.splitByItems(var6, 1)
        var2 = concatenateMergingUnmeasured(var5, var7)
    end

    local setItemEstimate = nil
    local buildFromMeasurements

    if FFlagViewRecyclerReact084 then
        setItemEstimate = function(num3: number, num4: number?): boolean
            if num3 < 1 or length() < num3 or WeightedOrderStatisticTree.estimatedAt(var2, num3) == num4 then
                return false
            end
            local var3 = WeightedOrderStatisticTree.measuredAt(var2, num3)
            local size = getSize(num3)
            remove(num3)
            insert(num3, var3, num4)
            return getSize(num3) ~= size
        end

        buildFromMeasurements = function(num3: number, func1: (...any) -> (...any), func2: ((...any) -> (...any))?)
            local tbl1 = {}
            for i = 1, num3 do
                local measuredSize = func1(i)
                local estimatedSize = if func2 == nil then nil else func2(i)
                local var5 = tbl1[#tbl1]
                if measuredSize == nil and var5 ~= nil and var5.measuredSize == nil and var5.estimatedSize == estimatedSize then
                    var5.itemCount += 1
                else
                    table.insert(tbl1, { itemCount = 1, measuredSize = measuredSize, estimatedSize = estimatedSize })
                end
            end
            var2 = WeightedOrderStatisticTree.buildBalanced(tbl1, 1, #tbl1)
        end
    else
        buildFromMeasurements = function(num3: number, func1: (...any) -> (...any))
            local tbl1 = {}
            for i = 1, num3 do
                local measuredSize = func1(i)
                local var4 = tbl1[#tbl1]
                if measuredSize == nil and var4 ~= nil and var4.measuredSize == nil then
                    var4.itemCount += 1
                else
                    table.insert(tbl1, { itemCount = 1, measuredSize = measuredSize })
                end
            end
            var2 = WeightedOrderStatisticTree.buildBalanced(tbl1, 1, #tbl1)
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
        totalSum = 0,
        getNodeCount = 0
    }

    if not FFlagViewRecyclerReact084 then
        setItemEstimate = nil
    end

    module2.setItemEstimate = setItemEstimate
    function module2.buildFromArray(tbl1)
        local var3 = table.create(#tbl1)
        for value, measuredSize in tbl1 do
            var3[value] = { itemCount = 1, measuredSize = measuredSize }
        end
        var2 = WeightedOrderStatisticTree.buildBalanced(var3, 1, #var3)
    end
    module2.buildFromMeasurements = buildFromMeasurements
    function module2.toArray()
        local var3 = table.create(length())
        WeightedOrderStatisticTree.appendToArray(var2, var3, getEstimatedItemLength)
        return var3
    end
    function module2.setEstimatedItemLength(num3: number): boolean
        local bool1 = not (getEstimatedItemLength == num3)
            and (if FFlagViewRecyclerReact084 then WeightedOrderStatisticTree.nodeFixedCount else WeightedOrderStatisticTree.nodeMeasuredCount)(
                var2
            ) < length()
        getEstimatedItemLength = num3
        return bool1
    end
    function module2.getEstimatedItemLength()
        return getEstimatedItemLength
    end
    function module2.getMeasuredItemCount()
        return WeightedOrderStatisticTree.nodeMeasuredCount(var2)
    end
    function module2.prefersIncremental(num3: number): boolean
        local var3 = length()

        if var3 == 0 then
            return false
        end
        return num3 * math.log(math.max(WeightedOrderStatisticTree.nodeCount(var2), 2), 2) < var3
    end
    module2.length = length
    function module2.totalSum()
        return WeightedOrderStatisticTree.nodeEffectiveSum(var2, getEstimatedItemLength)
    end
    function module2.getNodeCount()
        return WeightedOrderStatisticTree.nodeCount(var2)
    end

    return module2
end

return module
